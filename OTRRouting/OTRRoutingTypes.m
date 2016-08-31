//
//  OTRRoutingTypes.m
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import "OTRRoutingTypes.h"

OTRGeoPoint OTRGeoPointMake(double latitude, double longitude){
  struct OTRGeoPoint point;
  point.latitude = latitude;
  point.longitude = longitude;
  return point;
}

@implementation OTRRoutingTypes

+ (NSString* _Nonnull)stringFromCostingModel:(OTRRoutingCostingModel)costing {
  switch (costing) {
    case OTRRoutingCostingModelAuto:
      return @"auto";
    case OTRRoutingCostingModelAutoShorter:
      return @"auto_shorter";
    case OTRRoutingCostingModelBicycle:
      return @"bicycle";
    case OTRRoutingCostingModelBus:
      return @"bus";
    case OTRRoutingCostingModelMultimodal:
      return @"multimodal";
    case OTRRoutingCostingModelPedestrian:
      return @"pedestrian";
  }
}


+ (NSString * _Nonnull)stringFromRoutingPointType:(OTRRoutingPointType)type {
  switch (type) {
    case OTRRoutingPointTypeBreak:
      return @"break";
    case OTRRoutingPointTypeThrough:
      return @"through";
  }
}

@end
