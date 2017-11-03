//
//  HYEncodeTool.m
//  Category
//
//  Created by wuhaiyang on 16/8/24.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "HYEncodeTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HYEncodeTool

#pragma mark - MD5
+ (NSString *)hy_md5Lowercase:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",    // 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - SHA
+ (NSString *)hy_sha224Lowercase:(NSString *)str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    CC_LONG len = (CC_LONG)data.length;
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(data.bytes, len, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+ (NSString *)hy_sha256Lowercase:(NSString *)str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    CC_LONG len = (CC_LONG)data.length;
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, len, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+ (NSString *)hy_sha384Lowercase:(NSString *)str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    CC_LONG len = (CC_LONG)data.length;
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(data.bytes, len, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+ (NSString *)hy_sha512Lowercase:(NSString *)str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    CC_LONG len = (CC_LONG)data.length;
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, len, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

#pragma mark - base64
+ (NSString *)hy_base64Encode:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)hy_base64Decode:(NSString *)str {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - URL
+ (NSString *)hy_urlEncode:(NSString *)str {
    NSMutableCharacterSet *set = [[NSMutableCharacterSet alloc] init];
    NSMutableCharacterSet *alphanumericSet = [NSMutableCharacterSet alphanumericCharacterSet]; //0-9a-zA-Z
    [set formUnionWithCharacterSet:alphanumericSet];
    NSMutableCharacterSet *specialSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"$-_.+!*'(),"];//!()*-._
    [set formUnionWithCharacterSet:specialSet];
    return [str stringByAddingPercentEncodingWithAllowedCharacters:set];
    /*
     AllowedCharacters这里面的字符集不会进行URL编码，其他的字符集会进行URL编码
     在URL中只有字母与数字，以及特殊字符“$-_.+!*'(),”和用作保留目的的保留字符可以不进行编码。
     */
}

+ (NSString *)hy_urlDecode:(NSString *)str{
   return [str stringByRemovingPercentEncoding];
}

@end
