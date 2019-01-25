//
//  NSDictionary+AFCrashExtension.m
//  AspInterceptCrash
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "NSDictionary+AFCrashExtension.h"
#import "SolveCrashHelp.h"

@implementation NSDictionary (AFCrashExtension)

+ (void)asp_startSafeExtension{
    [SolveCrashHelp exchangeClassMethod:self originMethodSel:@selector(dictionaryWithObjects:forKeys:count:) replaceMethodSel:@selector(asp_dictionaryWithObjects:forKeys:count:)];
    
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSDictionaryI") originMethodSel:@selector(objectForKey:) replaceMethodSel:@selector(asp_objectForKey1:)];
    
    [SolveCrashHelp exchangeInstanceMethod:NSClassFromString(@"__NSSingleEntryDictionaryI") originMethodSel:@selector(objectForKey:) replaceMethodSel:@selector(asp_objectForKeySingle:)];
}

+ (instancetype)asp_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
{
    
    id instance = nil;
    
    @try {
        instance = [self asp_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {

        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }else {
                NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : Array constructor appear nil ",
                                    [self class], NSStringFromSelector(@selector(asp_dictionaryWithObjects: forKeys: count:))];
                [AspReason asp_catchReason:reason errorType:AspCatchType_dictionaryi];
            }
        }
        instance = [self asp_dictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

- (id)asp_objectForKey1:(id)aKey
{
    id obj = [self asp_objectForKey1:aKey];
    
    if (obj && [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    else
    {
        return obj;
    }
    
    return obj;
}

- (id)asp_objectForKeySingle:(id)aKey
{
    id obj = [self asp_objectForKeySingle:aKey];
    
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
