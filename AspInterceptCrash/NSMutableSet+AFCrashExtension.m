//
//  NSMutableSet+AFCrashExtension.m
//  AspInterceptCrash
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "NSMutableSet+AFCrashExtension.h"
#import "SolveCrashHelp.h"

@implementation NSMutableSet (AFCrashExtension)

+ (void)asp_startSafeExtension{
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSSetM") originMethodSel:@selector(addObject:) replaceMethodSel:@selector(asp_addObject:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSSetM") originMethodSel:@selector(removeObject:) replaceMethodSel:@selector(asp_removeObject:)];
}

- (void)asp_addObject:(id)anObject{
    if (anObject) {
        [self asp_addObject:anObject];
    }
}

- (void)asp_removeObject:(id)anObject{
    if (anObject) {
        [self asp_removeObject:anObject];
    }
}
@end
