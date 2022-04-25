//
//  File.swift
//  
//
//  Created by Adri on 22/04/2022.
//

import Foundation
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

public class APIService {
    static let shared = APIService()
    
    var credentials: Credentials?
    var token: GesAuthenticationToken?
    
    enum APIError: Error {
        case NotFound
        case HttpRequest
        case NoInternet
    }
    
    struct AccessToken {
        var accessToken: String
        var tokenType: String
        var expiresIn: String
        var scope: String
        var uid: String
    }
    
    struct GesAuthenticationToken {
        var accessToken: String
        var tokenType: String
    }
    
    func login(_ credentials: Credentials, _ keepingData: Bool, completion: @escaping (Result<Bool, APIError>) -> Void) {
        generateAccessToken(credentials) { (result: Result<AccessToken, APIError>) in
            switch result {
            case .success(let receivedToken):
                self.credentials = credentials
                self.token = GesAuthenticationToken(accessToken: receivedToken.accessToken, tokenType: receivedToken.tokenType)
                
                if keepingData {
                    UserDefaults.standard.set(credentials.username, forKey: "username")
                    UserDefaults.standard.set(credentials.password, forKey: "password")
                }
                
                self.getProfilePictureLink {
                    if $0 != nil {
                        UserDefaults.standard.set($0!, forKey: "profilePicture")
                    }
                }
                
                completion(.success(true))
            case .failure (let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getAuthPageToken(completion: @escaping ([String: String]?) -> Void) {
        self.request("POST", "https://ges-cas.kordis.fr/login", [:], false) { (result : Result<Data, Error>) in
            switch result {
            case .success(let success):
                
                let html = String(data: success, encoding: .utf8)!
                var lt : String?
                if html.contains("name=\"lt\" value=\"") {
                    lt = html.components(separatedBy: "name=\"lt\" value=\"")[1].components(separatedBy: "\"/>")[0]
                }
                var execution : String?
                if html.contains("name=\"execution\" value=\"") {
                    execution = html.components(separatedBy: "name=\"execution\" value=\"")[1].components(separatedBy: "\"/>")[0]
                }
                var cookieString: String?
                if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == "JSESSIONID" && $0.domain == "ges-cas.kordis.fr" }) {
                    cookieString = "\(cookie.name)=\(cookie.value)"
                }
                completion(["lt" : lt ?? "", "execution": execution ?? "", "cookie": cookieString ?? ""])
                
            case .failure:
                completion(nil)
            }
        }
    }
    
    private func getCAS(_ params: [String:String], completion: @escaping ([String: String]?) -> Void) {
        let parameters = "username=\(credentials?.username ?? "")&password=\(credentials?.password ?? "")&lt=\(params["lt"]!)&execution=\(params["execution"]!)&_eventId=submit"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://ges-cas.kordis.fr/login?service=https%3A%2F%2Fmyges.fr%2Fj_spring_cas_security_check")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if params["cookie"] != nil {
            request.addValue(params["cookie"]!, forHTTPHeaderField: "Cookie")
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

        var request = URLRequest(url: URL(string: "https://ges-cas.kordis.fr/login?service=https%3A%2F%2Fmyges.fr%2Fj_spring_cas_security_check")!,timeoutInterval: Double.infinity)
        request.addValue("CASTGC=" + (params["cas"] ?? ""), forHTTPHeaderField: "Cookie")

        request.httpMethod = "POST"
        request.httpBody = postData

        URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else { return completion(nil) }
            let dataString = String(data: data, encoding: .utf8)!
            completion(dataString.components(separatedBy: "<img id=\"userinfo:photo\" src=\"")[1].components(separatedBy: "\" alt=\"\"")[0])
        }.resume()
    }
    
    private func getProfilePictureLink(completion: @escaping (String?) -> Void) {
        getAuthPageToken {
            if $0 != nil {
                self.getCAS($0!) {
                    if $0 != nil {
                        self.getLinkFromCAS($0!) { link in
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
    
    private func generateAccessToken(_ credentials: Credentials, completion: @escaping (Result<AccessToken, APIError>) -> Void) {
        getResultFromApi(credentials) { result in
            switch result {
            case is APIError:
                completion(.failure(result as! APIService.APIError))
            case URLError.unsupportedURL:
                completion(.success(self.convertErrorToAccessToken(result)))
            default:
                completion(.failure(APIError.NotFound))
            }
        }
    }
    
    private func getResultFromApi(_ credentials: Credentials, completion: @escaping (Error) -> Void) {
        let tokenCredentials = "\(credentials.username.lowercased()):\(credentials.password)".toBase64
        
        var request = URLRequest(url: URL(string: "https://authentication.kordis.fr/oauth/authorize?response_type=token&client_id=skolae-app")!)
        request.addValue("Basic \(tokenCredentials)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                if error.debugDescription.contains("Code=-1009") {
                    return completion(APIError.NoInternet)
                } else {
                    return completion(error!)
                }
            }
            completion(APIError.NotFound)
        }.resume()
    }
    
    func convertErrorToAccessToken(_ error: Error) -> AccessToken {
        let accessUrl = (error as NSError).userInfo["NSErrorFailingURLStringKey"]! as! String
        
        var urlElements = (accessUrl as NSString).components(separatedBy: "&")
        
        urlElements[0] = urlElements[0].components(separatedBy: "#")[1]
        
        for i in 0..<urlElements.count {
            urlElements[i] = urlElements[i].components(separatedBy: "=")[1]
        }
        
        return AccessToken(accessToken: urlElements[0], tokenType: urlElements[1], expiresIn: urlElements[2], scope: urlElements[3], uid: "")
    }
    
    func request(_ method: String, _ urlString: String, _ parameters: [String: Any] = [:], _ isKordisApi : Bool = true, completion: @escaping(Result<Data, Error>) -> Void) {
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
//                print(String(data:data ?? Data(), encoding: .utf8)!)
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {// check for fundamental networking error
                    completion(.failure(APIError.HttpRequest))
                    return
                }
                
                guard (200 ... 299) ~= response.statusCode else { // check for http errors
                    completion(.failure(APIError.HttpRequest))
                    return
                }
                completion(.success(data))
            }.resume()
        } else {
            completion(.failure(APIError.NoInternet))
        }
    }
    
    func getYears(completion: @escaping (_ result: YearsResult) -> Void) {
        return self.get("/me/years") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass() ?? YearsResult.empty())
            case .failure(_):
                print("There was an error fetching years")
            }
        }
    }
    
