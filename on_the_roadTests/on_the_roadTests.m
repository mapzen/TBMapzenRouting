//
//  on_the_roadTests.m
//  on_the_roadTests
//
//  Created by Matt Smollinger on 8/31/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OTRRouting.h"

@interface on_the_roadTests : XCTestCase

@end

@implementation on_the_roadTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRoutingControllerInstantiation {
  OTRRoutingController *controller = [[OTRRoutingController alloc] init];
  XCTAssertNotNil(controller, "Controller is nil");
}
@end
