<p align="center">
<img src="jodellogo.png" width="300">
</p>

Jodel
==================================

Hi there! So, you would like to apply to join the Jodel iOS Team? We're honored to have you here!

Your first assignment is to relax. Our goal during the interview process is to get you know you, and for you to get to know us. We want to make it a joyful learning experience for you and for our team. There are no *"right answers"*, programming is all about solving problems through compromises. If you make a mistake, no matter how simple, don't worry, we make them all the time. *Pssst... Don't tell anyone, but we use [f****ngblocksyntax](http://fuckingblocksyntax.com) all the time* 😜

Your second assignment is to provide us with some meaty code sample, so we have something to talk about during our delightful discussion. If you already have a project you'd like to show to us, please let us know. If you don't, no problem! We have a quite interesting task for you to solve. 

## CoonApp

CoonApp is an app for showing [Flickr](https://www.flickr.com) pictures in a Collection View. We've setup some boilerplate code for you 🙇 Your assignment is to improve the app and make it an enjoyable picture browsing experience. We'll give you some tips, but the requirements and specification are quite open. This directly represents how we work in the iOS team, we have guidelines, but every team member is open to introduce improvements to any area of the app.

Remember, our goal is not to *compare* and *grade* the projects, but to get to know you better. We care about the quality, not quantity, we don't want you to waste your precious time.

Use Swift 4.0 and Xcode 9.0.

### Interface

We don't *"grade"* projects based on how much time you've spent designing and polishing UI so don't waste time on that. All we care about is *tidiness* of the UI: equal margins, logical view hierarchy, logical layout constraints.

Use Auto Layout when possible. Please decide between Xib vs. Storyboards, we would love to know your opinion on that one.

### Architecture

• We would like you to use the MVVM architecture or an iteration of MVVM. Try to solve the problem of mixing business and presentation logic in the View Model

• The project should be very easy to unit test. The project should have at least one unit test

• The current boilerplate code is in Objective-C. The networking layer should stay in Objective-C and the rest of the app should be in Swift

• Feel free to choose the Observer mechanism (RxSwift, ReactiveCocoa, your own creation)

• Support error scenarios by simply showing an alert view

• Feel free to use any third-party libraries

### Requirements

• The feed should be vertical, one picture per row

• The app should cache the images so they're available when the app is offline

• The app should implement pagination for the pictures feed

• User should be able to tap the pictures in the feed to preview them in fullscreen

• The app should show loading indicators when the feed is loading

• Each cell should display the image and the image's title

*Pssst... [here's](https://github.com/raywenderlich/swift-style-guide) an amazing style guide for Swift*

**Good luck**!


