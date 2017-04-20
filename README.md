# On The Road for iOS [![CircleCI](https://circleci.com/gh/mapzen/on-the-road_ios.svg?style=svg)](https://circleci.com/gh/mapzen/on-the-road_ios)

This is the official client for the Valhalla project (https://github.com/valhalla). It currently provides a basic implementation for pulling a route between multiple points, and is based on the work done by the good folks from TrailBehind for their GaiaGPS product (https://www.gaiagps.com/).

### Recommended Installation Method

We recommend using CocoaPods (https://cocoapods.org/) to install the library. It only relies on Foundation and UIKit.

```
pod 'OnTheRoad'
```

### Example Usage
Here is an example which shows how easy it is to use On The Road. Be sure to read the [documentation](http://cocoadocs.org/docsets/OnTheRoad/1.0.0/) to see all the properties you can customize when making requests.

#### Route
Route between multiple points:

```objc
  OTRRoutingController *router = [[OTRRoutingController alloc] init];

  OTRRoutingPoint *loc1 = [OTRRoutingPoint pointWithCoordinate:OTRGeoPointMake(40.74433, -73.9903) type:OTRRoutingPointTypeBreak];
  OTRRoutingPoint *loc2 = [OTRRoutingPoint pointWithCoordinate:OTRGeoPointMake(40.734807, -73.984770) type:OTRRoutingPointTypeThrough];
  OTRRoutingPoint *loc3 = [OTRRoutingPoint pointWithCoordinate:OTRGeoPointMake(40.732172, -73.998674) type:OTRRoutingPointTypeThrough];
  OTRRoutingPoint *loc4 = [OTRRoutingPoint pointWithCoordinate:OTRGeoPointMake(40.741050, -73.996142) type:OTRRoutingPointTypeBreak];
  NSArray *locations = [NSArray arrayWithObjects:loc1, loc2, loc3, loc4, nil];

  NSDictionary *costingOptions = [NSDictionary dictionaryWithObjectsAndKeys:@"use_ferry", @"0", nil];

  NSDictionary *directionsOptions = [NSDictionary dictionaryWithObjectsAndKeys:@"units", @"miles", @"language", @"fr-FR", nil];

  [router requestRouteWithLocations:locations costingModel:OTRRoutingCostingModelAuto costingOption:costingOptions directionsOptions:directionsOptions callback:^(OTRRoutingResult * _Nullable result, id  _Nullable invalidationToken, NSError * _Nullable error) {
    if (result) {
      // plot maneuvers on map
    }
  }];
```

For a full list of [costing](https://mapzen.com/documentation/mobility/turn-by-turn/api-reference/#costing-options) and [directions](https://mapzen.com/documentation/mobility/turn-by-turn/api-reference/#directions-options) options, be sure to check the [turn by turn documentation](https://mapzen.com/documentation/mobility/turn-by-turn/api-reference/).


### Reporting Issues
We welcome issues to be reported using the Github Issue tracker. However please review the currently open issues before reporting a bug to avoid issue tracker churn.

### Contributing
Please send any and all PRs you want! We do enforce good test coverage, so please make sure all your new code is covered, and that tests pass locally before submitting a pull request! 

