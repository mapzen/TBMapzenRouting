# On The Road iOS SDK Release Checklist

## Requirements
- Have Xcode installed
- Have cocoapods installed
- Have ownership privileges to update the cocoapods trunk spec

## Steps
1. Update the OnTheRoad.podspec version number with the version you want to release
2. Commit these changes
3. Tag current master with the version you updated the .podspec to and push to github
4. Run `pod spec lint` to make sure everything is happy. Fix issues if not happy (document known issues)
5. Push the updated pod spec to trunk: `pod trunk push OnTheRoad.podspec`
6. Write up release notes and release the SDK on github