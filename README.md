Fibonacci Planning Poker
========================

This is a sample project demonstrating use of *iOSDefenderSDK*.
*iOSDefenderSDK* is a Runtime Application Self-Protection (RASP) library for iOS projects using Swift, Objective-C, or some combination thereof.

The app is a very simple tool for bidding during agile planning poker.
The app displays different numbered cards and these can be switched between by using the slider at the bottom of the screen or by swiping left or right.
Once you select your bid you can hold up your device to show it to your teammates.

You can select between different bidding styles by tapping the options in the picker at the top.
Current options are Fibonacci numbers, prime numbers, squares, or just a linear progression.
Above the highest valued cards are cards for infinity and a question mark for totally unknown.

## Requirements

* Xcode 12
* (Optional) An iOS device with iOS 13.0 or later
* Video conferencing software or a face mask (for showing your bids to your teammates)

## Setting Up

Setting up this sample project is very easy:

1. Copy `iOSDefenderSDK.xcframework` from the *iOSDefenderSDK* distribution to the `Frameworks/` directory.

You should now be able to build and run the sample project.

## Behavior

When the app is running on a jailbroken device or in the Simulator the functionality will be limited: a small range of bids are available.
The slider at the bottom will show the range of values available.
When the app is started, an alert is shown indicating that the device is jailbroken and which of the API methods returned true.
The alert also indicates how the functionality is limited.
