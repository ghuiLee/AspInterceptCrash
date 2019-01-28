//
//  NSMutableAttributedString+AFCrashExtension.m
//  AspInterceptCrash
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "NSMutableAttributedString+AFCrashExtension.h"
#import "SolveCrashHelp.h"

@implementation NSMutableAttributedString (AFCrashExtension)
+ (void)asp_startSafeExtension{
    
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"NSConcreteMutableAttributedString") originMethodSel:@selector(initWithString:) replaceMethodSel:@selector(asp_initWithString:)];
    
}


- (instancetype)asp_initWithString:(NSString *)aString;{
    if (aString) {
        return [self asp_initWithString:aString];
    }else{
        return [self asp_initWithString:@""];
    }
}


@end
