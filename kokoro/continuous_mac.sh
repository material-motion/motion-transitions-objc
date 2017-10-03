#!/bin/bash

# Fail on any error.
set -e
# Display commands to stderr.
set -x

gem install cocoapods --no-rdoc --no-ri --no-document --quiet
gem install xcpretty --no-rdoc --no-ri --no-document --quiet

# Test pull request.

sudo xcode-select --switch /Applications/Xcode_8.2.app/Contents/Developer
xcodebuild -version

cd github/motion-transitions-objc
pod install --repo-update

xcodebuild build -workspace MotionTransitions.xcworkspace -scheme Catalog -sdk "iphonesimulator" -destination "name=iPhone 6s,OS=10.0" ONLY_ACTIVE_ARCH=YES | xcpretty && exit ${PIPESTATUS[0]}

bash <(curl -s https://codecov.io/bash)
