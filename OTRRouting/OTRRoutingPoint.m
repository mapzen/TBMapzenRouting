//
//  OTRRoutingPoint.m
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import "OTRRoutingPoint.h"
#import "OTRRoutingTypes.h"

@implementation OTRRoutingPoint

+ (instancetype _Nonnull)pointWithCoordinate:(OTRGeoPoint)coordinate type:(OTRRoutingPointType)type {
  OTRRoutingPoint *point = [[OTRRoutingPoint alloc] init];
  point.coordinate = coordinate;
  point.type = type;
  return point;
}


- (NSDictionary * _Nonnull)asDictionary {
  NSDictionary *dictionary = @{
                               @"lat": @(self.coordinate.latitude),
                               @"lon": @(self.coordinate.longitude),
                               @"type": [OTRRoutingTypes stringFromRoutingPointType:self.type]
                               };
  if(self.heading) {
    NSMutableDictionary *mutable = [dictionary mutableCopy];
    mutable[@"heading"] = self.heading;
    dictionary = mutable;
  }
  return dictionary;
}

@end
