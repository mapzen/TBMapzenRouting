//
//  OTRRoutingResult.m
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//


#import "OTRRoutingResult.h"

@implementation OTRRoutingResult

+ (instancetype _Nullable)resultFromResponse:(NSDictionary * _Nonnull)response {
  OTRRoutingResult *result = [[OTRRoutingResult alloc] init];
  NSDictionary *trip = response[@"trip"];
  result.length = [trip[@"summary"][@"length"] doubleValue];
  result.time = [trip[@"summary"][@"time"] doubleValue];
  result.units = trip[@"units"];
  result.language = trip[@"language"];
  result.locations = trip[@"locations"];
  
  NSMutableArray <OTRRoutingResultLeg *> *legs = [NSMutableArray arrayWithCapacity:[(NSArray*)trip[@"legs"] count]];
  for(NSDictionary *leg in trip[@"legs"]) {
    [legs addObject:[OTRRoutingResultLeg legFromDictionary:leg]];
  }
  result.legs = legs;
  return result;
}


@end
