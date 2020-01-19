//
//  UserRepositoryTests.swift
//  PersonalAppTests
//
//  Created by Mahender Gaddam on 15/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import XCTest
@testable import PersonalApp

class UserReposotoryTest: XCTestCase {
    var repository: UserRepositoryProtocol!
    
    override func setUp() {
        repository = UserRepository.sharedInstance
    }

    override func tearDown() {
        repository = nil
    }
    
    func testSaveUserReturnsUserIdWhenUserIsValid() {
        let actual = repository.saveUser(attributes: ["id": "63233"])
        let expected = "63233"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testSaveUserReturnsNilWhenUserIsNotValid() {
        let actual = repository.saveUser(attributes: ["birthday": "01/01/1994"])
        
        XCTAssertNil(actual)
    }
    
    func testGetUserWithValidIdReturnsUser() {
        let actual = repository.getUser(id: "123")?.name
        let expected = "admin"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testGetUserWithValidIdReturnsNil() {
        let actual = repository.getUser(id: "543")
        
        XCTAssertNil(actual)
    }
    
    func testValidateUserReturnsValidUserIdIfUserExists() {
        let username = "admin"
        let password = "password"
        
        let actual = repository.validateUser(name: username, password: password)
        let expected = "123"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testValidateUserReturnsNilIfUserExists() {
        let username = "test"
        let password = "testPassword"
        
        let actual = repository.validateUser(name: username, password: password)
        
        XCTAssertNil(actual)
    }
}
