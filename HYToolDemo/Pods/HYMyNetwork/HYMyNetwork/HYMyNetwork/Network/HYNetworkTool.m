//
//  HYNetworkTool.m
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "HYNetworkTool.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#define HTTPMethodGET @"GET"
#define HTTPMethodPOST @"POST"
#define HTTPMethodUPLOAD @"UPLOAD"

@implementation HYNetworkTool

+ (instancetype)sharedNetworkTool{
    static HYNetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HYNetworkTool alloc] init];
    });
    return instance;
    /*
     @discussion
     关键两点:
     一、初始化代码只执行一次；
     二、第一次初始化代码得到的对象用全局变量保存；
     */
}

- (void)GETURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure {
    [self _requestDataTaskWithHTTPMethod:HTTPMethodGET URLString:urlString parameters:parameters fileKey:nil fileName:nil filePath:nil progress:nil success:success failure:failure];
}

- (void)POSTURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure {
    [self _requestDataTaskWithHTTPMethod:HTTPMethodPOST URLString:urlString parameters:parameters fileKey:nil fileName:nil filePath:nil progress:nil success:success failure:failure];
}

- (void)uploadURLString:(NSString *)urlString fileKey:(NSString *)fileKey fileName:(NSString *)fileName filePath:(NSString *)filePath success:(success)success failure:(failure)failure {
    [self _requestDataTaskWithHTTPMethod:HTTPMethodUPLOAD URLString:urlString parameters:nil fileKey:fileKey fileName:fileName filePath:filePath progress:nil success:success failure:failure];
}

#pragma mark - 私有方法
- (void)_requestDataTaskWithHTTPMethod:(NSString *)method
                             URLString:(NSString *)URLString
                            parameters:(id)parameters
                               fileKey:(NSString *)fileKey
                              fileName:(NSString *)fileName
                              filePath:(NSString *)filePath
                              progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                               success:(success)success
                               failure:(failure)failure {
    
    AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
//    jsonResponseSerializer.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = jsonResponseSerializer;
    if ([method isEqualToString:HTTPMethodGET]) {
        
        [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success((responseObject && [responseObject isKindOfClass:[NSDictionary class]]) ? responseObject : nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) failure(error);
        }];
        
    } else if ([method isEqualToString:HTTPMethodPOST]) {
        
        [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success((responseObject && [responseObject isKindOfClass:[NSDictionary class]]) ? responseObject : nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) failure(error);
        }];
        
    } else if ([method isEqualToString:HTTPMethodUPLOAD]) {
        
        //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:fileKey fileName:fileName mimeType:@"application/zip" error:nil];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success((responseObject && [responseObject isKindOfClass:[NSDictionary class]]) ? responseObject : nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) failure(error);
        }];
        
    }
    /*
     @discussion
     1、当AFHTTPSessionManager的responseSerializer为AFHTTPResponseSerializer时，responseObject为NSData类型，需要用下面的方法转为NSDictionary类型
     NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
     2、当AFHTTPSessionManager的responseSerializer为AFJSONResponseSerializer时，responseObject为NSDictionary类型，不需要转换类型
     */
}

@end
