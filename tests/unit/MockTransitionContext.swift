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

import MotionTransitions
import XCTest

class MockTransitionContext: TransitionContext {

  init() {
    foreViewController.view.frame = containerView.bounds
    backViewController.view.frame = containerView.bounds
  }

  func compose(with transition: Transition) {
    transition.start(with: self)
  }

  var transitionDidEndExpectation: XCTestExpectation?

  func transitionDidEnd() {
    transitionDidEndExpectation?.fulfill()
  }

  var direction: TransitionDirection = .forward

  var duration: TimeInterval = 0.1

  var sourceViewController: UIViewController? = nil

  var backViewController = UIViewController()

  var foreViewController = UIViewController()

  var containerView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 500))

  var presentationController: UIPresentationController? = nil

  func `defer`(toCompletion work: @escaping () -> Void) {
  }
}

