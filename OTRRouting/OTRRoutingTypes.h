//
//  OTRRoutingTypes.h
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OTRRoutingPointType) {
  OTRRoutingPointTypeBreak,
  OTRRoutingPointTypeThrough
};

typedef NS_ENUM(NSUInteger, OTRRoutingCostingModel) {
  OTRRoutingCostingModelAuto,
  OTRRoutingCostingModelAutoShorter,
  OTRRoutingCostingModelBicycle,
  OTRRoutingCostingModelBus,
  OTRRoutingCostingModelMultimodal,
  OTRRoutingCostingModelPedestrian
};

@interface OTRRoutingTypes : NSObject

+ (NSString * _Nonnull)stringFromCostingModel:(OTRRoutingCostingModel)costing;
+ (NSString * _Nonnull)stringFromRoutingPointType:(OTRRoutingPointType)type;

@end
