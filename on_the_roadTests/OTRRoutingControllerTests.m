//
//  OTRRoutingControllerTests.m
//  TBMapzenRouting
//
//  Created by Sarah Lensing on 3/10/17.
//  Copyright © 2017 Trailbehind inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "OTRRoutingController.h"


@interface TestSessionDataTask : NSURLSessionDataTask

@end

@implementation TestSessionDataTask

- (void)resume {

}

@end


@interface TestUrlSession : NSURLSession

@property (nonatomic, strong) NSDictionary *queryParameters;

@end

@implementation TestUrlSession

@synthesize queryParameters;

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
  NSString *decoded = [[url.query stringByRemovingPercentEncoding] stringByReplacingOccurrencesOfString:@"json=" withString:@""];
  NSData *data = [decoded dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error;
  queryParameters = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
  return [[TestSessionDataTask alloc] init];
}

@end

@interface OTRRoutingControllerTests : XCTestCase {
  OTRRoutingController *controller;
  TestUrlSession *urlSessionManager;
}

@end


@implementation OTRRoutingControllerTests

- (void)setUp {
  [super setUp];
  urlSessionManager = [[TestUrlSession alloc] init];
  controller = [[OTRRoutingController alloc] initWithSessionManager:urlSessionManager];
}

- (void)testCurrentLocaleLanguageSetByDefault {
  OTRRoutingPoint *loc1 = [[OTRRoutingPoint alloc] init];
  OTRRoutingPoint *loc2 = [[OTRRoutingPoint alloc] init];
  NSArray<OTRRoutingPoint*> *locations = [NSArray arrayWithObjects:loc1, loc2, nil];
  [controller requestRouteWithLocations:locations
                            costingModel:OTRRoutingCostingModelAuto
                           costingOption:nil
                       directionsOptions:nil
                                callback:^(OTRRoutingResult * _Nullable result, id  _Nullable invalidationToken, NSError * _Nullable error) {
                                  //
                                }];
  NSDictionary *directionsOptions = [urlSessionManager.queryParameters objectForKey:@"directions_options"];
  XCTAssertNotNil(directionsOptions);
  XCTAssertEqualObjects([directionsOptions objectForKey:@"language"], [NSLocale currentLocale].languageCode);
}

- (void)testLanguageSetInDirectionsOptions {
  OTRRoutingPoint *loc1 = [[OTRRoutingPoint alloc] init];
  OTRRoutingPoint *loc2 = [[OTRRoutingPoint alloc] init];
  NSArray<OTRRoutingPoint*> *locations = [NSArray arrayWithObjects:loc1, loc2, nil];
  NSDictionary *options = [NSDictionary dictionaryWithObject:@"fr-FR" forKey:@"language"];
  [controller requestRouteWithLocations:locations
                           costingModel:OTRRoutingCostingModelAuto
                          costingOption:nil
                      directionsOptions:options
                               callback:^(OTRRoutingResult * _Nullable result, id  _Nullable invalidationToken, NSError * _Nullable error) {
                                 //
                               }];
  NSDictionary *directionsOptions = [urlSessionManager.queryParameters objectForKey:@"directions_options"];
  XCTAssertNotNil(directionsOptions);
  XCTAssertEqualObjects([directionsOptions objectForKey:@"language"], @"fr-FR");
}

@end
