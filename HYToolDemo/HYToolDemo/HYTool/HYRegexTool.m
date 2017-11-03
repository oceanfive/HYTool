//
//  HYRegexTool.m
//  Category
//
//  Created by wuhaiyang on 16/8/25.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "HYRegexTool.h"
#if __has_include(<RegexKitLite/RegexKitLite.h>)
#import <RegexKitLite/RegexKitLite.h>
#else
#import "RegexKitLite.h"
#endif

NSString *const HYRegexCompoentKey = @"HYRegexCompoentKey";
NSString *const HYRegexRangeKey = @"HYRegexRangeKey";

@implementation HYRegexTool

+ (BOOL)hy_regexResultWithString:(NSString *)string type:(HYRegexType)type {
    BOOL result = NO;
    NSString *expression = [self hy_getRegexExpressionWithType:type];
    if (type == HYRegexTypeAccount ) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeBlankAtBeginAndEnd) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeBlankline) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeChinese) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeDate) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeEmailAddress) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeHTML) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeIDCard) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeIPAddress) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeLetter) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeLowercase) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeMobilephoneNumber) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeNumber) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeNumberOrLetter) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypePostalCodeOfChina) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeQQ) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeTelephoneNumber) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeTwentyEightDaysOfMonth) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeTwentyNineDaysOfMonth) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeThirtyDaysOfMonth) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeThirtyOneDaysOfMonth) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeTwelveMonthOfYear) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeYear) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeUppercase) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeURL) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypePassword) {
        result = [self hy_regexResultWithString:string expression:expression];;
    } else if (type == HYRegexTypeSMSCodeFour) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeSMSCodeSix) {
        result = [self hy_regexResultWithString:string expression:expression];
    } else if (type == HYRegexTypeSMSCode) {
        BOOL result1 = [self hy_regexResultWithString:string type:HYRegexTypeSMSCodeFour];
        BOOL result2 = [self hy_regexResultWithString:string type:HYRegexTypeSMSCodeSix];
        result = result1 | result2;
    } else if (type == HYRegexTypeNumberOrLetterOrChinese) {
        BOOL result1 = [self hy_regexResultWithString:string type:HYRegexTypeChinese];
        BOOL result2 = [self hy_regexResultWithString:string type:HYRegexTypeLetter];
        BOOL result3 = [self hy_regexResultWithString:string type:HYRegexTypeNumber];
        result = result1 | result2 | result3;
    }
    return result;
}

+ (BOOL)hy_regexResultWithString:(NSString *)string expression:(NSString *)expression {
   return [string isMatchedByRegex:expression];
}

+ (NSArray *)hy_regexResultComponentsWithString:(NSString *)string matchedByExpression:(NSString *)expression {
    NSMutableArray *arr = [NSMutableArray array];
    [string enumerateStringsMatchedByRegex:expression usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[NSString stringWithFormat:@"%@", *capturedStrings] forKey:HYRegexCompoentKey];
        [dict setValue:[NSValue valueWithRange:*capturedRanges] forKey:HYRegexRangeKey];
        [arr addObject:dict];
    }];
    return arr;
}

+ (NSArray *)hy_regexResultComponentsWithString:(NSString *)string separatedByExpression:(NSString *)expression {
    NSMutableArray *arr = [NSMutableArray array];
    [string enumerateStringsSeparatedByRegex:expression usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:*capturedStrings forKey:HYRegexCompoentKey];
        [dict setValue:[NSValue valueWithRange:*capturedRanges] forKey:HYRegexRangeKey];
        [arr addObject:dict];
    }];
    return arr;
}

/**
 获取相应类型的正则表达式
 
 @param type HYRegexType
 @return 正则表达式
 备注：
 以下类型的正则表达式为空：
 HYRegexTypeSMSCode
 HYRegexTypeNumberOrLetterOrChinese
 
 */
