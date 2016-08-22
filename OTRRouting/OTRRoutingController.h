//
//  OTRRoutingController.h
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import <Foundation/Foundation.h>
#import "OTRRoutingResult.h"
#import "OTRRoutingTypes.h"
#import "OTRRoutingPoint.h"

@interface OTRRoutingController : NSObject

/** URL for routing server. Defaults to URL for Mapzen Turn-by-Turn production server. */
@property (nonatomic, strong, nonnull) NSString *baseUrl;

/** Mapzen Turn-by-Turn api key. */
@property (nonatomic, strong, nonnull) NSString *apiKey;

/**
 Create a new routing controller configured to connect to the Mapzen Turn-by-Turn production server.
 
 @param apiKey API to be used for routing requests.
 */
- (instancetype _Nonnull)initWithApiKey:(NSString * _Nonnull)apiKey;

/**
 Request a route.
 
 @param locations Locations to route to/thru
 @param costing Costing mode
 @param costingOptions costing options
 @param directionsOptions options for directions output
 @param callback Callback function. 

 @return an opaque object that can be used to cancel the routing request before it has completed.
 */
- (id _Nullable)requestRouteWithLocations:(NSArray<OTRRoutingPoint*>* _Nonnull)locations
                     costingModel:(OTRRoutingCostingModel)costing
                    costingOption:(NSDictionary<NSString*, NSObject*>* _Nullable)costingOptions
                directionsOptions:(NSDictionary<NSString*, NSObject*>* _Nullable)directionsOptions
                         callback:(void (^ _Nonnull)(OTRRoutingResult  * _Nullable result,
                                                     id _Nullable invalidationToken,
                                                     NSError * _Nullable error ))callback;

/** Cancel an in-progress routing request. Cancelation is not guaranteed to succeed.
 
 @param requestToken an object returned by requestRouteWithLocations:costingModel:costingOption:directionsOptions:callback
 */
- (void)cancelRoutingRequest:(id _Nonnull)requestToken;

@end
