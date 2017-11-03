//
//  HYRegexTool.h
//  Category
//
//  Created by wuhaiyang on 16/8/25.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  正则匹配工具，依赖RegexKitLite框架

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const HYRegexCompoentKey; //内容字符串的key值
extern NSString *const HYRegexRangeKey;   //内容范围的key值

typedef NS_ENUM(NSInteger, HYRegexType) {
    HYRegexTypeTelephoneNumber,            /*
                                            * 电话号码---- ^(\\d{3,4}|\\d{3,4}-)\\d{7,8}$   ^\\d{7,8}$
                                            * “XXXX-XXXXXXX”，“XXXX-XXXXXXXX”，“XXX-XXXXXXX”，“XXX-XXXXXXXX”
                                            * “XXXXXXX”，“XXXXXXXX”
                                            * ^(([0-9]{3,4}(-?))?([0-9]{7,8}))$
                                            */
    HYRegexTypeMobilephoneNumber,          /*
                                            * 手机号码---- ^1[3|4|5|7|8][0-9]\\d{8}$     ** 11位手机号码
                                            * 第一位为 1 ，第二位 为 3|4|5|7|8 ，第三位为 0-9 ， 剩余8位为0-9数字
                                            */
    HYRegexTypePassword,                   /*
                                            * 密码(6-20位数字或字母)---- ^[0-9a-zA-Z]{6,20}$
                                            * 可以根据具体限制位数进行调整
                                            */
    HYRegexTypeIDCard,                     /* 待优化！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
                                            * 身份证号码---- \\d{14}[[0-9],0-9xX]    15或18位
                                            * 地址码（6位） +  出生年月日（8位）+ 顺序码（3位）+ 校验码（1位）
                                            * 1、大陆的身份证为18位，老的身份证是15位。
                                            * 2、公民身份号码是特征组合码，由十七位数字本体码和一位数字校验码组成。排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
                                            * 3、地址码（身份证前六位）表示编码对象常住户口所在县(市、旗、区)的行政区划代码。
                                            * 4、生日期码（身份证第七位到第十四位）表示编码对象出生的年、月、日，其中年份用四位数字表示，年、月、日之间不用分隔符。
                                            * 5、顺序码（身份证第十五位到十七位）为同一地址码所标识的区域范围内，对同年、月、日出生的人员编定的顺序号。其中第十七位奇数分给男性，偶数分给女性。
                                            * 6、校验码（身份证最后一位）是根据前面十七位数字码，按照ISO 7064:1983.MOD 11-2校验码计算出来的检验码。取值有：1 0 X 9 8 7 6 5 4 3 2
                                            * 7、链接：https://zhidao.baidu.com/question/304064498.html
                                            * 8、小结：地址码：第一位和第二位不为0，即1-9，后面4位可以为0.即0-9；
                                                     出生日期：年份：1900年开始，第一位大于0，即1-9，第二位0-9，第三和第四位0-9，
                                                             月份：第一位0|1，第二为：第一位0，则1-9，第一位1，则0|1|2，  01-12
                                                             日期：第一位0|1|2|3， 第二位：第一位0，则1-9， 第一位1|2，则0-9， 第一位3，则0|1  01-31
                                                             还要考虑月份的天数！！1
                                            */
    HYRegexTypeEmailAddress,               /* 待处理！！！！！！！！！！！！！！！！！！！！！！！！！！！
                                            * email地址----^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*$
                                            */
    HYRegexTypeNumber,                     /*
                                            * 数字---- ^[0-9]+$
                                            */
    HYRegexTypeLetter,                     /*
                                            * 26个大、小写英文字母 ---- ^[A-Za-z]+$
                                            */
    HYRegexTypeChinese,                    /*
                                            * 汉字----    ^[\u4e00-\u9fa5]{0,}$
                                            */
    HYRegexTypeNumberOrLetter,             /*
                                            * 数字和26个大小写英文字母---- ^[A-Za-z0-9]+$
                                            */
    HYRegexTypeNumberOrLetterOrChinese,    /*
                                            * 中文，英文字母，数字；
                                            */
    HYRegexTypeUppercase,                  /*
                                            * 26个大写英文字母---- ^[A-Z]+$
                                            */
    HYRegexTypeLowercase,                  /*
                                            * 26个小写英文字母---- ^[a-z]+$
                                            */
    HYRegexTypeURL,                        /*
                                            * URL---- [a-zA-z]+://[^\s]*
                                            */
    HYRegexTypeYear,                       /*
                                            * 年份 ---- ^([0-9]{4})$   ，应该是没有公历0年的，需要排除，待优化！！！！
                                            */
    HYRegexTypeTwelveMonthOfYear,          /*
                                            * 1年12个月---- ^(0?[1-9]|1[0-2])$    01 和 1 等价
                                            */
    HYRegexTypeTwentyEightDaysOfMonth,     /*
                                            * 1个月28天 ---- ^((0?[1-9])|(1[0-9])|(2[0-8]))$
                                            */
    HYRegexTypeTwentyNineDaysOfMonth,      /*
                                            * 1个月29天 ---- ^((0?[1-9])|((1|2)[0-9]))$      ^((0?[1-9])|((1|2)[0-9]))$
                                            */
    HYRegexTypeThirtyDaysOfMonth,          /*
                                            * 1个月30天 ---- ^((0?[1-9])|((1|2)[0-9])|30)$
                                            */
    HYRegexTypeThirtyOneDaysOfMonth,       /*
                                            * 1个月31天 ---- ^((0?[1-9])|((1|2)[0-9])|30|31)$
                                            */
    HYRegexTypeDate,                       /*
                                            * 日期---- ^((([0-9]{4})([年|\\-|\\.]))((0?[1-9]|1[0-2])([月|\\-|\\.]))(((0?[1-9])|((1|2)[0-9])|30|31)日?))$    默认是31天，修改的话根据上面的进行修改！！
                                            */
    HYRegexTypeBlankline,                  /*
                                            * 空白行----\n\\s*\r
                                            */
    HYRegexTypeHTML,                       /* 待优化！！！！！！！！！！！
                                            * HTML----<(\S*?)[^>]*>.*?</>|<.*?/>    只能匹配部分  /<(.*)>.*|<(.*) />/
                                            */
    HYRegexTypeBlankAtBeginAndEnd,         //首尾空白----\\s*|\\s*$
    HYRegexTypeAccount,                    /*
                                            * 账号---- ^[a-zA-Z][a-zA-Z0-9_]{4,15}$
                                            * 字母开头，允许5-16字节，允许字母数字下划线
                                            */
    HYRegexTypeQQ,                         /*
                                            * 腾讯QQ---- ^[1-9][0-9]{4,}$
                                            * 至少5位，第一位不能为0
                                            */
    HYRegexTypePostalCodeOfChina,          /* 待处理！！！！！！！！
                                            * 中国邮政编码---- [1-9]\\d{5}(?!\d)
                                            */
    HYRegexTypeIPAddress,                  /*
                                            * IP地址---- ^([0-9]{1,3}[\\.])([0-9]{1,3}[\\.])([0-9]{1,3}[\\.])([0-9]{1,3})$  
                                            * 192.168.255.255
                                            */
    HYRegexTypeSMSCode,                    /*
                                            * 4位或6位数字的短信验证码 ---- ^[0-9]{4}|[0-9]{6}$
                                            */
    HYRegexTypeSMSCodeFour,                /*
                                            * 4位数字的短信验证码(4位数字)---- ^[0-9]{4}$
                                            */
    HYRegexTypeSMSCodeSix,                 /*
                                            * 6位数字的短信验证码(6位数字)---- ^[0-9]{6}$
                                            */
};

