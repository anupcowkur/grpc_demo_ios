#import "Timer.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#if GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  @class TimeRequest;
  @class TimeResponse;
#else
#endif


NS_ASSUME_NONNULL_BEGIN

@protocol Timer <NSObject>

#pragma mark Timer(TimeRequest) returns (stream TimeResponse)

- (void)timerWithRequest:(TimeRequest *)request eventHandler:(void(^)(BOOL done, TimeResponse *_Nullable response, NSError *_Nullable error))eventHandler;

- (GRPCProtoCall *)RPCToTimerWithRequest:(TimeRequest *)request eventHandler:(void(^)(BOOL done, TimeResponse *_Nullable response, NSError *_Nullable error))eventHandler;


@end

/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface Timer : GRPCProtoService<Timer>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end

NS_ASSUME_NONNULL_END
