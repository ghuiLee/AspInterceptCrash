//
//  SolveCrashHelp.h
//  muticallDemo
//
//  Created by liguohui on 2018/11/26.
//  Copyright © 2018年 Appfactory. All rights reserved.
//

#import "SolveCrashHelp.h"
#import <objc/runtime.h>
#import <UIKit/UIDevice.h>
@implementation SolveCrashHelp

+ (void)exchangeInstanceMethod:(Class)anClass originMethodSel:(SEL)originSEL replaceMethodSel:(SEL)replaceSEL{
    Method origIndex = class_getInstanceMethod(anClass, originSEL);
    Method overrideIndex = class_getInstanceMethod(anClass, replaceSEL);
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 11.0f) {
        BOOL didAddMethod = class_addMethod(anClass, originSEL, method_getImplementation(overrideIndex), method_getTypeEncoding(overrideIndex));
        if (didAddMethod) {
            class_replaceMethod(anClass, replaceSEL, method_getImplementation(origIndex), method_getTypeEncoding(origIndex));
        } else {
            method_exchangeImplementations(origIndex, overrideIndex);
        }
        return;
    }
    
    if (!origIndex || !overrideIndex) {
        return;
    }
    method_exchangeImplementations(origIndex, overrideIndex);
}

+ (void)exchangeClassMethod:(Class)anClass originMethodSel:(SEL)originSEL replaceMethodSel:(SEL)replaceSEL
{
    Method origIndex = class_getClassMethod(anClass, originSEL);
    Method overrideIndex = class_getClassMethod(anClass, replaceSEL);
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 11.0f) {
        BOOL didAddMethod = class_addMethod(anClass, originSEL, method_getImplementation(overrideIndex), method_getTypeEncoding(overrideIndex));
        if (didAddMethod) {
            class_replaceMethod(anClass, replaceSEL, method_getImplementation(origIndex), method_getTypeEncoding(origIndex));
        } else {
            method_exchangeImplementations(origIndex, overrideIndex);
        }
        return;
    }
    
    if (!origIndex || !overrideIndex) {
        return;
    }
    method_exchangeImplementations(origIndex, overrideIndex);
}
@end
