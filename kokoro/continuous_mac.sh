#!/bin/bash

# Fail on any error.
set -e
# Display commands to stderr.
set -x

brew install ninja

git clone https://github.com/facebook/xcbuild
cd xcbuild
git submodule update --init
make

cd ../github/motion-transitions-objc
../../xcbuild/build/xcbuild -workspace MotionTransitions.xcworkspace -scheme Catalog -sdk "iphonesimulator" -destination "name=iPhone 6s,OS=10.0" ONLY_ACTIVE_ARCH=YES | xcpretty && exit ${PIPESTATUS[0]}
