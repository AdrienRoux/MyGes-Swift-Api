//
//  CredentialsTest.swift
//  
//
//  Created by Adri on 28/04/2022.
//

import XCTest
@testable import MyGes

class CredentialsTest: XCTestCase {
    func testNoCredentials() throws {
        let s = DispatchSemaphore(value: 0)
        MyGes.login {
            XCTAssert($0 == APIError.NotFound)
            s.signal()
        }
        s.wait()
    }

    func testCredentialsError() throws {
        MyGes.credentials = Credentials(username: "", password: "")
        let s = DispatchSemaphore(value: 0)
        MyGes.login {
            XCTAssert($0 == APIError.NotFound)
            s.signal()
        }
        s.wait()
    }
}
