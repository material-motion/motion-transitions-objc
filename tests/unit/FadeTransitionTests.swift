/*
 Copyright 2017-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import XCTest
import MotionTransitions

class FadeTransitionTests: XCTestCase {

  private var window: UIWindow!
  override func setUp() {
    window = UIWindow()
    window.rootViewController = UIViewController()
    window.makeKeyAndVisible()
    window.layer.speed = 10
  }

  override func tearDown() {
    window = nil
  }

  func testDoesComplete() {
    let presentedViewController = UIViewController()
    presentedViewController.transitionController.transition = FadeTransition()

    let didComplete = expectation(description: "Did complete")
    window.rootViewController!.present(presentedViewController, animated: true) {
      didComplete.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(window.rootViewController!.presentedViewController, presentedViewController)
  }

  func testDoesFadeIn() {
    let presentedViewController = UIViewController()
    presentedViewController.transitionController.transition = FadeTransition()

    let didComplete = expectation(description: "Did complete")
    window.rootViewController!.present(presentedViewController, animated: true) {
      didComplete.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(presentedViewController.view.layer.opacity, 1)
  }

  func testDoesFadeOutDuringDismissal() {
    let presentedViewController = UIViewController()
    presentedViewController.transitionController.transition = FadeTransition()

    let didComplete = expectation(description: "Did complete")
    window.rootViewController!.present(presentedViewController, animated: true) {
      didComplete.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    let didDismiss = expectation(description: "Did dismiss")
    presentedViewController.dismiss(animated: true) {
      didDismiss.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(presentedViewController.view.layer.opacity, 0)
  }

  func testDoesFadeOut() {
    let presentedViewController = UIViewController()
    let transition = FadeTransition()
    transition.appearance = .disappearing
    presentedViewController.transitionController.transition = transition

    let didComplete = expectation(description: "Did complete")
    window.rootViewController!.present(presentedViewController, animated: true) {
      didComplete.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(presentedViewController.view.layer.opacity, 0)

    let didDismiss = expectation(description: "Did dismiss")
    presentedViewController.dismiss(animated: true) {
      didDismiss.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(presentedViewController.view.layer.opacity, 1)
  }

  func testResolvesBackTarget() {
    let presentedViewController = UIViewController()
    let transition = FadeTransition(target: .withBackView())
    transition.appearance = .disappearing
    presentedViewController.transitionController.transition = transition

    let didComplete = expectation(description: "Did complete")
    window.rootViewController!.present(presentedViewController, animated: true) {
      didComplete.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(window.rootViewController!.view.layer.opacity, 0)

    let didDismiss = expectation(description: "Did dismiss")
    presentedViewController.dismiss(animated: true) {
      didDismiss.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(window.rootViewController!.view.layer.opacity, 1)
  }

  func testResolvesCustomTarget() {
    let presentedViewController = UIViewController()

    let customView = UIView()
    presentedViewController.view.addSubview(customView)

    let transition = FadeTransition(target: .init(view: customView))
    transition.appearance = .disappearing
    presentedViewController.transitionController.transition = transition

    let didComplete = expectation(description: "Did complete")
    window.rootViewController!.present(presentedViewController, animated: true) {
      didComplete.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(customView.layer.opacity, 0)

    let didDismiss = expectation(description: "Did dismiss")
    presentedViewController.dismiss(animated: true) {
      didDismiss.fulfill()
    }

    waitForExpectations(timeout: 0.1)

    XCTAssertEqual(customView.layer.opacity, 1)
  }
}

