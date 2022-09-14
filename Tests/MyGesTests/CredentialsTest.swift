//
//  CredentialsTest.swift
//  
//
//  Created by Adri on 28/04/2022.
//

import XCTest
@testable import MyGes

class CredentialsTest: XCTestCase {

    func testCredentialsError() throws {
		let credentials = Credentials(username: "", password: "")
        let s = DispatchSemaphore(value: 0)
        MyGes.login(credentials) {
            XCTAssert($0 == APIError.NotFound)
            s.signal()
        }
        s.wait()
    }
}
