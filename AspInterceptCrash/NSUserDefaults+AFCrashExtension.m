//
//  NSUserDefaults+AFCrashExtension.m
//  CaiYun
//
//  Created by liguohui on 2018/12/18.
//

#import "NSUserDefaults+AFCrashExtension.h"
#import "SolveCrashHelp.h"
@implementation NSUserDefaults (AFCrashExtension)
+ (void)asp_startSafeExtension{
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(setObject:forKey:) replaceMethodSel:@selector(asp_safeSetObject:forKey:)];
}

- (void)asp_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (!aKey)
    {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : key '%@' constructor appear nil ",
                            [self class], NSStringFromSelector(@selector(asp_safeSetObject: forKey:)), aKey];
        [AspReason asp_catchReason:reason errorType:AspCatchType_userDefault];
        return;
    }
    if ([self checkWithObject:anObject]) {
        [self asp_safeSetObject:anObject forKey:aKey];
    }
}

- (BOOL)checkWithObject:(id)anObject {
    if (anObject && [anObject isKindOfClass:[NSNull class]])
    {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : anObject constructor appear <null> ",
                            [self class], NSStringFromSelector(@selector(asp_safeSetObject: forKey:))];
        [AspReason asp_catchReason:reason errorType:AspCatchType_userDefault];
        return NO;
    }
    __weak typeof(self) weakSelf = self;
    if (anObject && ([anObject isKindOfClass:[NSArray class]] || [anObject isKindOfClass:[NSMutableArray class]])) {
        NSArray *values = [anObject allObjects];
        __block BOOL isValue = YES;
        [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            isValue = [weakSelf checkWithObject:obj];
            if (!isValue) {
                *stop = YES;
            }
        }];
        return isValue;
    }
    if (anObject && ([anObject isKindOfClass:[NSDictionary class]] || [anObject isKindOfClass:[NSMutableDictionary class]])) {
        NSArray *keys = [anObject allKeys];
        __block BOOL isKey = YES;
        [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            isKey = [weakSelf checkWithObject:obj];
            if (!isKey) {
                *stop = YES;
            }
        }];
        
        NSArray *values = [anObject allObjects];
        __block BOOL isValue = YES;
        [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            isValue =  [weakSelf checkWithObject:obj];
            if (!isValue) {
                *stop = YES;
            }
        }];
        return isKey&&isValue;
    }
    return YES;
}
@end
