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

#import "MDMFadeTransition.h"

@import MotionAnimator;

static MDMMotionCurve ReverseTimingCurve(MDMMotionCurve timingCurve) {
  MDMMotionCurve reversed = timingCurve;
  if (timingCurve.type == MDMMotionCurveTypeBezier) {
    reversed.data[0] = 1 - reversed.data[2];
    reversed.data[1] = 1 - reversed.data[3];
    reversed.data[2] = 1 - reversed.data[0];
    reversed.data[3] = 1 - reversed.data[1];
  }
  return reversed;
}

@implementation MDMFadeTransition {
  MDMTransitionTarget *_target;
}

- (instancetype)initWithTarget:(MDMTransitionTarget *)target {
  self = [super init];
  if (self) {
    _target = target;
    _appearance = MDMTransitionAppearanceAppearing;
    _timingMode = MDMTransitionTimingModeMirrored;

    CAMediaTimingFunction *defaultTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    _timing = (MDMMotionTiming){
      .duration = 1,
      .curve = MDMMotionCurveFromTimingFunction(defaultTiming)
    };
  }
  return self;
}

- (instancetype)init {
  return [self initWithTarget:[MDMTransitionTarget targetWithForeView]];
}

#pragma mark - MDMTransition

- (void)startWithContext:(id<MDMTransitionContext>)context {
  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    [context transitionDidEnd];
  }];

  MDMMotionAnimator *animator = [[MDMMotionAnimator alloc] init];

  MDMMotionTiming timing = _timing;
  switch (_timingMode) {
    case MDMTransitionTimingModeMirrored:
      animator.timeScaleFactor = context.duration;

      animator.shouldReverseValues = context.direction == MDMTransitionDirectionBackward;

      if (context.direction == MDMTransitionDirectionBackward) {
        timing.delay = 1 - (timing.delay + timing.duration);
        timing.curve = ReverseTimingCurve(timing.curve);
      }
      break;

    case MDMTransitionTimingModeRelative:
      animator.timeScaleFactor = context.duration;
      break;

    case MDMTransitionTimingModeAbsolute:
      // No-op.
      break;
  }

  NSArray *inValues = @[@0, @1];
  NSArray *outValues = [[inValues reverseObjectEnumerator] allObjects];
  NSArray *values = (_appearance == MDMTransitionAppearanceAppearing) ? inValues : outValues;

  UIView *target = [_target resolveWithContext:context];

  [animator animateWithTiming:timing
                      toLayer:target.layer
                   withValues:values
                      keyPath:MDMKeyPathOpacity];

  [CATransaction commit];
}

@end
