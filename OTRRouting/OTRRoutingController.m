//
//  OTRRoutingController.m
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import "OTRRoutingController.h"

@interface OTRRoutingController ()

@property (nonatomic, strong, nonnull) NSURLSession *urlSessionManager;

@end


@implementation OTRRoutingController

- (instancetype _Nonnull)init {
  return [self initWithSessionManager:[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]]];
}

- (instancetype _Nonnull)initWithSessionManager:(NSURLSession*  _Nonnull)session {
  self = [super init];
  self.baseUrl = @"https://valhalla.mapzen.com/route?";
  self.urlSessionManager = session;
  self.urlQueryComponents = [[NSMutableArray alloc] init];
  return self;
}


- (NSURLSessionDataTask * _Nullable)requestRouteWithLocations:(NSArray<OTRRoutingPoint*>* _Nonnull)locations
                             costingModel:(OTRRoutingCostingModel)costing
                            costingOption:(NSDictionary<NSString*, NSObject*>* _Nullable)costingOptions
                        directionsOptions:(NSDictionary<NSString*, NSObject*>* _Nullable)directionsOptions
                                 callback:(void (^ _Nonnull)(OTRRoutingResult  * _Nullable result,
                                                             id _Nullable invalidationToken,
                                                             NSError * _Nullable error ))callback {
  if(locations.count < 2) {
    callback(nil, nil, [NSError errorWithDomain:@"OTRRoutingController"
                                           code:0
                                       userInfo:@{NSLocalizedDescriptionKey: @"Locations array must contain 2 or more locations"}]);
    return nil;
  }
  
  NSMutableDictionary *jsonParameters = [NSMutableDictionary dictionaryWithCapacity:2];
  jsonParameters[@"costing"] = [OTRRoutingTypes stringFromCostingModel:costing];
  jsonParameters[@"locations"] = [OTRRoutingController convertLocationsToDictionarys:locations];
  
  if(costingOptions) {
    if(![NSJSONSerialization isValidJSONObject:costingOptions]) {
      callback(nil, nil, [NSError errorWithDomain:@"OTRRoutingController"
                                             code:0
                                         userInfo:@{NSLocalizedDescriptionKey: @"costingOptions is not a valid json object"}]);
      return nil;
    }
    jsonParameters[@"costing_options"] = costingOptions;
  }
  
  if(!directionsOptions) {
    directionsOptions = [NSDictionary dictionaryWithObject:[NSLocale currentLocale].languageCode forKey:@"language"];
  } else if (![directionsOptions.allKeys containsObject:@"language"]) {
    NSMutableDictionary *mutableOptions = [directionsOptions mutableCopy];
    [mutableOptions setObject:[NSLocale currentLocale].languageCode forKey:@"language"];
    directionsOptions = mutableOptions;
  }
  if(![NSJSONSerialization isValidJSONObject:directionsOptions]) {
    callback(nil, nil, [NSError errorWithDomain:@"OTRRoutingController"
                                           code:0
                                       userInfo:@{NSLocalizedDescriptionKey: @"directionsOptions is not a valid json object"}]);
    return nil;
  }
  jsonParameters[@"directions_options"] = directionsOptions;

  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonParameters
                                                     options:0
                                                       error:nil];
  NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  NSURLComponents *urlComponents = [NSURLComponents componentsWithString:self.baseUrl];
  NSMutableArray *queryComponents = [[NSMutableArray alloc] init];
  [queryComponents addObject:[NSURLQueryItem queryItemWithName:@"json" value:jsonString]];
  //Adding the components to a newly created array avoids re-adding the same values multiple times and thus having weird issues later
  if (self.urlQueryComponents.count > 0) {
    [queryComponents addObjectsFromArray:self.urlQueryComponents];
  }

  urlComponents.queryItems = queryComponents;
  
  NSURLSessionDataTask *task;
  task =
  [self.urlSessionManager dataTaskWithURL:urlComponents.URL
                        completionHandler:
   ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     if(error || ((NSHTTPURLResponse*)response).statusCode != 200) {
       NSString *responseString;
       if(data) {
         responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       }
       dispatch_async(dispatch_get_main_queue(), ^{
         callback(nil, task, [NSError errorWithDomain:@"TBMapzenRoutingServerResponse"
                                                 code:((NSHTTPURLResponse*)response).statusCode
                                             userInfo:@{NSLocalizedDescriptionKey:responseString ?: @"unknown error"}]);
       });
     } else {
       NSError *error;
       NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:&error];
       if(error) {
         dispatch_async(dispatch_get_main_queue(), ^{
           callback(nil, nil, [NSError errorWithDomain:@"TBMapzenRoutingServerResponse"
                                                  code:0
                                              userInfo:@{NSLocalizedDescriptionKey: @"response is not a valid json object"}]);
         });
       } else {
         OTRRoutingResult *result = [OTRRoutingController parseServerResponse:responseDictionary
                                                                                   task:task
                                                                                  error:&error];
         dispatch_async(dispatch_get_main_queue(), ^{
           callback(result, task, error);
         });
       }
     }
   }];
  [task resume];
  return task;
}


- (void)cancelRoutingRequest:(NSURLSessionDataTask *)requestToken {
    [requestToken cancel];
}


+ (OTRRoutingResult* _Nullable)parseServerResponse:(NSDictionary * _Nonnull)response
                                                   task:(NSURLSessionDataTask * _Nonnull)task
                                                  error:(NSError * _Nullable *)error {
  OTRRoutingResult *result = [OTRRoutingResult resultFromResponse:response];
  return result;
}


+ (NSArray <NSDictionary*> *)convertLocationsToDictionarys:(NSArray<OTRRoutingPoint*>* _Nonnull)locations {
  NSMutableArray *output = [NSMutableArray arrayWithCapacity:locations.count];
  for(OTRRoutingPoint *point in locations) {
    [output addObject:[point asDictionary]];
  }
  return output;
}


@end
