import Foundation

public struct MyGes {
	public static func login(_ credentials: Credentials, completion: @escaping (APIError?) -> Void) {
		APIService.shared.login(credentials) {
			switch $0 {
			case .success:
				APIService.shared.credentials = credentials
				completion(nil)
			case .failure(let error):
				completion(error)
			}
		}
    }
	
	private static func tryLogin(completion: @escaping (Bool) -> Void) {
		guard let credentials = APIService.shared.credentials else {
			print("You must go through login.")
			return completion(false)
		}
		
		APIService.shared.login(credentials) { result in
			switch result {
			case .success:
				completion(true)
			case .failure:
				completion(false)
			}
		}
	}
    
    public static func getYears(completion: @escaping ([Int]?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getYears {
				guard let years = $0 else { return completion(nil) }
				completion(years.result)
			}
        }
    }
    
    public static func getLastYear(completion: @escaping (Int?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getYears {
				guard let years = $0 else { return completion(nil) }
				let formatter = DateFormatter()
				formatter.dateFormat = "yyyy/MM/dd HH:mm"
				guard let firstSeptember = formatter.date(from: Date.currentYear + "/09/01 00:00") else { return completion(nil) }
				if Date().millisecondsSince1970 < firstSeptember.millisecondsSince1970 {
					if let years = years.result {
						if years.count >= 2 {
							completion(years[1])
						} else {
							completion(years.first)
						}
					} else {
						completion(nil)
					}
				} else {
					completion(years.result?.first)
				}
			}
        }
    }
    
    public static func getProfile(completion: @escaping (ProfileItem?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getProfile {
				completion($0?.result)
			}
        }
    }
    
    public static func getAgenda(startDate: Date, endDate: Date, completion: @escaping ([AgendaItem]?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getAgenda(startDate, endDate) {
				completion($0?.result)
			}
        }
    }
    
    public static func getAbsences(year: Int? = nil, completion: @escaping ([AbsenceItem]?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			if let year = year {
				APIService.shared.getAbsences(year.description) {
					guard let absences = $0 else { return completion(nil) }
					return completion(absences.result)
				}
			} else {
				getLastYear {
					guard let lastYear = $0 else { return completion(nil) }
					APIService.shared.getAbsences(lastYear.description) {
						guard let absences = $0 else { return completion(nil) }
						return completion(absences.result)
					}
				}
			}
        }
    }
    
    public static func getGrades(year: Int? = nil, completion: @escaping ([GradeItem]?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			if let year = year {
				APIService.shared.getGrades(year.description) {
					guard let grades = $0 else { return completion(nil) }
					return completion(grades.result)
				}
			} else {
				getLastYear {
					guard let lastYear = $0 else { return completion(nil) }
					APIService.shared.getGrades(lastYear.description) {
						guard let grades = $0 else { return completion(nil) }
						return completion(grades.result)
					}
				}
			}
        }
    }
    
    public static func getCourses(year: Int? = nil, completion: @escaping ([CourseItem]?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			if let year = year {
				APIService.shared.getCourses(year.description) {
					guard let courses = $0 else { return completion(nil) }
					return completion(courses.result)
				}
			} else {
				getLastYear {
					guard let lastYear = $0 else { return completion(nil) }
					APIService.shared.getCourses(lastYear.description) {
						guard let courses = $0 else { return completion(nil) }
						return completion(courses.result)
					}
				}
			}
        }
    }
    
    public static func getProjects(year: Int? = nil, completion: @escaping ([ProjectItem]?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			if let year = year {
				APIService.shared.getProjects(year.description) {
					guard let projects = $0 else { return completion(nil) }
					completion(projects.result)
				}
			} else {
				getLastYear {
					guard let lastYear = $0 else { return completion(nil) }
					APIService.shared.getProjects(lastYear.description) {
						guard let projects = $0 else { return completion(nil) }
						completion(projects.result)
					}
				}
			}
        }
    }
    
    public static func getNextProjectSteps(completion: @escaping ([ProjectStepItem]?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getNextProjectSteps {
				guard let steps = $0 else { return completion(nil) }
				completion(steps.result)
			}
        }
    }
    
    public static func getProject(id: Int, completion: @escaping (ProjectItem?) -> Void) {
        tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getProject(projectId: id) {
				guard let project = $0 else { return completion(nil) }
				completion(project.result)
			}
        }
    }
    
    public static func joinProjectGroup(_ projectRcId: Int, _ projectId: Int, _ projectGroupId: Int, completion: @escaping (Bool) -> Void) {
        tryLogin {
			guard $0 else { return completion(false) }
			APIService.shared.joinProjectGroup(projectRcId, projectId, projectGroupId) {
				completion($0)
			}
        }
    }
    
    public static func leaveProjectGroup(_ projectRcId: Int, _ projectId: Int, _ projectGroupId: Int, completion: @escaping (Bool) -> Void) {
        tryLogin {
			guard $0 else { return completion(false) }
			APIService.shared.quitProjectGroup(projectRcId, projectId, projectGroupId) {
				completion($0)
			}
        }
    }
    
	public static func getProfilePicLink(completion: @escaping (String?) -> Void) {
        APIService.shared.getProfilePictureLink { completion($0) }
    }
}