@interface HYRegexTool : NSObject

/**
 正则表达式匹配
 
 @param string 需要匹配的内容
 @param type 匹配的类型
 @return 匹配结果，YES/NO
 */
+ (BOOL)hy_regexResultWithString:(NSString *)string type:(HYRegexType)type;

/**
 正则表达式匹配
 
 @param string 需要匹配的内容
 @param expression 表达式
 @return 匹配结果，YES/NO
 */
+ (BOOL)hy_regexResultWithString:(NSString *)string expression:(NSString *)expression;

/**
 匹配"符合正则规则"的内容并存入数组

 @param string 需要匹配的内容
 @param expression 表达式
 @return 符合规则的数组
 备注：返回的数组中每个元素为字典，key值有HYRegexCompoentKey和HYRegexRangeKey；
 HYRegexCompoentKey :   字符串内容的key值
 HYRegexRangeKey    :   字符串范围的key值
 */
+ (NSArray *)hy_regexResultComponentsWithString:(NSString *)string matchedByExpression:(NSString *)expression;

/**
 匹配"不符合正则规则"的内容并存入数组
 备注：通过这个方法，以“符合匹配规则的内容”为分隔符，对字符串进行分割，把分割的内容存入数组中；
 
 @param string 需要匹配的内容
 @param expression 表达式
 @return 符合规则的数组
 备注：返回的数组中每个元素为字典，key值有HYRegexCompoentKey和HYRegexRangeKey；
 HYRegexCompoentKey :   字符串内容的key值
 HYRegexRangeKey    :   字符串范围的key值
 */
+ (NSArray *)hy_regexResultComponentsWithString:(NSString *)string separatedByExpression:(NSString *)expression;

@end

NS_ASSUME_NONNULL_END
