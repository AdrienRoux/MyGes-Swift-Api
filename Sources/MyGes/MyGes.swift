import Foundation

public struct MyGes {
	public static var shared = MyGes()
	public var credentials: Credentials?
	
	private func tryLogin(completion: @escaping (Bool) -> Void) {
		guard let credentials = MyGes.shared.credentials else {
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
}

public extension MyGes {
	func login(_ credentials: Credentials, completion: @escaping (APIError?) -> Void) {
		APIService.shared.login(credentials) {
			switch $0 {
			case .success:
				MyGes.shared.credentials = credentials
				completion(nil)
			case .failure(let error):
				completion(error)
			}
		}
	}
	
	func getYears(completion: @escaping ([Int]?) -> Void) {
		tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getYears {
				guard let years = $0 else { return completion(nil) }
				completion(years.result)
			}
		}
	}
	
	func getLastYear(completion: @escaping (Int?) -> Void) {
		tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getYears {
				guard let lastYear = $0?.result?.first else { return completion(nil) }
				if let currentMonth = Int(Date.currentMonth), currentMonth < 09 && lastYear == Int(Date.currentYear) {
					return completion(lastYear - 1)
				} else {
					return completion(lastYear)
				}
			}
		}
	}
	
	func getProfile(completion: @escaping (ProfileItem?) -> Void) {
		tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getProfile {
				completion($0?.result)
			}
		}
	}
	
	func getAgenda(startDate: Date, endDate: Date, completion: @escaping ([AgendaItem]?) -> Void) {
		tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getAgenda(startDate, endDate) {
				completion($0?.result)
			}
		}
	}
	
	func getAbsences(year: Int? = nil, completion: @escaping ([AbsenceItem]?) -> Void) {
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
	
	func getGrades(year: Int? = nil, completion: @escaping ([GradeItem]?) -> Void) {
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
	
	func getCourses(year: Int? = nil, completion: @escaping ([CourseItem]?) -> Void) {
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
	
	func getProjects(year: Int? = nil, completion: @escaping ([ProjectItem]?) -> Void) {
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
	
	func getNextProjectSteps(completion: @escaping ([ProjectStepItem]?) -> Void) {
		tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getNextProjectSteps {
				guard let steps = $0 else { return completion(nil) }
				completion(steps.result)
			}
		}
	}
	
	func getProject(id: Int, completion: @escaping (ProjectItem?) -> Void) {
		tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getProject(projectId: id) {
				guard let project = $0 else { return completion(nil) }
				completion(project.result)
			}
		}
	}
	
	func joinProjectGroup(_ projectRcId: Int, _ projectId: Int, _ projectGroupId: Int, completion: @escaping (Bool) -> Void) {
		tryLogin {
			guard $0 else { return completion(false) }
			APIService.shared.joinProjectGroup(projectRcId, projectId, projectGroupId) {
				completion($0)
			}
		}
	}
	
	func leaveProjectGroup(_ projectRcId: Int, _ projectId: Int, _ projectGroupId: Int, completion: @escaping (Bool) -> Void) {
		tryLogin {
			guard $0 else { return completion(false) }
			APIService.shared.quitProjectGroup(projectRcId, projectId, projectGroupId) {
				completion($0)
			}
		}
	}
	
	func getProfilePicLink(completion: @escaping (String?) -> Void) {
		tryLogin {
			guard $0 else { return completion(nil) }
			APIService.shared.getProfilePictureLink { completion($0) }
		}
	}
}
