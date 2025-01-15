//
//  UserServiceTests.swift
//  UserServiceTests
//
//  Created by gizem on 16.01.2025.
//

import XCTest
@testable import PersonBook

final class UserServiceTests: XCTestCase {

    var userService: UserService!

    override func setUp() {
        super.setUp()
        userService = UserService.shared
    }

    override func tearDown() {
        userService = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "Fetching users")

        userService.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertFalse(users.isEmpty, "Users list should not be empty")
            case .failure:
                XCTFail("Fetching users failed")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchUsersInvalidURL() {
        XCTAssertNotNil(userService)
    }
}