    func getProfile(completion: @escaping (_ result: ProfileResult) -> Void) {
        return self.get("/me/profile") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass() ?? ProfileResult.empty())
            case .failure(_):
                print("There was an error fetching profile")
                completion(ProfileResult.empty())
            }
        }
    }
    
    func getAgenda(_ start: Date, _ end: Date, completion: @escaping(_ result : AgendaResult) -> Void) {
        self.get("/me/agenda?start=\(start.millisecondsSince1970)&end=\(end.millisecondsSince1970)") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass() ?? AgendaResult.empty())
            case .failure(_):
                print("There was an error fetching agenda")
            }
        }
    }
    
    func getAbsences(_ year: String, completion: @escaping (_ result: AbsenceResult) -> Void) {
        return self.get("/me/\(year)/absences") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass() ?? AbsenceResult.empty())
            case .failure(_):
                print("There was an error fetching absences")
            }
        }
    }
    
    func getGrades(_ year: String, completion: @escaping (_ result: GradesResult) -> Void ){
        return self.get("/me/\(year)/grades") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass() ?? GradesResult.empty())
            case .failure(_):
                print("There was an error fetching grades")
            }
        }
    }
    
    func getCourses(_ year: String, completion: @escaping (_ result: CoursesResult) -> Void) {
        return self.get("/me/\(year)/courses") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass() ?? CoursesResult.empty())
            case .failure(_):
                print("There was an error fetching courses")
            }
        }
    }
    
    func getProjects(_ year: String, completion: @escaping (_ result: ProjectsResult) -> Void) {
        return self.get("/me/\(year)/projects") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass() ?? ProjectsResult.empty())
            case .failure(_):
                print("There was an error fetching projects")
            }
        }
    }
    
    func getNextProjectSteps(completion: @escaping (_ result: ProjectStepsResult) -> Void) {
        return self.get("/me/nextProjectSteps") { result in
            switch result {
            case .success(let data):
                completion(data.decodeAsClass() ?? ProjectStepsResult.empty())
            case .failure(_):
                print("There was an error fetching next project steps")
            }
        }
    }
    
    
    //    func getProject(_ id: String) {
    //        return self.get("/me/projects/\(id)") //as Project
    //    }
    
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
    
    private func get(_ url: String, completion: @escaping(Result<Data, Error>) -> Void) {
        self.request("GET", url) { result in
            completion(result)
        }
    }
    
    private func post(_ url: String, _ parameters: [String: Any] = [:], completion: @escaping(Result<Data, Error>) -> Void) {
        self.request("POST", url, parameters) { result in
            completion(result)
        }
    }
    
    private func put(_ url: String, _ parameters: [String: Any] = [:], completion: @escaping(Result<Data, Error>) -> Void) {
        self.request("PUT", url, parameters) { result in
            completion(result)
        }
    }
    
    private func delete(_ url: String, completion: @escaping(Result<Data, Error>) -> Void) {
        self.request("DELETE", url) { result in
            completion(result)
        }
    }
}