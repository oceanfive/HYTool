//
//  HYNetworkReachabilityManager.h
//  HYKit
//
//  Created by ocean on 2017/11/2.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *HYNetworkStatusChangedNotification;

typedef NS_ENUM(NSUInteger, HYNetworkStatus) {
    HYNetworkStatusNotReachable,
    HYNetworkStatusWiFi,
    HYNetworkStatusWWAN,
    HYNetworkStatus4G,
    HYNetworkStatus3G,
    HYNetworkStatus2G,
    HYNetworkStatusOthers,
};


@interface HYNetworkReachabilityManager : NSObject

/**
 单例对象，初始化
 */
+ (instancetype)sharedManager;

/**
 开始监测网络状态变化
 */
- (void)startMonitoring;

/**
 结束监测网络状态变化
 */
- (void)stopMonitoring;

/**
 当前的网络状态
 */
@property (nonatomic, assign, readonly) HYNetworkStatus currentNetworkStatus;

/**
 当前的网络状态，字符串，和 HYNetworkStatus 对应关系为
 HYNetworkStatus                     currentNetworkStatusString
 HYNetworkStatusNotReachable         NO
 HYNetworkStatusWiFi                 WiFi
 HYNetworkStatusWWAN                 WWAN
 HYNetworkStatus4G                   4G
 HYNetworkStatus3G                   3G
 HYNetworkStatus2G                   2G
 HYNetworkStatusOthers               Others
 */
@property (nonatomic, copy, readonly) NSString *currentNetworkStatusString;

/**
 当前是否可以连接网
 */
@property (nonatomic, assign, readonly, getter=isReachable) BOOL reachable;

@end

NS_ASSUME_NONNULL_END
