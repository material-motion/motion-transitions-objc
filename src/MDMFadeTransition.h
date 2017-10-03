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

@import Foundation;
@import MotionInterchange;
@import MotionTransitioning;

#import "MDMTransitionAppearance.h"
#import "MDMTransitionTimingMode.h"
#import "MDMTransitionTarget.h"

/**
 A view controller transition component for fading a target view.

 The target view can be faded in or out with custom timing.
 */
NS_SWIFT_NAME(FadeTransition)
MDMSUBCLASSING_RESTRICTED
@interface MDMFadeTransition : NSObject <MDMTransition>

/**
 Initializes the transition instance with a specific target.

 The target view will fade in or out according to the timing information configured on this
 instance.
 
 @param target The target view to be animated.
 */
- (nonnull instancetype)initWithTarget:(nonnull MDMTransitionTarget *)target
  NS_DESIGNATED_INITIALIZER;

/**
 Initializes the transition with the fore view as the target.
 */
- (nonnull instancetype)init;

/**
 The motion timing to use for this fade transition.

 By default the animation will use the system default timing function with a duration lasting the
 entire transition. The timing duration and delay are treated as relative to the transition's
 overall duration. To treat these values as absolute time values, change the timingMode to absolute.
 */
@property(nonatomic, assign) MDMMotionTiming timing;

/**
 The timing mode affects how the `timing` data is interpreted.

 Default value is MDMTransitionTimingModeMirrored.
 */
@property(nonatomic, assign) MDMTransitionTimingMode timingMode;

/**
 Whether the target is transitioning in to or out of view.

 If the appearance is `.in`, the target will fade in, otherwise the target will fade out.

 Default value is `.in`.
 */
@property(nonatomic, assign) MDMTransitionAppearance appearance;

@end
