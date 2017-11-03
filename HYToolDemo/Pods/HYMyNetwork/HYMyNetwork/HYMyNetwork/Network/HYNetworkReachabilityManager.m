//
//  HYNetworkReachabilityManager.m
//  HYKit
//
//  Created by ocean on 2017/11/2.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import "HYNetworkReachabilityManager.h"
#import "Reachability.h"

NSString *HYNetworkStatusChangedNotification = @"HYNetworkStatusChangedNotification";

@interface HYNetworkReachabilityManager ()

@property (nonatomic, strong) Reachability *hostReachability;
@property (nonatomic, assign, readwrite) HYNetworkStatus currentNetworkStatus;
@property (nonatomic, copy, readwrite) NSString *currentNetworkStatusString;
@property (nonatomic, assign, readwrite) BOOL reachable;

@end

@implementation HYNetworkReachabilityManager

+ (instancetype)sharedManager {
    static HYNetworkReachabilityManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HYNetworkReachabilityManager alloc] init];
    });
    return instance;
}

- (void)startMonitoring {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        NSString *remoteHostName = @"www.apple.com";
        _hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
        [_hostReachability startNotifier];
    });
}

- (void)reachabilityChanged:(NSNotification *)notification {
    Reachability *curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            _currentNetworkStatus = HYNetworkStatusNotReachable;
            _currentNetworkStatusString = @"NO";
            _reachable = NO;
            NSLog(@"====当前网络状态为:不可用=======");
            break;
        case ReachableViaWiFi:
            _currentNetworkStatus = HYNetworkStatusWiFi;
            _currentNetworkStatusString = @"WiFi";
            _reachable = YES;
            NSLog(@"====当前网络状态为:WiFi=======");
            break;
        case kReachableVia2G:
            _currentNetworkStatus = HYNetworkStatus2G;
            _currentNetworkStatusString = @"2G";
            _reachable = YES;
            NSLog(@"====当前网络状态为:2G=======");
            break;
        case kReachableVia3G:
            _currentNetworkStatus = HYNetworkStatus3G;
            _currentNetworkStatusString = @"3G";
            _reachable = YES;
            NSLog(@"====当前网络状态为:3G=======");
            break;
        case kReachableVia4G:
            _currentNetworkStatus = HYNetworkStatus4G;
            _currentNetworkStatusString = @"4G";
            _reachable = YES;
            NSLog(@"====当前网络状态为:4G=======");
            break;
        default:
            _currentNetworkStatus = HYNetworkStatusOthers;
            _currentNetworkStatusString = @"Others";
            _reachable = YES;
            NSLog(@"====当前网络状态为:Others=======");
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:HYNetworkStatusChangedNotification object:nil];
}

- (void)stopMonitoring {
    if (self.hostReachability) {
        [self.hostReachability stopNotifier];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
