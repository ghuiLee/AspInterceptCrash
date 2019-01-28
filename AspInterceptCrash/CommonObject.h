//
//  CommonObject.h
//  SolveCrashSDKTest
//
//  Created by liguohui on 2019/1/24.
//  Copyright © 2019年 Appfactory. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonObject : NSObject
@property (nonatomic, assign) NSInteger testNum;
+ (instancetype)shareIntance;
@end

NS_ASSUME_NONNULL_END
