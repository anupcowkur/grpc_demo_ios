//
//  ViewController.m
//  grpc_demo_ios
//
//  Created by Anup Cowkur on 07/12/17.
//  Copyright © 2017 Anup Cowkur. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <GRPCClient/GRPCCall+Tests.h>
#import <Timer.pbrpc.h>
#import <RxLibrary/GRXWriter+Immediate.h>
#import <RxLibrary/GRXWriter+Transformations.h>

static NSString * const kHostAddress = @"localhost:50051";

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation ViewController {
    Timer *_service;
}

- (void)execRequest {
    TimeRequest *request = [[TimeRequest alloc]init];
    
    [_service timerWithRequest:request eventHandler:^(BOOL done, TimeResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            self.timeLabel.text = [NSString stringWithFormat:@"%@", response.time];
        } else if (error) {
            self.timeLabel.text = @"Server down";
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // This only needs to be done once per host, before creating service objects for that host.
    [GRPCCall useInsecureConnectionsForHost:kHostAddress];
    
    _service = [[Timer alloc] initWithHost:kHostAddress];
}

- (void)viewDidAppear:(BOOL)animated {
    [self execRequest];
}
@end
