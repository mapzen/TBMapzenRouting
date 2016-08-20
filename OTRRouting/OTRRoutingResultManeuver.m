//
//  OTRRoutingResultManeuver.m
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import "OTRRoutingResultManeuver.h"

@implementation OTRRoutingResultManeuver

+ (instancetype _Nullable)maneuverFromDictionary:(NSDictionary * _Nonnull)response {
  OTRRoutingResultManeuver *maneuver = [[OTRRoutingResultManeuver alloc] init];
  
  maneuver.type = [response[@"type"] unsignedLongValue];
  maneuver.instruction = response[@"instruction"];
  maneuver.verbalTransitionAlertInstruction = response[@"verbal_transition_alert_instruction"];
  maneuver.verbalPreTransitionInstruction = response[@"verbal_pre_transition_instruction"];
  maneuver.verbalPostTransitionInstruction = response[@"verbal_post_transition_instruction"];
  maneuver.streetNames = response[@"street_names"];
  maneuver.beginStreetNames = response[@"begin_street_names"];
  maneuver.time = [response[@"time"] unsignedLongValue];
  maneuver.length = [response[@"length"] doubleValue];
  maneuver.beginShapeIndex = [response[@"begin_shape_index"] unsignedLongValue];
  maneuver.endShapeIndex = [response[@"end_shape_index"] unsignedLongValue];
  maneuver.toll = [response[@"toll"] boolValue];
  maneuver.rough = [response[@"rough"] boolValue];
  maneuver.gate = [response[@"gate"] boolValue];
  maneuver.ferry = [response[@"ferry"] boolValue];
  maneuver.sign = response[@"sign"];
  maneuver.roundaboutExitCount = [response[@"roundabout_exit_count"] unsignedLongValue];
  maneuver.departInstruction = response[@"depart_instruction"];
  maneuver.verbalDepartInstruction = response[@"verbal_depart_instruction"];
  maneuver.arriveInstruction = response[@"arrive_instruction"];
  maneuver.verbalArriveInstruction = response[@"verbal_arrive_instruction"];
  maneuver.transitInfo = response[@"transit_info"];
  maneuver.verbalMultiCue = [response[@"verbal_multi_cue"] boolValue];
  maneuver.travelMode = response[@"travel_mode"];
  maneuver.travelType = response[@"travel_type"];
  
  return maneuver;
}

@end
