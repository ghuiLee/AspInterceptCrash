//
//  NSObject+forward.m
//  muticallDemo
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "NSObject+forward.h"
#import <objc/runtime.h>
#import "SolveCrashHelp.h"
#import "ShieldStubObject.h"
#import "AspReason.h"

@implementation NSObject (forward)

+ (void)asp_startSafeExtension{
    //KVO的重写
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(addObserver:forKeyPath:options:context:) replaceMethodSel:@selector(asp_addObserver:forKeyPath:options:context:)];
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(removeObserver:forKeyPath:) replaceMethodSel:@selector(asp_removeObserver:forKeyPath: context:)];
    
    //交换方法签名，用于解决doesNotRecognizeSelector的崩溃
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(forwardingTargetForSelector:) replaceMethodSel:@selector(asp_forwardingTargetForSelector:)];

    [SolveCrashHelp exchangeClassMethod:self originMethodSel:@selector(forwardingTargetForSelector:) replaceMethodSel:@selector(asp_forwardingTargetForSelector:)];
    
}

- (id)asp_forwardingTargetForSelector:(SEL)aSelector {
    BOOL aBool = [self respondsToSelector:aSelector];
    NSMethodSignature *signatrue = [self methodSignatureForSelector:aSelector];
    
    if (aBool || signatrue) {
        return self;
    }
    ShieldStubObject *stub = [ShieldStubObject shareInstance];
    [stub addObjFunc:aSelector];
    
    [AspReason asp_catchReason:[NSString stringWithFormat:@"error: target: %@ method: %@ not find",[self class],NSStringFromSelector(aSelector)] errorType:AspCatchType_class];
    return stub;
}

+ (id)asp_forwardingTargetForSelector:(SEL)aSelector {
    BOOL aBool = [self respondsToSelector:aSelector];
    NSMethodSignature *signatrue = [self methodSignatureForSelector:aSelector];
    
    if (aBool || signatrue) {
        return self;
    }
    [ShieldStubObject addClassFunc:aSelector];
    
    [AspReason asp_catchReason:[NSString stringWithFormat:@"error: target: %@ method: %@ not find",[self class],NSStringFromSelector(aSelector)] errorType:AspCatchType_class];
    
    return [ShieldStubObject class];
}

// MARK: kvo
static char *s_mutableKVOObservings = "s_mutableKVOObservings";//为被观察对象observered添加字典
static char *n_mutableKVOObservings = "n_mutableKVOObservings";//为观察对象observer添加字典
- (NSMutableDictionary *)mutableKVOObservings {
    NSMutableDictionary *dic = (NSMutableDictionary *)objc_getAssociatedObject(self, s_mutableKVOObservings);
    if (dic == nil) {
        objc_setAssociatedObject(self, s_mutableKVOObservings, [NSMutableDictionary new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

- (NSString *)identifierWithSelector:(id)object observer:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    return [NSString stringWithFormat:@"KeyValueSelectorOberving-%@:%@:object.%@",
            NSStringFromClass([object class]),
            NSStringFromClass([observer class]),
            keyPath];

}

- (BOOL)asp_isObserverExist:(NSObject *)observer observered:(NSObject *)observered forKeyPath:(NSString *)keyPath {
    NSString *identifier = [self identifierWithSelector:observered observer:observer forKeyPath:keyPath];
    NSMutableDictionary *kvoDict = objc_getAssociatedObject(observer,n_mutableKVOObservings);
    if(!kvoDict){
        kvoDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(observer, n_mutableKVOObservings, kvoDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSArray *array = [kvoDict allKeys];
    
    return [array containsObject:identifier];
}

- (void)lr_addObserver:(NSObject *)observer observered:(NSObject *)observered forKeyPath:(NSString *)keyPath context:(void *)context{
    if (observer && observered && keyPath) {
        NSString * identifier = [self identifierWithSelector:observered observer:observer forKeyPath:keyPath];
        
        @synchronized(self)
        {
            // 避免强引用
            NSPointerArray *pointerOber = [NSPointerArray weakObjectsPointerArray];
            [pointerOber addPointer:(__bridge void *)observer];
            NSPointerArray *pointerObered = [NSPointerArray weakObjectsPointerArray];
            [pointerObered addPointer:(__bridge void *)observered];
            NSDictionary *dic = @{@"observer":pointerOber,@"pointerObered":pointerObered,@"keyPath":keyPath};
            NSMutableDictionary *kvoDict = objc_getAssociatedObject(observer,n_mutableKVOObservings);
            [kvoDict setObject:dic forKey:identifier];
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [SolveCrashHelp exchangeInstanceMethod:[observer class] originMethodSel:NSSelectorFromString(@"dealloc") replaceMethodSel:@selector(asp_dealloc)];
            });
        }
    }
}

- (void)lr_removeObserver:(NSObject *)observer observered:(NSObject *)observered forKeyPath:(NSString *)keyPath context:(void *)context{
    if (observer && observered && keyPath) {
        NSString *identifier = [self identifierWithSelector:observered observer:observer forKeyPath:keyPath];
        NSMutableDictionary *kvoDict = objc_getAssociatedObject(observer,n_mutableKVOObservings);
        NSArray *array = [kvoDict allKeys];
        if ([array containsObject:identifier]) {
            @synchronized(self)
            {
                [kvoDict removeObjectForKey:identifier];
            }
        }
    }
}


- (void)asp_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    
    if (observer && keyPath && ![self asp_isObserverExist:observer observered:self forKeyPath:keyPath]) {
        @try {
            [self lr_addObserver:observer observered:self forKeyPath:keyPath context:context];
            [self asp_addObserver:observer forKeyPath:keyPath options:options context:context];
        }@catch (NSException *exception) {
        }
    }
}

- (void)asp_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context{
    if (observer && keyPath && [self asp_isObserverExist:observer observered:self forKeyPath:keyPath]) {
        @try {
            [self lr_removeObserver:observer observered:self forKeyPath:keyPath context:context];
            [self asp_removeObserver:observer forKeyPath:keyPath context:context];
        }@catch (NSException *exception) {
        }
    }
}

- (void)asp_dealloc {
    NSMutableDictionary *kvoDict = objc_getAssociatedObject(self, n_mutableKVOObservings);
    if (kvoDict.count > 0) {
        NSDictionary *tempdic = [kvoDict copy];
        for (NSString *key in tempdic.allKeys) {
            NSDictionary *item = [kvoDict objectForKey:key];
            NSPointerArray *pointerOber = [item objectForKey:@"observer"];
            NSObject *observer = [pointerOber pointerAtIndex:0];
            NSPointerArray *pointerObered = [item objectForKey:@"pointerObered"];
            NSObject *observered = [pointerObered pointerAtIndex:0];
            NSString *keyPath = (NSString *)[item objectForKey:@"keyPath"];
            
            [(observered?:self) removeObserver:(observer?:self) forKeyPath:keyPath];
        }

    }
    [self asp_dealloc];
}

@end
