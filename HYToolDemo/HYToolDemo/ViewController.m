//
//  ViewController.m
//  HYToolDemo
//
//  Created by ocean on 2017/10/30.
//  Copyright © 2017年 ocean. All rights reserved.
//

#import "ViewController.h"
#import "HYPathTool.h"
#import <HYNetwork.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", NSHomeDirectory());
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *filePath = [HYPathTool hy_getAPPSandboxPathWithType:HYAPPSandboxPathDocuments fileName:@"file.plist"];
    NSDictionary *dict = @{@"name": @"jack", @"age": @18};
    [dict writeToFile:filePath atomically:YES];
    
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@", result);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self testNetworkStatus];
//}
//
//- (void)testNetworkStatus {
//    [[HYNetworkReachabilityManager sharedManager] startMonitoring];
//
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//
//    NSMutableDictionary *bodyDict = [NSMutableDictionary dictionary];
//    [bodyDict setObject:@"E10ADC3949BA59ABBE56E057F20F883E" forKey:@"password"];
//    [bodyDict setObject:@"15221047750" forKey:@"userName"];
//
//    NSMutableDictionary *deviceDict = [NSMutableDictionary dictionary];
//    [deviceDict setObject:@"750x1334" forKey:@"resolution"];
//    [deviceDict setObject:@"100.00000" forKey:@"longitude"];
//    [deviceDict setObject:@"00:00:00:00:00:00" forKey:@"ipAddress"];
//    [deviceDict setObject:@"4B939B4F-3475-426C-B25F-F74C0FBDFB8A" forKey:@"deviceId"];
//    [deviceDict setObject:@"31.29941" forKey:@"latidute"];
//    [deviceDict setObject:@"iOS" forKey:@"systemType"];
//    [deviceDict setObject:@"11.1" forKey:@"systemVersion"];
//    [deviceDict setObject:@"" forKey:@"imei"];
//    [deviceDict setObject:@"WiFi" forKey:@"network"];
//    [deviceDict setObject:@"iPhone" forKey:@"model"];
//    [deviceDict setObject:@"" forKey:@"carrier"];
//    [deviceDict setObject:@"00:00:00:00:00:00" forKey:@"macAddress"];
//
//    [parameters setObject:bodyDict forKey:@"body"];
//    [parameters setObject:deviceDict forKey:@"device"];
//    [parameters setObject:@"" forKey:@"session"];
//    [parameters setObject:@"parent" forKey:@"appname"];
//    [parameters setObject:@"" forKey:@"userId"];
//    [parameters setObject:@"4.2.1" forKey:@"version"];
//
//    [[HYNetworkTool sharedNetworkTool] POSTURLString:@"http://120.24.186.118:48080/app-api/login/client/login.do" parameters:parameters success:^(NSDictionary * _Nullable responseObject) {
//        NSLog(@"成功:%@", responseObject);
//
//    } failure:^(NSError * _Nullable error) {
//        NSLog(@"失败:%@", error);
//
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
