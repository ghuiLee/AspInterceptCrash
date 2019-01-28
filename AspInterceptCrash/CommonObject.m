//
//  CommonObject.m
//  SolveCrashSDKTest
//
//  Created by liguohui on 2019/1/24.
//  Copyright © 2019年 Appfactory. All rights reserved.
//

#import "CommonObject.h"

@implementation CommonObject
+ (instancetype)shareIntance {
    static dispatch_once_t onceToken;
    static id _shareInstance = nil;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc]init];
    });
    return _shareInstance;
}
@end
