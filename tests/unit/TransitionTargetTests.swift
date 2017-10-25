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

class MockTransitionContext: TransitionContext {
  func compose(with transition: Transition) {
  }

  func transitionDidEnd() {
  }

  var direction: TransitionDirection = .forward

  var duration: TimeInterval = 0.1

  var sourceViewController: UIViewController? = nil

  var backViewController = UIViewController()

  var foreViewController = UIViewController()

  var containerView = UIView()

  var presentationController: UIPresentationController? = nil

  func `defer`(toCompletion work: @escaping () -> Void) {
  }
}

class TransitionTargetTests: XCTestCase {

  func testCustomTargetResolution() {
    let targetView = UIView()
    let target = TransitionTarget(view: targetView)
    let resolvedView = target.resolve(with: MockTransitionContext())

    XCTAssertEqual(targetView, resolvedView)
  }

  func testForeResolution() {
    let target = TransitionTarget.withForeView()
    let context = MockTransitionContext()
    let resolvedView = target.resolve(with: context)

    XCTAssertEqual(context.foreViewController.view, resolvedView)
  }

  func testBackResolution() {
    let target = TransitionTarget.withBackView()
    let context = MockTransitionContext()
    let resolvedView = target.resolve(with: context)

    XCTAssertEqual(context.backViewController.view, resolvedView)
  }
}

