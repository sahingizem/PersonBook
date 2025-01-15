//
//  UserListViewModelTests.swift
//  UserListViewModelTests
//
//  Created by gizem on 16.01.2025.
//

import XCTest
@testable import PersonBook

final class UserListViewModelTests: XCTestCase {

    var viewModel: UserListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = UserListViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "Fetching users")

        viewModel.fetchUsers { success in
            XCTAssertTrue(success, "User fetch should succeed")
            XCTAssertGreaterThan(self.viewModel.numberOfUsers, 0, "There should be at least one user")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetUser() {
        let user = User(id: 1, name: "Test User", username: "testuser", email: "test@example.com", phone: nil, website: nil, address: nil)
        viewModel.fetchUsers { _ in }
        viewModel.users = [user] //Injecting a mock user


        let fetchedUser = viewModel.getUser(at: 0)
        XCTAssertEqual(fetchedUser.name, "Test User")
    }
}
