import XCTest
@testable import MyGes

final class MyGesTests: XCTestCase {
    
    var lastProject: ProjectItem?
	var myGes = MyGes()
	var credentials = Credentials(username: ProcessInfo.processInfo.environment["TEST_USERNAME"]!, password: ProcessInfo.processInfo.environment["TEST_PWD"]!)
    
    override func setUpWithError() throws {
		APIService.shared.credentials = credentials
	}
    
    func testLogin() throws {
        let s = DispatchSemaphore(value: 0)
		MyGes.login(credentials) {
            XCTAssert($0 == nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetYears() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getLastYear {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetLastYear() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getLastYear {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetProfile() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getProfile {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetAgenda() throws {
        let s = DispatchSemaphore(value: 0)
        var date = Date()
        date.add(type: .day, 30)
        MyGes.getAgenda(startDate: Date(), endDate: date) {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetAbsences() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getAbsences { _ in
            XCTAssert(true)
            s.signal()
        }
        s.wait()
    }
    
    func testGetAbsencesWithYear() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getAbsences(year: 2021) {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetGrades() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getGrades {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetGradesWithYear() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getGrades(year: 2021) {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetCourses() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getCourses {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetCoursesWithYear() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getCourses(year: 2021) {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetProjects() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getProjects {
            XCTAssert(true)
			guard let lastProject = $0?.last else {
				s.signal()
				return
			}
            self.lastProject = lastProject
            s.signal()
        }
        s.wait()
    }
    
    func testGetProjectsWithYear() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getProjects(year: 2021) {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetNextProjectSteps() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getNextProjectSteps { _ in
            XCTAssert(true)
            s.signal()
        }
        s.wait()
    }
    
    func testGetSingleProject() throws {
		guard let lastProjectId = lastProject?.project_id else { return }
        let s = DispatchSemaphore(value: 0)
		MyGes.getProject(id: lastProjectId) {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testLeaveGroup() throws {
		guard let lastProjectId = lastProject?.project_id else { return }
        let s = DispatchSemaphore(value: 0)
        MyGes.getProject(id: lastProjectId) {
            MyGes.leaveProjectGroup(($0?.rc_id)!, ($0?.project_id)!, ($0?.groups?.first?.project_group_id)!) {
                XCTAssert($0 == true)
                s.signal()
            }
        }
        s.wait()
    }
    
    func testLfJoinGroup() throws {
		guard let lastProjectId = lastProject?.project_id else { return }
        let s = DispatchSemaphore(value: 0)
        MyGes.getProject(id: lastProjectId) {
            MyGes.joinProjectGroup(($0?.rc_id)!, ($0?.project_id)!, ($0?.groups?.first?.project_group_id)!) {
                XCTAssert($0 == true)
                s.signal()
            }
        }
        s.wait()
    }
}
