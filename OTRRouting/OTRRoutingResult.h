//
//  OTRRoutingResult.h
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import <Foundation/Foundation.h>
#import "OTRRoutingResultLeg.h"

/**
 `OTRRoutingResult` is the top level object representing a route returned from the Valhalla server api. It can include multiple legs from mutliple locations.
 */
@interface OTRRoutingResult : NSObject

/** Estimated elapsed time to complete the trip. */
@property (nonatomic, assign) CGFloat length;

/** Distance traveled for the entire trip. Units are either miles or kilometers based on the input units specified. */
@property (nonatomic, assign) CGFloat time;

/** The specified units of length are returned, either kilometers or miles. */
@property (nonatomic, strong, nullable) NSString *units;

/** The legs of the route. */
@property (nonatomic, strong, nonnull) NSArray<OTRRoutingResultLeg *> * legs;

/** The language of the narration instructions. If the user specified a language in the directions options and the specified language was supported - this returned value will be equal to the specified value. Otherwise, this value will be the default (en-US) language.
 */
@property (nonatomic, strong, nullable) NSString *language;

/** Location information is returned in the same form as it is entered with additional fields to indicate the side of the street.
 */
@property (nonatomic, strong, nullable) NSArray <NSDictionary*> *locations;

/** 
 Create a response object by parsing the JSON returned by the web api. 
 
 @param response the parsed json response from the valhalla web api.
 
 @return A routing result with possibly multiple routing legs.
 */
+ (instancetype _Nullable)resultFromResponse:(NSDictionary * _Nonnull)response;

@end
