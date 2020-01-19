## Personal Facebook Login Application

This app shows user informatin when they login with their facebook credentials.

I have followed MVVM architecture to build this application.

* As per requirement we need to show name/email/birthday of a user after login. But to get birthday field from fb graph api, we need to submit this app for review to facebook. As this is a small assignment I didn't do that.
* Added custum login functionality as well. So, user is not forced to use login through facebook only.

## Requirements

1. Xcode 11
2. Swift 5
3. iOS 10.0+

## Dependency Manager

* Used `Cocoapods` to download facebook login sdk's.
* Use `sude gem install cocoapods` to install cocoapods.
* Use `pod install` to download dependencies

## Getting Started

1. Open `PersonalApp.xcworkspace` in Xcode 11.
2. To Build and Run, select any of the iPhone simulators or a connected device.

## Unit and UI Test cases

* Total number of test cases - `20`
* Code coverage - `73%` 

**Was not able to test facebook's login functionality as they are from third party developers.

## Running the tests

Use command &#8984; + U to run the UI and Unit test cases.

## External Frameworks

* Only Facebook Login SDK's for login.

## Test Credentials

username: `admin` </br>
password: `password`
