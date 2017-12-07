#import "Timer.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

@implementation Timer

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"timer" serviceName:@"Timer"]);
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}


#pragma mark Timer(TimeRequest) returns (stream TimeResponse)

- (void)timerWithRequest:(TimeRequest *)request eventHandler:(void(^)(BOOL done, TimeResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToTimerWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToTimerWithRequest:(TimeRequest *)request eventHandler:(void(^)(BOOL done, TimeResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"Timer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TimeResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
@end
