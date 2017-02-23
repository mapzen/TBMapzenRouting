//
//  OTRRoutingResultLeg.h
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "OTRRoutingResultManeuver.h"
#import "OTRRoutingTypes.h"

/**
 'OTRRoutingResultLeg' represents one particular leg of a `OTRRoutingResult`. It includes one or more `OTRRoutingResultManeuver`s and necessary metadata such as length and time and number of coordinates on the leg.
 */
@interface OTRRoutingResultLeg : NSObject

/** Estimated elapsed time to complete the leg. */
@property (nonatomic, assign) CGFloat length;

/**  Distance traveled for the leg. Units are either miles or kilometers based on the input units specified. */
@property (nonatomic, assign) CGFloat time;

/** The maneuvers the make up the leg. */
@property (nonatomic, readonly, nonnull) NSArray <OTRRoutingResultManeuver*>* maneuvers;

/** The number of coordinates in the trip path. */
@property (nonatomic, readonly) NSUInteger coordinateCount;

/** An array of coordinates representing the geometry of the leg path.
 
 This array is owned by the leg, and will be free()'ed when the the leg is dealloc'ed. If you need to keep this array around past the life of this object, copy it to a new array owned by another object.
 */
@property (nonatomic, readonly, nullable) OTRGeoPoint *coordinates;

/** 
 Create a leg object by parsing an element of the leg array of the server json response. 
 
 @param response Part of the response from the valhalla web api containing a particular leg.
 
 @return One leg of a particular route to be included within a OTRRoutingResult
 */
+ (instancetype _Nullable)legFromDictionary:(NSDictionary * _Nonnull)response;

@end
