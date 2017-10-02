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

#import <Foundation/Foundation.h>

/**
 The timing mode affects how the timing and internal values of the animation are understood.
 */
typedef NS_ENUM(NSUInteger, MDMTransitionTimingMode) {

  /**
   The delay and duration will be treated as relative to the transition's overall duration and the
   timing will be reversed when the transition goes backwards.

   Animation values will be reversed during dismiss transitions.

   Examples:

   When presenting, a delay of 0 and duration of 1 means the animation lasts the entire transition,
   while a delay of 0.5 and duration of 0.5 means the animation happens in the last half of the
   transition.

   When dismissing, a delay of 0 and duration of 1 similarly lasts the entire transition, but a
   delay of 0.5 and duration of 0.5 means the animation happens in the *first* half of the
   dismissal transition. The animation values are also reversed when dismissing, so an animation
   that faded in during presentation will fade out during dismissal.
   */
  MDMTransitionTimingModeMirrored,

  /**
   The delay and duration will be treated as relative to the transition's overall duration.

   For example, a delay of 0 and duration of 1 means the animation lasts the entire transition,
   while a delay of 0.5 and duration of 1 means the animation happens in the last half of the
   transition.
   */
  MDMTransitionTimingModeRelative,

  /**
   The delay and duration will be treated as absolute timing.

   For example, a delay of 0.1 and duration of 0.3 means the animation will wait 1/10th of a second
   before animating for 3/10ths of a second.
   */
  MDMTransitionTimingModeAbsolute,

} NS_SWIFT_NAME(TransitionTimingMode);
