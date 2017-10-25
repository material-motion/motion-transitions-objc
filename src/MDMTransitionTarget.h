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

#import <MotionTransitioning/MotionTransitioning.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef MDM_SUBCLASSING_RESTRICTED
#if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#define MDM_SUBCLASSING_RESTRICTED __attribute__((objc_subclassing_restricted))
#else
#define MDM_SUBCLASSING_RESTRICTED
#endif
#endif  // #ifndef MDM_SUBCLASSING_RESTRICTED

/**
 A target for a view controller transition.
 */
NS_SWIFT_NAME(TransitionTarget)
@interface MDMTransitionTarget : NSObject

/**
 Creates a target referring to the back view controller's view.
 */
+ (nonnull instancetype)targetWithBackView;

/**
 Creates a target referring to the fore view controller's view.
 */
+ (nonnull instancetype)targetWithForeView;

/**
 Creates a target referring to the provided view.

 @param view The provided view will be returned by resolveWithContext, regardless of the context.
 */
+ (nonnull instancetype)targetWithView:(nonnull UIView *)view;

/**
 Returns the target view for the given context.

 @param context The transition context this target should be resolved from.
 */
- (nonnull UIView *)resolveWithContext:(nonnull id<MDMTransitionContext>)context;

// Unavailable. Use any of the static targetWith methods instead.
- (nonnull instancetype)init NS_UNAVAILABLE;

@end
