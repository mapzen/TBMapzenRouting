//
//  OTRRoutingResultLeg.m
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import "OTRRoutingResultLeg.h"

@interface OTRRoutingResultLeg ()

@property (nonatomic, strong, nonnull) NSArray <OTRRoutingResultManeuver*>* maneuvers;
@property (nonatomic, assign) NSUInteger coordinateCount;
@property (nonatomic, assign, nullable) OTRGeoPoint *coordinates;

@end


@implementation OTRRoutingResultLeg


+ (instancetype _Nullable)legFromDictionary:(NSDictionary * _Nonnull)response {
  OTRRoutingResultLeg *leg = [[OTRRoutingResultLeg alloc] init];
  leg.length = [response[@"summary"][@"length"] doubleValue];
  leg.time = [response[@"summary"][@"time"] doubleValue];
  NSMutableArray *maneuvers = [NSMutableArray arrayWithCapacity:[(NSArray*)response[@"maneuvers"] count]];
  for(NSDictionary *maneuver in response[@"maneuvers"]) {
    [maneuvers addObject:[OTRRoutingResultManeuver maneuverFromDictionary:maneuver]];
  }
  leg.maneuvers = maneuvers;
  leg.coordinates = [OTRRoutingResultLeg decodePolyline:response[@"shape"]
                                             length:&leg->_coordinateCount];
  
  return leg;
}


- (NSString * _Nonnull)description {
  return [NSString stringWithFormat:@"<%@: %p> length:%f time:%f maneuvers:%lu coordinates:%lu",
          NSStringFromClass([self class]), self,
          self.length, self.time,
          (unsigned long)self.maneuvers.count, (unsigned long)self.coordinateCount];
}


- (void)dealloc {
  free(self.coordinates);
}


+ (OTRGeoPoint*)decodePolyline:(NSString*)polyline length:(NSUInteger*)outputLength {
  const char *bytes = [polyline UTF8String];
  NSUInteger length = [polyline lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
  
  NSUInteger allocCount = length/4;
  OTRGeoPoint *coords = calloc(allocCount, sizeof(OTRGeoPoint));
  
  NSUInteger idx = 0;
  NSUInteger coordIdx = 0;
  
  CGFloat latitude = 0;
  CGFloat longitude = 0;
  while (idx < length) {
    char byte = 0;
    int res = 0;
    char shift = 0;
    
    do {
      byte = bytes[idx++] - 63;
      res |= (byte & 0x1F) << shift;
      shift += 5;
    } while (byte >= 0x20);
    
    float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
    latitude += deltaLat;
    
    shift = 0;
    res = 0;
    
    do {
      byte = bytes[idx++] - 0x3F;
      res |= (byte & 0x1F) << shift;
      shift += 5;
    } while (byte >= 0x20);
    
    float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
    longitude += deltaLon;
    
    coords[coordIdx++] = OTRGeoPointMake(latitude * 1E-6, longitude * 1E-6);
    
    if (coordIdx == allocCount) {
      allocCount += 10;
      coords = realloc(coords, allocCount * sizeof(OTRGeoPoint));
    }
  }
  
  *outputLength = coordIdx;
  return coords;
}


@end
