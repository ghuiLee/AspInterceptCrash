//
//  ShieldStubObject.m
//  muticallDemo
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "ShieldStubObject.h"
#import <objc/runtime.h>

@implementation ShieldStubObject
+ (instancetype)shareInstance {
    static ShieldStubObject *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[ShieldStubObject alloc] init];
    });
    return obj;
}

- (BOOL)addObjFunc:(SEL)sel {
    return class_addMethod([self class], sel, (IMP)newFunc, "v@:@");
}
+ (BOOL)addClassFunc:(SEL)sel {
    return class_addMethod(objc_getMetaClass(class_getName([self class])), sel, (IMP)newFunc, "v@:@");
}
void newFunc(id self,SEL _cmd,...){
    NSLog(@"%@ newClass%@",self,NSStringFromSelector(_cmd));
}

@end
