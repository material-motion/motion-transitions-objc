#!/bin/bash

# Fail on any error.
set -e
# Display commands to stderr.
set -x

gem install cocoapods --no-rdoc --no-ri --no-document --quiet
git clone https://github.com/phacility/arcanist.git
git clone https://github.com/phacility/libphutil.git
git clone --recursive https://github.com/material-foundation/material-arc-tools.git

cd github/motion-transitions-objc
pod install --repo-update

xcodebuild build -workspace MotionTransitions.xcworkspace -scheme Catalog -sdk "iphonesimulator10.1" -destination "name=iPhone 6s,OS=10.1" ONLY_ACTIVE_ARCH=YES | xcpretty -c;

bash <(curl -s https://codecov.io/bash)
