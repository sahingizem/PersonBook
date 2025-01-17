//
//  UserServiceTests.swift
//  PersonBookTests
//
//  Created by gizem on 16.01.2025.
//

import XCTest
@testable import PersonBook

final class MockNetworkManager: NetworkManagerProtocol {
    var shouldReturnError = false
    var mockData: Data?

    func request<T: Decodable>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.requestFailed))
        } else if let data = mockData {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        } else {
            completion(.failure(.invalidResponse))
        }
    }
}

final class UserServiceTests: XCTestCase {

    var mockNetworkManager: MockNetworkManager!
    var userService: UserService!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        userService = UserService(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        userService = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        mockNetworkManager.mockData = """
        [
            {"id": 1, "name": "User One", "username": "userone", "email": "userone@example.com"}
        ]
        """.data(using: .utf8)

        let expectation = self.expectation(description: "Fetching users")

        userService.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1, "Users count should be 1")
                XCTAssertEqual(users.first?.name, "User One", "First user name should match")
            case .failure:
                XCTFail("Fetching users should succeed")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchUsersFailure() {
        mockNetworkManager.shouldReturnError = true

        let expectation = self.expectation(description: "Fetching users")

        userService.fetchUsers { result in
            switch result {
            case .success:
                XCTFail("Fetching users should fail")
            case .failure(let error):
                XCTAssertEqual(error, .requestFailed, "Error should be requestFailed")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
