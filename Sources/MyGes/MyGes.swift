import Foundation

@available(macOS 10.15, *)
public class MyGes: ObservableObject {
    public static var credentials: Credentials?
    public static var saveCredentials: Bool = false
    
    public static func login(_ credentials: Credentials? = MyGes.credentials, saveCredentials: Bool = false, completion: @escaping (APIError?) -> Void) {
        if credentials != nil {
            MyGes.credentials = credentials
            MyGes.saveCredentials = saveCredentials
            APIService.shared.login(credentials!, saveCredentials: saveCredentials) {
                switch $0 {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } else {
            print("You must fill credentials.")
            completion(APIError.NotFound)
        }
    }
    
    public static func getYears(completion: @escaping ([Int]?) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.getYears {
                    completion($0?.result)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getLastYear(completion: @escaping (Int?) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.getYears {
					let formatter = DateFormatter()
					formatter.dateFormat = "yyyy/MM/dd HH:mm"
					let firstSeptember = formatter.date(from: Date.currentYear + "/09/01 00:00") ?? Date()
					if Date().millisecondsSince1970 < firstSeptember.millisecondsSince1970 {
						if let years = $0?.result {
							if years.count >= 2 {
								completion(years[1])
							} else {
								completion(years.first)
							}
						} else {
							completion(nil)
						}
					} else {
						completion($0?.result?.first)
					}
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getProfile(completion: @escaping (ProfileItem?) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.getProfile {
                    completion($0?.result)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getAgenda(startDate: Date, endDate: Date, completion: @escaping ([AgendaItem]?) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.getAgenda(startDate, endDate) {
                    completion($0?.result)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getAbsences(year: Int? = nil, completion: @escaping ([AbsenceItem]?) -> Void) {
        tryLogin {
            if $0 {
                if year != nil {
                    APIService.shared.getAbsences(year!.description) {
                        completion($0?.result)
                    }
                } else {
                    getLastYear {
                        if $0 != nil {
                            APIService.shared.getAbsences($0!.description) {
                                completion($0?.result)
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getGrades(year: Int? = nil, completion: @escaping ([GradeItem]?) -> Void) {
        tryLogin {
            if $0 {
                if year != nil {
                    APIService.shared.getGrades(year!.description) {
                        completion($0?.result)
                    }
                } else {
                    getLastYear {
                        if $0 != nil {
                            APIService.shared.getGrades($0!.description) {
                                completion($0?.result)
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getCourses(year: Int? = nil, completion: @escaping ([CourseItem]?) -> Void) {
        tryLogin {
            if $0 {
                if year != nil {
                    APIService.shared.getCourses(year!.description) {
                        completion($0?.result)
                    }
                } else {
                    getLastYear {
                        if $0 != nil {
                            APIService.shared.getCourses($0!.description) {
                                completion($0?.result)
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getProjects(year: Int? = nil, completion: @escaping ([ProjectItem]?) -> Void) {
        tryLogin {
            if $0 {
                if year != nil {
                    APIService.shared.getProjects(year!.description) {
                        completion($0?.result)
                    }
                } else {
                    getLastYear {
                        if $0 != nil {
                            APIService.shared.getProjects($0!.description) {
                                completion($0?.result)
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getNextProjectSteps(completion: @escaping ([ProjectStepItem]?) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.getNextProjectSteps {
                    completion($0?.result)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func getProject(id: Int, completion: @escaping (ProjectItem?) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.getProject(projectId: id) {
                    completion($0?.result)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public static func joinProjectGroup(_ projectRcId: Int, _ projectId: Int, _ projectGroupId: Int, completion: @escaping (Bool) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.joinProjectGroup(projectRcId, projectId, projectGroupId) {
                    completion($0)
                }
            } else {
                completion(false)
            }
        }
    }
    
    public static func leaveProjectGroup(_ projectRcId: Int, _ projectId: Int, _ projectGroupId: Int, completion: @escaping (Bool) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.quitProjectGroup(projectRcId, projectId, projectGroupId) {
                    completion($0)
                }
            } else {
                completion(false)
            }
        }
    }
    
    public static func getProfilePicLink(completion: @escaping (String?) -> Void) {
        APIService.shared.getProfilePictureLink { completion($0) }
    }
    
    private static func tryLogin(completion: @escaping (Bool) -> Void) {
        if credentials != nil {
            APIService.shared.login(credentials!, saveCredentials: saveCredentials) { result in
                switch result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        } else {
            print("You must fill credentials.")
            completion(false)
        }
    }
}
