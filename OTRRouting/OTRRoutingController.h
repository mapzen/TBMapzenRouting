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

/**
 `OTRRoutingController` is the primary means for interacting with a particular Valhalla instance. It defaults to the Mapzen hosted Turn-by-Turn service which does expect an API key to be part of the URL query parameters sent along in the request.
 
 The main entry point is `requestRouteWithLocations:costingModel:costingOption:directionsOptions:callback:` which, if successful, returns a fully baked routing result object in the provided block.
 */

@interface OTRRoutingController : NSObject

/** URL for routing server. Defaults to URL for Mapzen Turn-by-Turn production server. */
@property (nonatomic, strong, nonnull) NSString *baseUrl;

/** 
 URL Query components that get added to the URL Request. If you're connecting to Mapzen's hosted service, you'll want to add your API key here. 
 */
@property (nonatomic, strong, nonnull) NSMutableArray<NSURLQueryItem*> *urlQueryComponents;

/** Create a new routing controller configured to connect to the Mapzen Turn-by-Turn production server. */
- (instancetype _Nonnull)init;

/** Create a new routing controller configured to connect to the session. Useful for testing

 @param session NSURLSession to route requests through
 */
- (instancetype _Nonnull)initWithSessionManager:(NSURLSession* _Nonnull)session;

/**
 Request a route.
 
 @param locations Locations to route to/thru
 @param costing Costing mode
 @param costingOptions costing options
 @param directionsOptions options for directions output. Note that if you request a language that is not supported, the router will default to use english.
 @param callback Callback function. 

 @return an NSURLSessionDataTask object that can be used to cancel the routing request before it has completed.
 */
- (NSURLSessionDataTask * _Nullable)requestRouteWithLocations:(NSArray<OTRRoutingPoint*>* _Nonnull)locations
                     costingModel:(OTRRoutingCostingModel)costing
                    costingOption:(NSDictionary<NSString*, NSObject*>* _Nullable)costingOptions
                directionsOptions:(NSDictionary<NSString*, NSObject*>* _Nullable)directionsOptions
                         callback:(void (^ _Nonnull)(OTRRoutingResult  * _Nullable result,
                                                     id _Nullable invalidationToken,
                                                     NSError * _Nullable error ))callback;

/** 
 Cancel an in-progress routing request. Cancelation is not guaranteed to succeed.
 
 @param requestToken an object returned by requestRouteWithLocations:costingModel:costingOption:directionsOptions:callback
 */
- (void)cancelRoutingRequest:(NSURLSessionDataTask * _Nonnull)requestToken;

@end
