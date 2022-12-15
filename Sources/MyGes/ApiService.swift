//
//  ApiService.swift
//  MygesCalendarConverter (iOS)
//
//  Created by Adri on 18/11/2021.
//

import Foundation
import SwiftUI

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public enum APIError: Error {
    case NotFound
	case ServerError
    case HttpRequest
    case NoInternet
	case NoContent
}

public struct AccessToken {
    var accessToken: String
    var tokenType: String
    var expiresIn: String
    var scope: String
    var uid: String
}

public struct GesAuthenticationToken {
    var accessToken: String
    var tokenType: String
}

public class APIService {
    static let shared = APIService()
    var token: GesAuthenticationToken?
    
    func login(_ credentials: Credentials, completion: @escaping (Result<Bool, APIError>) -> Void) {
		let tokenCredentials = "\(credentials.username.lowercased()):\(credentials.password)".toBase64
		guard let url = URL(string: "https://authentication.kordis.fr/oauth/authorize?response_type=token&client_id=skolae-app") else {
			return completion(.failure(.HttpRequest))
		}
		var request = URLRequest(url: url)
		request.addValue("Basic \(tokenCredentials)", forHTTPHeaderField: "Authorization")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			guard let _ = data, let response = response as? HTTPURLResponse, error == nil else {
				if error.debugDescription.contains("Code=-1009") {
					return completion(.failure(.NoInternet))
				} else {
					guard let error = error else {
						completion(.failure(.HttpRequest))
						return
					}
					MyGes.shared.credentials = credentials
					guard let errorToken = self.convertErrorToAccessToken(error as NSError) else { return completion(.failure(.HttpRequest))}
					self.token = GesAuthenticationToken(accessToken: errorToken.accessToken, tokenType: errorToken.tokenType)
					return completion(.success(true))
				}
			}
			
			if (500 ... 511).contains(response.statusCode) {
				completion(.failure(.ServerError))
				return
			}
			
			completion(.failure(.NotFound))
		}.resume()
    }
	
	private func convertErrorToAccessToken(_ error: NSError) -> AccessToken? {
		guard let accessUrl = error.userInfo["NSErrorFailingURLStringKey"] as? String else { return nil }
		
		var urlElements = (accessUrl as NSString).components(separatedBy: "&")
		
		urlElements[0] = urlElements[0].components(separatedBy: "#")[1]
		
		for i in 0..<urlElements.count { urlElements[i] = urlElements[i].components(separatedBy: "=")[1] }
		
		return AccessToken(accessToken: urlElements[0], tokenType: urlElements[1], expiresIn: urlElements[2], scope: urlElements[3], uid: "")
	}
	
	func getProfilePictureLink(completion: @escaping (String?) -> Void) {
		getAuthPageToken { [weak self] in
			if let token = $0, !token.isEmpty {
				self?.getCAS(token) {
					if let cas = $0 {
						self?.getLinkFromCAS(cas) { link in
							completion(link)
						}
					} else {
						completion(nil)
					}
				}
			} else {
				completion(nil)
			}
		}
	}
    
    private func getAuthPageToken(completion: @escaping ([String: String]?) -> Void) {
        self.request("POST", "https://ges-cas.kordis.fr/login", [:], false) { (result : Result<Data, APIError>) in
            switch result {
            case .success(let success):
				var result = [String: String]()
				guard let html = String(data: success, encoding: .utf8) else { return completion(nil) }
				
                if html.contains("name=\"lt\" value=\"") {
					result["lt"] = html.components(separatedBy: "name=\"lt\" value=\"")[1].components(separatedBy: "\"/>")[0]
                }
                if html.contains("name=\"execution\" value=\"") {
					result["execution"] = html.components(separatedBy: "name=\"execution\" value=\"")[1].components(separatedBy: "\"/>")[0]
                }
                if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == "JSESSIONID" && $0.domain == "ges-cas.kordis.fr" }) {
					result["cookie"] = "\(cookie.name)=\(cookie.value)"
                }
				
                completion(result)
                
            case .failure:
                completion(nil)
            }
        }
    }
    
    private func getCAS(_ params: [String:String], completion: @escaping ([String: String]?) -> Void) {
		guard let username = MyGes.shared.credentials?.username.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { return completion(nil) }
		guard let password = MyGes.shared.credentials?.password.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { return completion(nil) }
		guard let url = URL(string: "https://ges-cas.kordis.fr/login?service=https%3A%2F%2Fmyges.fr%2Fj_spring_cas_security_check") else { return completion(nil) }
		guard let lt = params["lt"], let execution = params["execution"] else { return completion(nil) }
		
		let parameters = "username=\(username)&password=\(password)&lt=\(lt)&execution=\(execution)&_eventId=submit"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		
        if let cookie = params["cookie"] {
            request.addValue(cookie, forHTTPHeaderField: "Cookie")
        }
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else { return completion(nil) }
            if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == "CASTGC" }) {
                var returnedParams = params
                returnedParams["cas"] = cookie.value
                completion(returnedParams)
            }
        }.resume()
    }
    
    private func getLinkFromCAS(_ params: [String: String], completion: @escaping (String?) -> Void) {
        let parameters = ""
        let postData =  parameters.data(using: .utf8)
		guard let url = URL(string: "https://ges-cas.kordis.fr/login?service=https%3A%2F%2Fmyges.fr%2Fj_spring_cas_security_check") else { return completion(nil) }
		
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("CASTGC=" + (params["cas"] ?? ""), forHTTPHeaderField: "Cookie")

        request.httpMethod = "POST"
        request.httpBody = postData

        URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else { return completion(nil) }
			guard let dataString = String(data: data, encoding: .utf8),
					dataString.components(separatedBy: "<img id=\"userinfo:photo\" src=\"").count > 1
			else { return completion(nil) }
            completion(dataString.components(separatedBy: "<img id=\"userinfo:photo\" src=\"")[1].components(separatedBy: "\" alt=\"\"")[0])
        }.resume()
    }
    
    func getYears(completion: @escaping (_ result: YearsResult?) -> Void) {
        return self.get("/me/years") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(_):
                print("There was an error fetching years")
                completion(nil)
            }
        }
    }
    
    func getProfile(completion: @escaping (_ result: ProfileResult?) -> Void) {
        return self.get("/me/profile") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(_):
                print("There was an error fetching profile")
                completion(nil)
            }
        }
    }
    
    func getAgenda(_ start: Date, _ end: Date, completion: @escaping(_ result : AgendaResult?) -> Void) {
        self.get("/me/agenda?start=\(start.millisecondsSince1970)&end=\(end.millisecondsSince1970)") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(_):
                print("There was an error fetching agenda")
                completion(nil)
            }
        }
    }
    
    func getAbsences(_ year: String, completion: @escaping (_ result: AbsenceResult?) -> Void) {
        return self.get("/me/\(year)/absences") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(let error):
				if error == .NoContent {
					print("There is no absences.")
					completion(AbsenceResult(result: []))
				} else {
					print("There was an error fetching absences")
					completion(nil)
				}
            }
        }
    }
    
    func getGrades(_ year: String, completion: @escaping (_ result: GradesResult?) -> Void ){
        return self.get("/me/\(year)/grades") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(_):
                print("There was an error fetching grades")
                completion(nil)
            }
        }
    }
    
    func getCourses(_ year: String, completion: @escaping (_ result: CoursesResult?) -> Void) {
        return self.get("/me/\(year)/courses") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(_):
                print("There was an error fetching courses")
                completion(nil)
            }
        }
    }
    
    func getProjects(_ year: String, completion: @escaping (_ result: ProjectsResult?) -> Void) {
        return self.get("/me/\(year)/projects") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(let error):
				if error == .NoContent {
					print("There is no projects.")
					completion(ProjectsResult(result: []))
				} else {
					print("There was an error fetching projects")
					completion(nil)
				}
            }
        }
    }
    
    func getNextProjectSteps(completion: @escaping (_ result: ProjectStepsResult?) -> Void) {
        return self.get("/me/nextProjectSteps") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(let error):
				if error == .NoContent {
					print("There is no steps.")
					completion(ProjectStepsResult(result: []))
				} else {
					print("There was an error fetching next project steps")
					completion(nil)
				}
            }
        }
    }
    
    func getProject(projectId: Int, completion: @escaping (_ result: ProjectResult?) -> Void) {
        return self.get("/me/projects/\(projectId)") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass())
            case .failure(_):
                print("There was an error fetching next project steps")
                completion(nil)
            }
        }
    }
    
    func joinProjectGroup(_ projectRcId: Int, _ projectId: Int, _ projectGroupId: Int, completion: @escaping (Bool) -> Void) {
        self.post("/me/courses/\(projectRcId)/projects/\(projectId)/groups/\(projectGroupId)") {
            switch $0 {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func quitProjectGroup(_ projectRcId: Int, _ projectId: Int, _ projectGroupId: Int, completion: @escaping (Bool) -> Void) {
        self.delete("/me/courses/\(projectRcId)/projects/\(projectId)/groups/\(projectGroupId)") {
            switch $0 {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    //    func getProjectGroupMessages(_ projectGroupId: Int) {
    //        return self.get("/me/projectGroups/\(projectGroupId)/messages")
    //    }
    
    //    func sendProjectGroupMessage(_ projectGroupId: Int, _ message: String) {
    //        return self.post("/me/projectGroups/\(projectGroupId)/messages", ["projectGroupId":  projectGroupId, "message": message])
    //    }
	
	private func request(_ method: String, _ urlString: String, _ parameters: [String: Any] = [:], _ isKordisApi : Bool = true, completion: @escaping(Result<Data, APIError>) -> Void) {
		if (token != nil && isKordisApi) ||  !isKordisApi {
			let url = URL(string: (isKordisApi ? "https://api.kordis.fr" : "") +  "\(urlString)")!
			var request = URLRequest(url: url)
			
			request.httpMethod = method
			if isKordisApi {
				request.addValue("\(token!.tokenType) \(token!.accessToken)", forHTTPHeaderField: "Authorization")
			}
			
			if method == "POST" {
				request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
				request.httpBody = parameters.percentEncoded()
			}
			
			URLSession.shared.dataTask(with: request) { data, response, error in
				guard let data = data, let response = response as? HTTPURLResponse, error == nil else {// check for fundamental networking error
					completion(.failure(.HttpRequest))
					return
				}
				
				guard (200 ... 299) ~= response.statusCode else { // check for http errors
					completion(.failure(.HttpRequest))
					return
				}
				
				if response.statusCode == 204 {
					completion(.failure(.NoContent))
					return
				}
				completion(.success(data))
			}.resume()
		} else {
			completion(.failure(.NoInternet))
		}
	}
    
    private func get(_ url: String, completion: @escaping(Result<Data, APIError>) -> Void) {
        self.request("GET", url) { result in
            completion(result)
        }
    }
    
    private func post(_ url: String, _ parameters: [String: Any] = [:], completion: @escaping(Result<Data, APIError>) -> Void) {
        self.request("POST", url, parameters) { result in
            completion(result)
        }
    }
    
    private func put(_ url: String, _ parameters: [String: Any] = [:], completion: @escaping(Result<Data, APIError>) -> Void) {
        self.request("PUT", url, parameters) { result in
            completion(result)
        }
    }
    
    private func delete(_ url: String, completion: @escaping(Result<Data, APIError>) -> Void) {
        self.request("DELETE", url) { result in
            completion(result)
        }
    }
}
