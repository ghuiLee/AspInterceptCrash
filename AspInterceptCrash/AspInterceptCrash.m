//
//  AspInterceptCrash.h
//  AspInterceptCrash
//
//  Created by liguohui on 2018/11/26.
//  Copyright © 2018年 Appfactory. All rights reserved.
//

#import "AspInterceptCrash.h"
#import "NSArray+AFCrashExtension.h"
#import "NSDictionary+AFCrashExtension.h"
#import "NSMutableArray+AFCrashExtension.h"
#import "NSMutableDictionary+AFCrashExtension.h"
#import "NSMutableSet+AFCrashExtension.h"
#import "NSMutableAttributedString+AFCrashExtension.h"
#import "NSObject+forward.h"
#import "NSString+AFCrashExtension.h"
#import "UIView+AFCrashExtension.h"
#import "NSUserDefaults+AFCrashExtension.h"

@implementation AspInterceptCrash

+ (AspInterceptCrash *)sharedInstance
{
    static AspInterceptCrash* b_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        b_instance = [[AspInterceptCrash alloc] init];
    });
    return b_instance;
}

- (void)asp_startSafeExtension
{
    [NSArray asp_startSafeExtension];
    [NSMutableArray asp_startSafeExtension];
    [NSDictionary asp_startSafeExtension];
    [NSMutableDictionary asp_startSafeExtension];
    [NSMutableSet asp_startSafeExtension];
    [NSMutableAttributedString asp_startSafeExtension];
    [NSObject asp_startSafeExtension];
    [NSString asp_startSafeExtension];
    [UIView asp_startSafeExtension];
    [NSUserDefaults asp_startSafeExtension];
}

- (void)setIsReasonToast:(BOOL)isReasonToast {
    _isReasonToast = isReasonToast;
}
@end
