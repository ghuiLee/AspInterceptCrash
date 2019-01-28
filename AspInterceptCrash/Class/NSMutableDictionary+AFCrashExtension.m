//
//  NSMutableDictionary+AFCrashExtension.m
//  AspInterceptCrash
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "NSMutableDictionary+AFCrashExtension.h"
#import "SolveCrashHelp.h"

@implementation NSMutableDictionary (AFCrashExtension)

+ (void)asp_startSafeExtension{
    
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSDictionaryM") originMethodSel:@selector(setObject:forKey:) replaceMethodSel:@selector(asp_setObject:forKey:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSDictionaryM") originMethodSel:@selector(removeObjectForKey:) replaceMethodSel:@selector(asp_removeObjectForKey:)];
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSDictionaryM") originMethodSel:@selector(objectForKey:) replaceMethodSel:@selector(asp_objectForKey:)];
}

- (void)asp_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (!aKey)
    {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : key '%@' constructor appear nil ",
                            [self class], NSStringFromSelector(@selector(asp_setObject: forKey:)), aKey];
        [AspReason asp_catchReason:reason errorType:AspCatchType_dictionarym];
        return;
    }
    if (!anObject)
    {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : anObject constructor appear nil ",
                            [self class], NSStringFromSelector(@selector(asp_setObject: forKey:))];
        [AspReason asp_catchReason:reason errorType:AspCatchType_dictionarym];
        return;
    }
    [self asp_setObject:anObject forKey:aKey];
}

- (void)asp_removeObjectForKey:(id)aKey{
    if (aKey) {
        [self asp_removeObjectForKey:aKey];
    }else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : key '%@' constructor appear nil ",
                            [self class], NSStringFromSelector(@selector(asp_removeObjectForKey:)), aKey];
        [AspReason asp_catchReason:reason errorType:AspCatchType_dictionarym];
    }
}

- (id)asp_objectForKey:(id)aKey
{
    id obj = [self asp_objectForKey:aKey];
    
    if (obj && [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    else
    {
        return obj;
    }
    
    return obj;
}
@end
