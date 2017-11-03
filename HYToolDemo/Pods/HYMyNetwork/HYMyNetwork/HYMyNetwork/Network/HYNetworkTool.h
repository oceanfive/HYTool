//
//  HYNetworkTool.h
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  网络请求工具类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 网络请求成功回调block */
typedef void(^success)(NSDictionary * _Nullable responseObject);
/** 网络请求失败回调block */
typedef void(^failure)(NSError * _Nullable error);

@interface HYNetworkTool : NSObject

/**
 工具类单例
 */
+ (instancetype)sharedNetworkTool;

/**
 GET请求

 @param urlString 接口url
 @param parameters 传递参数
 @param success 成功回调block
 @param failure 失败回调block
 */
- (void)GETURLString:(nullable NSString *)urlString parameters:(nullable NSDictionary *)parameters success:(nullable success)success failure:(nullable failure)failure;

/**
 POST请求

 @param urlString 接口url
 @param parameters 传递参数
 @param success 成功回调block
 @param failure 失败回调block
 */
- (void)POSTURLString:(nullable NSString *)urlString parameters:(nullable NSDictionary *)parameters success:(nullable success)success failure:(nullable failure)failure;

/**
 上传zip文件

 @param urlString 接口url
 @param fileKey 服务器接受文件key值
 @param fileName 文件在服务器保存的名字
 @param filePath 上传文件的路径
 @param success 成功回调block
 @param failure 失败回调block
 */
- (void)uploadURLString:(nullable NSString *)urlString fileKey:(nullable NSString *)fileKey fileName:(nullable NSString *)fileName filePath:(nullable NSString *)filePath success:(nullable success)success failure:(nullable failure)failure;

@end

NS_ASSUME_NONNULL_END