+ (NSString *)hy_getRegexExpressionWithType:(HYRegexType)type {
    NSMutableString *result = [NSMutableString string];
    if (type == HYRegexTypeAccount ) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$"];
    } else if (type == HYRegexTypeBlankAtBeginAndEnd) {
        result = [NSMutableString stringWithFormat:@"%@", @"^\\s*|\\s*$"];
    } else if (type == HYRegexTypeBlankline) {
        result = [NSMutableString stringWithFormat:@"%@", @"\n\\s*\r"];
    } else if (type == HYRegexTypeChinese) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[\u4e00-\u9fa5]{0,}$"];
    } else if (type == HYRegexTypeDate) {
        result = [NSMutableString stringWithFormat:@"%@", @"^((([0-9]{4})([年|\\-|\\.]))((0?[1-9]|1[0-2])([月|\\-|\\.]))(((0?[1-9])|((1|2)[0-9])|30|31)日?))$"];
    } else if (type == HYRegexTypeEmailAddress) {
        result = [NSMutableString stringWithFormat:@"%@", @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*$"];
    } else if (type == HYRegexTypeHTML) {
        result = [NSMutableString stringWithFormat:@"%@", @"^<(.*)>.*|<(.*) />$"];
    } else if (type == HYRegexTypeIDCard) {
        result = [NSMutableString stringWithFormat:@"%@", @"\\d{14}[[0-9],0-9xX]"];
    } else if (type == HYRegexTypeIPAddress) {
        result = [NSMutableString stringWithFormat:@"%@", @"^([0-9]{1,3}[\\.])([0-9]{1,3}[\\.])([0-9]{1,3}[\\.])([0-9]{1,3})$"];
    } else if (type == HYRegexTypeLetter) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[A-Za-z]+$"];
    } else if (type == HYRegexTypeLowercase) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[a-z]+$"];
    } else if (type == HYRegexTypeMobilephoneNumber) {
        result = [NSMutableString stringWithFormat:@"%@", @"^1[3|4|5|7|8][0-9]\\d{8}$"];
    } else if (type == HYRegexTypeNumber) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[0-9]+$"];
    } else if (type == HYRegexTypeNumberOrLetter) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[A-Za-z0-9]+$"];
    } else if (type == HYRegexTypePostalCodeOfChina) {
        result = [NSMutableString stringWithFormat:@"%@", @"[1-9]\\d{5}(?!\\d)"];
    } else if (type == HYRegexTypeQQ) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[1-9][0-9]{4,}$"];
    } else if (type == HYRegexTypeTelephoneNumber) {
        result = [NSMutableString stringWithFormat:@"%@", @"^(([0-9]{3,4}(-?))?([0-9]{7,8}))$"];
    } else if (type == HYRegexTypeTwentyEightDaysOfMonth) {
        result = [NSMutableString stringWithFormat:@"%@", @"^((0?[1-9])|(1[0-9])|(2[0-8]))$"];
    } else if (type == HYRegexTypeTwentyNineDaysOfMonth) {
        result = [NSMutableString stringWithFormat:@"%@", @"^((0?[1-9])|((1|2)[0-9]))$"];
    } else if (type == HYRegexTypeThirtyDaysOfMonth) {
        result = [NSMutableString stringWithFormat:@"%@", @"^((0?[1-9])|((1|2)[0-9])|30)$"];
    } else if (type == HYRegexTypeThirtyOneDaysOfMonth) {
        result = [NSMutableString stringWithFormat:@"%@", @"^((0?[1-9])|((1|2)[0-9])|30|31)$"];
    } else if (type == HYRegexTypeTwelveMonthOfYear) {
        result = [NSMutableString stringWithFormat:@"%@", @"^(0?[1-9]|1[0-2])$"];
    } else if (type == HYRegexTypeYear) {
        result = [NSMutableString stringWithFormat:@"%@", @"^([0-9]{4})$"];
    } else if (type == HYRegexTypeUppercase) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[A-Z]+$"];
    } else if (type == HYRegexTypeURL) {
        result = [NSMutableString stringWithFormat:@"%@", @"[a-zA-z]+://[^\\s]*"];
    } else if (type == HYRegexTypePassword) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[0-9a-zA-Z]{6,20}$"];
    } else if (type == HYRegexTypeSMSCodeFour) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[0-9]{4}$"];
    } else if (type == HYRegexTypeSMSCodeSix) {
        result = [NSMutableString stringWithFormat:@"%@", @"^[0-9]{6}$"];
    } else if (type == HYRegexTypeSMSCode) {
        result = [NSMutableString stringWithFormat:@"%@", @""];
    } else if (type == HYRegexTypeNumberOrLetterOrChinese) {
        result = [NSMutableString stringWithFormat:@"%@", @""];
    }
    return result;
}

/*
 1、isMatchedByRegex -- 正则匹配的结果；YES/NO；
 2、componentsMatchedByRegex -- 把符合正则匹配的结果存放到一个数组中；
 3、componentsSeparatedByRegex -- 把不符合正则匹配的结果存放到一个数组中；
 4、enumerateStringsMatchedByRegex:usingBlock: -- 等价于2，使用block形式；
 5、enumerateStringsSeparatedByRegex:usingBlock: -- 等价于3、使用block形式；
 */

@end
