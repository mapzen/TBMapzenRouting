//
//  OTRRoutingResultManeuver.h
//  on-the-road_ios
//
//  Based upon the work in TBMapzenRouting created by Jesse Crocker
//
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSUInteger, TBMapzenRoutingResultManeuverType) {
  TBMapzenRoutingResultManeuverTypeNone = 0,
  TBMapzenRoutingResultManeuverTypeStart = 1,
  TBMapzenRoutingResultManeuverTypeStartRight = 2,
  TBMapzenRoutingResultManeuverTypeStartLeft = 3,
  TBMapzenRoutingResultManeuverTypeDestination = 4,
  TBMapzenRoutingResultManeuverTypeDestinationRight = 5,
  TBMapzenRoutingResultManeuverTypeDestinationLeft = 6,
  TBMapzenRoutingResultManeuverTypeBecomes = 7,
  TBMapzenRoutingResultManeuverTypeContinue = 8,
  TBMapzenRoutingResultManeuverTypeSlightRight = 9,
  TBMapzenRoutingResultManeuverTypeRight = 10,
  TBMapzenRoutingResultManeuverTypeSharpRight = 11,
  TBMapzenRoutingResultManeuverTypeUturnRight = 12,
  TBMapzenRoutingResultManeuverTypeUturnLeft = 13,
  TBMapzenRoutingResultManeuverTypeSharpLeft = 14,
  TBMapzenRoutingResultManeuverTypeLeft = 15,
  TBMapzenRoutingResultManeuverTypeSlightLeft = 16,
  TBMapzenRoutingResultManeuverTypeRampStraight = 17,
  TBMapzenRoutingResultManeuverTypeRampRight = 18,
  TBMapzenRoutingResultManeuverTypeRampLeft = 19,
  TBMapzenRoutingResultManeuverTypeExitRight = 20,
  TBMapzenRoutingResultManeuverTypeExitLeft = 21,
  TBMapzenRoutingResultManeuverTypeStayStraight = 22,
  TBMapzenRoutingResultManeuverTypeStayRight = 23,
  TBMapzenRoutingResultManeuverTypeStayLeft = 24,
  TBMapzenRoutingResultManeuverTypeMerge = 25,
  TBMapzenRoutingResultManeuverTypeRoundaboutEnter = 26,
  TBMapzenRoutingResultManeuverTypeRoundaboutExit = 27,
  TBMapzenRoutingResultManeuverTypeFerryEnter = 28,
  TBMapzenRoutingResultManeuverTypeFerryExit = 29,
  TBMapzenRoutingResultManeuverTypeTransit = 30,
  TBMapzenRoutingResultManeuverTypeTransitTransfer = 31,
  TBMapzenRoutingResultManeuverTypeTransitRemainOn = 32,
  TBMapzenRoutingResultManeuverTypeTransitConnectionStart = 33,
  TBMapzenRoutingResultManeuverTypeTransitConnectionTransfer = 34,
  TBMapzenRoutingResultManeuverTypeTransitConnectionDestination = 35,
  TBMapzenRoutingResultManeuverTypePostTransitConnectionDestination = 36
};

@interface OTRRoutingResultManeuver : NSObject

/** Create a Maneuver object by parsing an element of the maneuver array of a leg from the server json response. */
+ (instancetype _Nullable)maneuverFromDictionary:(NSDictionary * _Nonnull)response;

/** Type of maneuver. */
@property (nonatomic, assign) TBMapzenRoutingResultManeuverType type;

/** Text suitable for use as a verbal alert in a navigation application. The transition alert instruction will prepare the user for the forthcoming transition. For example: “Turn right onto North Prince Street”. */
@property (nonatomic, strong, nullable) NSString *instruction;

/** Text suitable for use as a verbal message immediately prior to the maneuver transition. For example “Turn right onto North Prince Street, U.S. 2 22”.
  
 Equivalent to `verbal_transition_alert_instruction` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *verbalTransitionAlertInstruction;

/** Text suitable for use as a verbal message immediately prior to the maneuver transition. For example “Turn right onto North Prince Street, U.S. 2 22”. 
 
 Equivalent to `verbal_pre_transition_instruction` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *verbalPreTransitionInstruction;

/** Text suitable for use as a verbal message immediately after the maneuver transition. For example “Continue on U.S. 2 22 for 3.9 miles”.
 
Equivalent to `verbal_post_transition_instruction` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *verbalPostTransitionInstruction;

/**	List of street names that are consistent along the entire maneuver.
 
 Equivalent to `street_names` key in server json response.
 */
