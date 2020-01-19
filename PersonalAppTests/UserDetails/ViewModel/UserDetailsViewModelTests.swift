//
//  UserDetailsViewModelTests.swift
//  PersonalAppTests
//
//  Created by Mahender Gaddam on 16/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import XCTest
@testable import PersonalApp

class UserDetailsViewModelTests: XCTestCase {
    var userDetailsViewModel: UserDetailsViewModelProtocol!
    
    override func setUp() {
        let user = UserBuilder().withId("000")
            .withName("Mahender").withEmail("Mahender@gmail.com")
            .withBirthday(Date.init(timeIntervalSince1970: 100)).withPassword("abc").build()
        userDetailsViewModel = UserDetailsViewModel(user: user)
    }

    override func tearDown() {
        userDetailsViewModel = nil
    }
    
    func testProfileImageReturnsDefaultImage() {
        let actual = userDetailsViewModel.profilePicForUser
        let expected = UIImage(named: "defaultPic")
        
        XCTAssertEqual(actual, expected)
    }
    
    func testNumberOfRowsReturns3() {
        let actual = userDetailsViewModel.numberOfRows
        let expected = 3
        
        XCTAssertEqual(actual, expected)
    }
    
    func testUserDataAtRowAtIndexPathReturnsNameAsFirstRow() {
        let actual = userDetailsViewModel.userDataForRowAtIndexPath(indexPath: IndexPath(row: 0, section: 0)).1
        let expected = "Mahender"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testUserDataAtRowAtIndexPathReturnsBirthdayAsSecondRow() {
        let actual = userDetailsViewModel.userDataForRowAtIndexPath(indexPath: IndexPath(row: 1, section: 0)).1
        let expected = "01/01/1970"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testUserDataAtRowAtIndexPathReturnsEmailAsThirdRow() {
        let actual = userDetailsViewModel.userDataForRowAtIndexPath(indexPath: IndexPath(row: 2, section: 0)).1
        let expected = "Mahender@gmail.com"
        
        XCTAssertEqual(actual, expected)
    }
}
