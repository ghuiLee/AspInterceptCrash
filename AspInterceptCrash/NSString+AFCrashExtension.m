//
//  NSString+AFCrashExtension.m
//  AspInterceptCrash
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "NSString+AFCrashExtension.h"
#import "SolveCrashHelp.h"

@implementation NSString (AFCrashExtension)
+ (void)asp_startSafeExtension{
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"NSPlaceholderString") originMethodSel:@selector(initWithString:) replaceMethodSel:@selector(asp_initWithString:)];
    
    
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSCFConstantString") originMethodSel:@selector(substringFromIndex:) replaceMethodSel:@selector(asp_cons_substringFromIndex:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSCFConstantString") originMethodSel:@selector(substringToIndex:) replaceMethodSel:@selector(asp_cons_substringToIndex:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSCFConstantString") originMethodSel:@selector(substringWithRange:) replaceMethodSel:@selector(asp_cons_substringWithRange:)];
    
    
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"NSTaggedPointerString") originMethodSel:@selector(substringFromIndex:) replaceMethodSel:@selector(asp_tag_substringFromIndex:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"NSTaggedPointerString") originMethodSel:@selector(substringToIndex:) replaceMethodSel:@selector(asp_tag_substringToIndex:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"NSTaggedPointerString") originMethodSel:@selector(substringWithRange:) replaceMethodSel:@selector(asp_tag_substringWithRange:)];
    
    
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSCFString") originMethodSel:@selector(substringWithRange:) replaceMethodSel:@selector(asp_cf_substringWithRange:)];
}

- (instancetype)asp_initWithString:(NSString *)aString;{
    if (aString) {
        return [self asp_initWithString:aString];
    }else{
        return [self asp_initWithString:@""];
    }
}

- (NSString *)asp_cons_substringFromIndex:(NSUInteger)from{
    if (from <= self.length) {
        return [self asp_cons_substringFromIndex:from];
    }else{
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : from %@ out of count %@ of length ",
                            [self class], NSStringFromSelector(@selector(asp_cons_substringFromIndex:)), @(from), @(self.length)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_string];
        return self;
    }
}

- (NSString *)asp_tag_substringFromIndex:(NSUInteger)from{
    if (from <= self.length) {
        return [self asp_tag_substringFromIndex:from];
    }else{
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : from %@ out of count %@ of length ",
                            [self class], NSStringFromSelector(@selector(asp_tag_substringFromIndex:)), @(from), @(self.length)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_string];
        return self;
    }
}

- (NSString *)asp_cons_substringToIndex:(NSUInteger)to{
    if (to <= self.length) {
        return [self asp_cons_substringToIndex:to];
    }else{
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : to %@ out of count %@ of length ",
                            [self class], NSStringFromSelector(@selector(asp_cons_substringToIndex:)), @(to), @(self.length)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_string];
        return self;
    }
}

- (NSString *)asp_tag_substringToIndex:(NSUInteger)to{
    if (to <= self.length) {
        return [self asp_tag_substringToIndex:to];
    }else{
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : to %@ out of count %@ of length ",
                            [self class], NSStringFromSelector(@selector(asp_tag_substringToIndex:)), @(to), @(self.length)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_string];
        return self;
    }
}


- (NSString *)asp_cons_substringWithRange:(NSRange)range{
    if (range.length <= self.length && (range.location + range.length <= self.length)) {
        return [self asp_cons_substringWithRange:range];
    }else{
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : range %@ out of count %@ of length ",
                            [self class], NSStringFromSelector(@selector(asp_cons_substringWithRange:)), NSStringFromRange(range), @(self.length)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_string];
        return self;
    }
}

- (NSString *)asp_tag_substringWithRange:(NSRange)range{
    if (range.length <= self.length && (range.location + range.length <= self.length)) {
        return [self asp_tag_substringWithRange:range];
    }else{
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : range %@ out of count %@ of length ",
                            [self class], NSStringFromSelector(@selector(asp_tag_substringWithRange:)), NSStringFromRange(range), @(self.length)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_string];
        return self;
    }
}

- (NSString *)asp_cf_substringWithRange:(NSRange)range{
    if (range.length <= self.length && (range.location + range.length <= self.length)) {
        return [self asp_cf_substringWithRange:range];
    }else{
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : range %@ out of count %@ of length ",
                            [self class], NSStringFromSelector(@selector(asp_cf_substringWithRange:)), NSStringFromRange(range), @(self.length)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_string];
        return self;
    }
}

@end