@property (nonatomic, strong, nullable) NSArray<NSString*> *streetNames;

/** When present, these are the street names at the beginning of the maneuver (if they are different than the names that are consistent along the entire maneuver). 
 
 Equivalent to `begin_street_names` key in server json response.
 */
@property (nonatomic, strong, nullable) NSArray<NSString*> *beginStreetNames;

/** Estimated time along the maneuver in seconds.*/
@property (nonatomic, assign) NSUInteger time;

/** Maneuver length in the units specified. */
@property (nonatomic, assign) CGFloat length;

/** Index into the list of shape points for the start of the maneuver. 
 
 Equivalent to `begin_shape_index` key in server json response.
 */
@property (nonatomic, assign) NSUInteger beginShapeIndex;

/** Index into the list of shape points for the end of the maneuver. 
 
 Equivalent to `end_shape_index` key in server json response.
 */
@property (nonatomic, assign) NSUInteger endShapeIndex;

/**	True if the maneuver has any toll, or portions of the maneuver are subject to a toll. */
@property (nonatomic, assign) BOOL toll;

/** True if the maneuver is unpaved or rough pavement, or has any portions that have rough pavement. */
@property (nonatomic, assign) BOOL rough;

/** True if a gate is encountered on this maneuver. */
@property (nonatomic, assign) BOOL gate;

/** True if a ferry is encountered on this maneuver. */
@property (nonatomic, assign) BOOL ferry;

/** Contains the interchange guide information at a road junction associated with this maneuver.
 
 The maneuver sign may contain four lists of interchange sign elements as follows:
 * exit_number_elements = list of exit number elements. If an exit number element exists, it is typically just one value.
 * exit_branch_elements = list of exit branch elements. The exit branch element text is the subsequent road name or route number after the sign.
 * exit_toward_elements = list of exit toward elements. The exit toward element text is the location where the road ahead goes - the location is typically a control city, but may also be a future road name or route number.
 * exit_name_elements = list of exit name elements. The exit name element is the interchange identifier - typically not used in the US.
 */
@property (nonatomic, strong, nullable) NSDictionary <NSString*, NSArray<NSString*>*> *sign;

/** The spoke to exit roundabout after entering. 
 
 Equivalent to `roundabout_exit_count` key in server json response.
 */
@property (nonatomic, assign) NSUInteger roundaboutExitCount;

/** Written depart time instruction. Typically used with a transit maneuver, such as “Depart: 8:04 AM from 8 St - NYU”. 
 
 Equivalent to `depart_instruction` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *departInstruction;

/** Text suitable for use as a verbal depart time instruction. Typically used with a transit maneuver, such as “Depart at 8:04 AM from 8 St - NYU”.
 
 Equivalent to `verbal_depart_instruction` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *verbalDepartInstruction;

/** Written arrive time instruction. Typically used with a transit maneuver, such as “Arrive: 8:10 AM at 34 St - Herald Sq”.
 
 Equivalent to `arrive_instruction` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *arriveInstruction;

/** Text suitable for use as a verbal arrive time instruction. Typically used with a transit maneuver, such as “Arrive at 8:10 AM at 34 St - Herald Sq”.
 
 Equivalent to `verbal_arrive_instruction` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *verbalArriveInstruction;

/** Contains the attributes that descibe a specific transit route.
 
 Equivalent to `transit_info` key in server json response.
 */
@property (nonatomic, strong, nullable) NSDictionary<NSString*,NSObject*> * transitInfo;

/** True if the verbal_pre_transition_instruction has been appended with the verbal instruction of the next maneuver.
 
 Equivalent to `verbal_multi_cue` key in server json response.
 */
@property (nonatomic, assign) BOOL verbalMultiCue;

/** Travel mode.

 One of:
 * “drive”
 * “pedestrian”
 * “bicycle”
 * “transit”
 
 Equivalent to `travel_mode` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *travelMode;

/** Travel Type:
 Travel type for drive.
 “car”
 
 Travel type for pedestrian.
 “foot”
 
 Travel type for bicycle.
 “road”
 
 Travel type for transit.
 Tram or light rail = “tram”
 Metro or subway = “metro”
 Rail = “rail”
 Bus = “bus”
 Ferry = “ferry”
 Cable car = “cable_car”
 Gondola = “gondola”
 Funicular = “funicular”
 
 Equivalent to `travel_type` key in server json response.
 */
@property (nonatomic, strong, nullable) NSString *travelType;


@end
