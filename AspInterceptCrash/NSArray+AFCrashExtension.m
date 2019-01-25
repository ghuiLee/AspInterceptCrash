//
//  NSArray+AFCrashExtension.m
//  AspInterceptCrash
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "NSArray+AFCrashExtension.h"
#import "SolveCrashHelp.h"

@implementation NSArray (AFCrashExtension)
+ (void)asp_startSafeExtension{
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArray0") originMethodSel:@selector(objectAtIndex:) replaceMethodSel:@selector(asp_objectAtIndex0:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayI") originMethodSel:@selector(objectAtIndex:) replaceMethodSel:@selector(asp_objectAtIndexI:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayI") originMethodSel:@selector(objectAtIndexedSubscript:) replaceMethodSel:@selector(asp_safeObjectAtIndexedSubscript:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSSingleObjectArrayI") originMethodSel:@selector(objectAtIndex:) replaceMethodSel:@selector(asp_safeObjectSingleAtIndexSignle:)];
    
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSPlaceholderArray") originMethodSel:@selector(initWithObjects:count:) replaceMethodSel:@selector(asp_initWithObjects:count:)];
}

- (_Nullable instancetype)asp_initWithObjects:(const id  _Nonnull __unsafe_unretained *_Nullable)objects count:(NSUInteger)cnt
{
    id instance = nil;
    
    @try {
        instance = [self asp_initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i]) {
                newObjects[index] = objects[i];
                index++;
            }
        }
        instance = [self asp_initWithObjects:newObjects count:index];
    }
    @finally {
        return instance;
    }
}

-(_Nullable id)asp_objectAtIndex0:(NSUInteger)index{
    NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                        [self class], NSStringFromSelector(@selector(asp_objectAtIndex0:)), @(index), @(self.count)];
    [AspReason asp_catchReason:reason errorType:AspCatchType_arrayi];
    return nil;
}

- (_Nullable id)asp_objectAtIndexI:(NSUInteger)index{
    
    id obj = nil;
    
    if (self.count > 0 && index < self.count) {
        obj = [self asp_objectAtIndexI:index];
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(asp_objectAtIndexI:)), @(index), @(self.count)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arrayi];
    }
    
    return obj;
}
- (_Nullable id)asp_safeObjectAtIndexedSubscript:(NSUInteger)index {
    if (self.count > index) {
        return [self asp_safeObjectAtIndexedSubscript:index];//交换用回系统的APDI
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(asp_safeObjectAtIndexedSubscript:)), @(index), @(self.count)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arrayi];
        return nil;
    }
}

- (_Nullable id)asp_safeObjectSingleAtIndexSignle:(NSUInteger)index{
    
    id obj = nil;
    
    if (self.count > 0 && index < self.count) {
        obj = [self asp_safeObjectSingleAtIndexSignle:index];
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(asp_safeObjectSingleAtIndexSignle:)), @(index), @(self.count)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arrayi];
    }
    
    return obj;
}

@end
