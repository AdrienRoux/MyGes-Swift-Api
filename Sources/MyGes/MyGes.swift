import Foundation

public struct MyGes {
    
    public var credentials: Credentials?
    public var saveCredentials: Bool = false
    
    public func getLastYear(completion: @escaping (Int?) -> Void) {
        tryLogin {
            if $0 {
                APIService.shared.getYears {
                    completion($0?.result?.first)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public func getProfile(completion: @escaping (ProfileItem?) -> Void) {
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
    
    public func getAgenda(startDate: Date, endDate: Date, completion: @escaping ([AgendaItem]?) -> Void) {
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
    
    public func getAbsences(year: Int? = nil, completion: @escaping ([AbsenceItem]?) -> Void) {
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
    
    public func getGrades(year: Int? = nil, completion: @escaping ([GradeItem]?) -> Void) {
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
    
    public func getCourses(year: Int? = nil, completion: @escaping ([CourseItem]?) -> Void) {
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
    
    public func getProjects(year: Int? = nil, completion: @escaping ([ProjectItem]?) -> Void) {
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
    
    public func getNextProjectSteps(completion: @escaping ([ProjectStepItem]?) -> Void) {
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
    
    private func tryLogin(completion: @escaping (Bool) -> Void) {
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
