import XCTest
@testable import MyGes

final class MyGesTests: XCTestCase {
    
    var lastProject: ProjectItem?
    
    override func setUpWithError() throws {
        MyGes.credentials = Credentials(username: ProcessInfo.processInfo.environment["TEST_USERNAME"]!, password: ProcessInfo.processInfo.environment["TEST_PWD"]!)
    }
    
    func testLogin() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.login {
            XCTAssert($0 == nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetLastYear() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getLastYear {
            XCTAssert($0 == 2021)
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
        MyGes.getAbsences {
            XCTAssert($0 != nil)
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
            XCTAssert($0 != nil)
            self.lastProject = $0?.last
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
        MyGes.getNextProjectSteps {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testGetSingleProject() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getProject(id: 10302) {
            XCTAssert($0 != nil)
            s.signal()
        }
        s.wait()
    }
    
    func testLeaveGroup() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getProject(id: 10302) {
            MyGes.leaveProjectGroup(($0?.rc_id)!, ($0?.project_id)!, ($0?.groups?.first?.project_group_id)!) {
                XCTAssert($0 == true)
                s.signal()
            }
        }
        s.wait()
    }
    
    func testLfJoinGroup() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.getProject(id: 10302) {
            MyGes.joinProjectGroup(($0?.rc_id)!, ($0?.project_id)!, ($0?.groups?.first?.project_group_id)!) {
                XCTAssert($0 == true)
                s.signal()
            }
        }
        s.wait()
    }
}
