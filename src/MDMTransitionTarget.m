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

#import "MDMTransitionTarget.h"

@import MotionTransitioning;

typedef NS_ENUM(NSUInteger, Target) {
  TargetBack,
  TargetFore,
  TargetView,
};

@implementation MDMTransitionTarget {
  Target _target;
  UIView *_targetView; // Valid only if _target == TargetView
}

+ (instancetype)targetWithBackView {
  MDMTransitionTarget *target = [[[self class] alloc] init];
  if (target) {
    target->_target = TargetBack;
  }
  return target;
}

+ (instancetype)targetWithForeView {
  MDMTransitionTarget *target = [[[self class] alloc] init];
  if (target) {
    target->_target = TargetFore;
  }
  return target;
}

+ (instancetype)targetWithView:(UIView *)view {
  MDMTransitionTarget *target = [[[self class] alloc] init];
  if (target) {
    target->_target = TargetView;
    target->_targetView = view;
  }
  return target;
}

- (UIView *)resolveWithContext:(id<MDMTransitionContext>)context {
  switch (_target) {
    case TargetBack:
      return context.backViewController.view;
      break;

    case TargetFore:
      return context.foreViewController.view;
      break;

    case TargetView:
      return _targetView;
      break;
  }
  return nil;
}

@end
