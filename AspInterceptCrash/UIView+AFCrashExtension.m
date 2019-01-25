//
//  UIView+AFCrashExtension.m
//  AspInterceptCrash
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "UIView+AFCrashExtension.h"
#import "SolveCrashHelp.h"

@implementation UIView(AFCrashExtension)

+ (void)asp_startSafeExtension{
    
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(init) replaceMethodSel:@selector(asp_init)];
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(initWithFrame:) replaceMethodSel:@selector(asp_initWithFrame:)];
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(addSubview:) replaceMethodSel:@selector(asp_addSubview:)];
}

- (instancetype)asp_init
{
    if ([NSThread isMainThread])
    {
        return [self asp_init];
    }
    else
    {
        __block UIView * temp = nil;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            temp = [self asp_init];
        });
        
        return temp;
    }
}

- (instancetype)asp_initWithFrame:(CGRect)frame
{
    if ([NSThread isMainThread])
    {
        return [self asp_initWithFrame:frame];
    }
    else
    {
        __block UIView * temp = nil;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            temp = [self asp_initWithFrame:frame];
        });
        
        return temp;
    }
}

- (void)asp_addSubview:(UIView *)view
{
    if ([NSThread isMainThread])
    {
        [self asp_addSubview:view];
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self asp_addSubview:view];
        });
    }
}

@end
