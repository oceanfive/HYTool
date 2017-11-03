//
//  HYEncodeTool.h
//  Category
//
//  Created by wuhaiyang on 16/8/24.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  编码工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYEncodeTool : NSObject

/** 
 小写MD5编码 
 */
+ (NSString *)hy_md5Lowercase:(NSString *)str;

/** 
 小写sha224编码 
 */
+ (NSString *)hy_sha224Lowercase:(NSString *)str;

/** 
 小写sha256编码 
 */
+ (NSString *)hy_sha256Lowercase:(NSString *)str;

/** 
 小写sha384编码 
 */
+ (NSString *)hy_sha384Lowercase:(NSString *)str;

/** 
 小写sha512编码 
 */
+ (NSString *)hy_sha512Lowercase:(NSString *)str;

/** 
 base64编码 
 */
+ (NSString *)hy_base64Encode:(NSString *)str;

/** 
 base64解码 
 */
+ (NSString *)hy_base64Decode:(NSString *)str;

/** 
 URL编码 
 备注：完整的URL不能进行URL编码，一般是URL的参数进行URL编码，即http:// 后面的参数进行URL编码
 */
+ (NSString *)hy_urlEncode:(NSString *)str;

/** 
 URL解码 
 */
+ (NSString *)hy_urlDecode:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
