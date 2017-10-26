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

  var ctx: MockTransitionContext!

  override func setUp() {
    super.setUp()

    ctx = MockTransitionContext()
    ctx.duration = 0.01

    ctx.transitionDidEndExpectation = expectation(description: "Did complete")
  }

  override func tearDown() {
    ctx = nil

    super.tearDown()
  }

  func testDoesComplete() {
    let transition = FadeTransition()
    transition.start(with: ctx)

    waitForExpectations(timeout: ctx.duration * 2)
  }

  func testDoesFadeIn() {
    let transition = FadeTransition()
    transition.start(with: ctx)

    waitForExpectations(timeout: ctx.duration * 2)

    XCTAssertEqual(ctx.foreViewController.view.layer.opacity, 1)
    XCTAssertEqual(ctx.backViewController.view.layer.opacity, 1)
  }

  func testDoesFadeOutDuringDismissal() {
    ctx.direction = .backward

    let transition = FadeTransition()
    transition.start(with: ctx)

    waitForExpectations(timeout: ctx.duration * 2)

    XCTAssertEqual(ctx.foreViewController.view.layer.opacity, 0)
    XCTAssertEqual(ctx.backViewController.view.layer.opacity, 1)
  }

  func testDoesFadeOutWhenDisappearing() {
    let transition = FadeTransition()
    transition.appearance = .disappearing
    transition.start(with: ctx)

    waitForExpectations(timeout: ctx.duration * 2)

    XCTAssertEqual(ctx.foreViewController.view.layer.opacity, 0)
    XCTAssertEqual(ctx.backViewController.view.layer.opacity, 1)
  }

  func testResolutionForBackTarget() {
    let transition = FadeTransition(target: .withBackView())
    transition.appearance = .disappearing
    transition.start(with: ctx)

    waitForExpectations(timeout: ctx.duration * 2)

    XCTAssertEqual(ctx.backViewController.view.layer.opacity, 0)
    XCTAssertEqual(ctx.foreViewController.view.layer.opacity, 1)
  }

  func testResolutionForCustomTarget() {
    let customView = UIView()
    let transition = FadeTransition(target: .init(view: customView))
    transition.appearance = .disappearing
    transition.start(with: ctx)

    waitForExpectations(timeout: ctx.duration * 2)

    XCTAssertEqual(customView.layer.opacity, 0)
    XCTAssertEqual(ctx.backViewController.view.layer.opacity, 1)
    XCTAssertEqual(ctx.foreViewController.view.layer.opacity, 1)
  }
}

