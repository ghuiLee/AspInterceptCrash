//
//  AspReason.h
//  muticallDemo
//
//  Created by liguohui on 2018/11/23.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, AspCatchType) {
    AspCatchType_class,
    AspCatchType_arrayi,
    AspCatchType_arraym,
    AspCatchType_dictionaryi,
    AspCatchType_dictionarym,
    AspCatchType_string,
    AspCatchType_kvo,
    AspCatchType_view,
    AspCatchType_userDefault,
};

@interface AspReason : NSObject
+ (void)asp_catchReason:(nullable NSString *)reason
              errorType:(AspCatchType)type;
@end

NS_ASSUME_NONNULL_END
