//
//  NSMutableArray+AFCrashExtension.m
//  AspInterceptCrash
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "NSMutableArray+AFCrashExtension.h"
#import "SolveCrashHelp.h"

@implementation NSMutableArray (AFCrashExtension)

+ (void)asp_startSafeExtension{
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originMethodSel:@selector(objectAtIndex:) replaceMethodSel:@selector(asp_objectAtIndexM:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originMethodSel:@selector(objectAtIndexedSubscript:) replaceMethodSel:@selector(asp_safeObjectAtIndexedSubscript:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originMethodSel:@selector(addObject:) replaceMethodSel:@selector(asp_addObject:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originMethodSel:@selector(insertObject:atIndex:) replaceMethodSel:@selector(asp_insertObject:atIndex:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originMethodSel:@selector(removeObjectAtIndex:) replaceMethodSel:@selector(asp_removeObjectAtIndex:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originMethodSel:@selector(removeObjectsInRange:) replaceMethodSel:@selector(asp_safeRemoveObjectsInRange:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originMethodSel:@selector(replaceObjectAtIndex: withObject:) replaceMethodSel:@selector(asp_replaceObjectAtIndex: withObject:)];
}

- (id)asp_objectAtIndexM:(NSUInteger)index{
    
    id obj = nil;
    
    if (self.count > 0 && index < self.count) {
        obj = [self asp_objectAtIndexM:index];
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(asp_objectAtIndexM:)), @(index), @(self.count)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arraym];
    }
    
    return obj;
}

- (id)asp_safeObjectAtIndexedSubscript:(NSUInteger)index {
    if (self.count > index) {
        return [self asp_safeObjectAtIndexedSubscript:index];//交换用回系统的APDI
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(asp_safeObjectAtIndexedSubscript:)), @(index), @(self.count)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arrayi];
        return nil;
    }
}

- (void)asp_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (index > self.count)
    {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(asp_insertObject: atIndex:)), @(index), @(self.count)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arraym];
        return;
    }
    
    if (!anObject)
    {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : Array constructor appear nil ",
                            [self class], NSStringFromSelector(@selector(asp_insertObject: atIndex:))];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arraym];
        return;
    }
    [self asp_insertObject:anObject atIndex:index];

}

- (void)asp_addObject:(id)anObject{
    if (anObject) {
        [self asp_addObject:anObject];
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : Array constructor appear nil ",
                            [self class], NSStringFromSelector(@selector(asp_addObject:))];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arraym];
    }
}

- (void)asp_removeObjectAtIndex:(NSUInteger)index{
    if (self.count > index) {
        [self asp_removeObjectAtIndex:index];
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(asp_removeObjectAtIndex:)), @(index), @(self.count)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arraym];
    }
}

- (void)asp_safeRemoveObjectsInRange:(NSRange)range {
    if (self.count>range.location && (self.count-range.location) >= range.length) {
        [self asp_safeRemoveObjectsInRange:range];
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : range %@ extends beyond bounds %@ of array ",
                            [self class], NSStringFromSelector(@selector(asp_safeRemoveObjectsInRange:)), NSStringFromRange(range), @(self.count)];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arraym];
    }
}

- (void)asp_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (anObject && self.count > index) {
        [self asp_replaceObjectAtIndex:index withObject:anObject];
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : Array constructor appear nil ",
                            [self class], NSStringFromSelector(@selector(asp_replaceObjectAtIndex: withObject:))];
        [AspReason asp_catchReason:reason errorType:AspCatchType_arraym];
    }
}
@end
