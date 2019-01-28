//
//  SolveCrashHelp.h
//  muticallDemo
//
//  Created by liguohui on 2018/11/26.
//  Copyright © 2018年 Appfactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AspReason.h"
@interface SolveCrashHelp : NSObject

+ (void)exchangeInstanceMethod:(Class)anClass originMethodSel:(SEL)originSEL replaceMethodSel:(SEL)replaceSEL;

+ (void)exchangeClassMethod:(Class)anClass originMethodSel:(SEL)originSEL replaceMethodSel:(SEL)replaceSEL;

@end
