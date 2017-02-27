//
//  OTRRoutingTypes.h
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import <Foundation/Foundation.h>

/// Routing point type that defines whether it begins or ends, or is a through point for a route.
typedef NS_ENUM(NSUInteger, OTRRoutingPointType) {
  OTRRoutingPointTypeBreak,
  OTRRoutingPointTypeThrough
};

/// Costing model enumeration for telling the server api how it should weight certain routes.
typedef NS_ENUM(NSUInteger, OTRRoutingCostingModel) {
  OTRRoutingCostingModelAuto,
  OTRRoutingCostingModelAutoShorter,
  OTRRoutingCostingModelBicycle,
  OTRRoutingCostingModelBus,
  OTRRoutingCostingModelMultimodal,
  OTRRoutingCostingModelPedestrian
};

/** Struct that is used by the framework to lat/long coordinate pairs. */
struct OTRGeoPoint {
  double latitude;
  double longitude;
};
typedef struct OTRGeoPoint OTRGeoPoint;

/// Convenience function for OTRGeoPoint creation.
OTRGeoPoint OTRGeoPointMake(double latitude, double longitude);

/// Utility class for converting points and costing models to their particular web api strings.
@interface OTRRoutingTypes : NSObject

/** Creates a string from an OTRCostingModel usable in sending to the valhallha web api. */
+ (NSString * _Nonnull)stringFromCostingModel:(OTRRoutingCostingModel)costing;

/** Creates a string from an OTRRoutingPointType usable in sending to the valhallha web api. */
+ (NSString * _Nonnull)stringFromRoutingPointType:(OTRRoutingPointType)type;

@end
