//
//  OTRRoutingPoint.h
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import <Foundation/Foundation.h>
#import "OTRRoutingTypes.h"

/**
 `OTRRoutingPoint` is a data structure object used when communicating with a Valhalla routing server. Two routing points at a minimum are necessary to create a route, and providing multiple will create multiple route legs in the server response. 
 */
@interface OTRRoutingPoint : NSObject

/** Coordinate of the point */
@property (nonatomic, assign) OTRGeoPoint coordinate;

/** Type of location, either break or through. A break is a stop, so the first and last locations must be of type break. A through location is one that the route path travels through, and is useful to force a route to go through location. The path is not allowed to reverse direction at the through locations. If no type is provided, the type is assumed to be a break. */
@property (nonatomic, assign) OTRRoutingPointType type;

/** (optional) Preferred direction of travel for the start from the location. This can be useful for mobile routing where a vehicle is traveling in a specific direction along a road, and the route should start in that direction. The heading is indicated in degrees from north in a clockwise direction, where north is 0°, east is 90°, south is 180°, and west is 270°. */
@property (nonatomic, strong, nullable) NSNumber *heading;

/** 
 
 Create a new point.
 
 @param coordinate The coordinate point for the route
 @param type The particular OTRRoutingPointType this point should be
 
 @return A fully formed routing point usable in requesting routes from the web api.
 */
+ (instancetype _Nonnull)pointWithCoordinate:(OTRGeoPoint)coordinate type:(OTRRoutingPointType)type;

/** Get the dictionary representation of the point, used for creating server query. */
- (NSDictionary * _Nonnull)asDictionary;

@end
