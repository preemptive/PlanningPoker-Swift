Fibonacci Planning Poker
========================

*Fibonacci Planning Poker* is a sample project demonstrating use of *iOSDefender SDK*.
*iOSDefender SDK* is a Runtime Application Self-Protection (RASP) library for iOS projects using Swift or Objective-C.

The app is a very simple tool for bidding during planning in agile development processes.
The app displays different numbered cards and these can be switched between by using the slider at the bottom of the screen or by swiping left or right.
Once you select your bid you can hold up your device to show it to your teammates.

You can select between different bidding styles by tapping the options in the picker at the top.
Current options are Fibonacci numbers, prime numbers, squares, or just a linear progression.
Cards for infinity and a question mark are also available, these are "to the right" of the highest integer bids.

## Requirements

* *iOSDefender SDK* (not included: please contact sales@preemptive.com for more information)
* Xcode 11 or later
* An iOS device with iOS 13.0 or later
* Video conferencing software or a face mask (for showing your bids to your teammates)

## Setting Up

Setting up this project has only one step:

1. Copy `iOSDefenderSDK.xcframework` from the *iOSDefender SDK* distribution to the `Frameworks/` directory.

You should now be able to build and run the project.

## Behavior

When the app is running on a jailbroken device or in the Simulator the functionality will be limited: a small range of bids are available.
The slider at the bottom will show the range of values available.
When the app is started, an alert is shown indicating that the device is jailbroken and which of the API methods returned true.
The alert also indicates how the functionality is limited.

## Troubleshooting

If you encounter issues with *iOSDefender SDK* or this sample project, please [contact support](https://www.preemptive.com/contact/supportrequestform) for additional help.

* Xcode is a trademark of Apple Inc., registered in the U.S. and other countries.
* Other trademarks are the property of their respective owners.
