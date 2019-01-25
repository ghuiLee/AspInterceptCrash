//
//  ShieldStubObject.h
//  muticallDemo
//
//  Created by liguohui on 2018/9/5.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShieldStubObject : NSObject
+ (instancetype)shareInstance;
- (BOOL)addObjFunc:(SEL)sel;
+ (BOOL)addClassFunc:(SEL)sel;
@end
