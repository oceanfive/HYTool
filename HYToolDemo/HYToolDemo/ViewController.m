//
//  ViewController.m
//  HYToolDemo
//
//  Created by ocean on 2017/10/30.
//  Copyright © 2017年 ocean. All rights reserved.
//

#import "ViewController.h"
#import "HYPathTool.h"

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
