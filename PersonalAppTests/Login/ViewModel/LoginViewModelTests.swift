//
//  LoginViewModelTests.swift
//  PersonalAppTests
//
//  Created by Mahender Gaddam on 16/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import XCTest
@testable import PersonalApp

class MockUserRepository: UserRepositoryProtocol {
    public var saveUserCalled = false
    public var getUserCalled = false
    public var validateUserCalled = false
    public var loadDefaultUserDataCalled = false
    
    func saveUser(attributes: [String : String]) -> String? {
        saveUserCalled = true
        return nil
    }
    
    func getUser(id: String) -> User? {
        getUserCalled = true
        return nil
    }
    
    func validateUser(name: String, password: String) -> String? {
        validateUserCalled = true
        return nil
    }
    
    func loadDefaultUserData() {
        loadDefaultUserDataCalled = true
    }
}

class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModelProtocol!
    var mockRepository: MockUserRepository!
    
    override func setUp() {
        mockRepository = MockUserRepository()
        loginViewModel = LoginViewModel(mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        loginViewModel = nil
    }
    
    func testRequestForCustomLoginWithParamsCallsRepositoryValidateUser() {
        _ = loginViewModel.requestForCustomLoginWithParams(["name" : "admin"])
        
        XCTAssertTrue(mockRepository.validateUserCalled)
    }
    
    func testDaveUserDetailsCallsSaveUserOnRepository() {
        _ = loginViewModel.saveUserDetails(attributes: ["id": "234edc"])
        
        XCTAssertTrue(mockRepository.saveUserCalled)
    }
    
    func testGetUserDetailsCallsGetUserOnRepository() {
        _ = loginViewModel.getUserDetailsFor(id: "123")
        
        XCTAssertTrue(mockRepository.getUserCalled)
    }
}
