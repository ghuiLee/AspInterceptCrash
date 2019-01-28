//
//  AspInterceptCrash.h
//  AspInterceptCrash
//
//  Created by liguohui on 2018/11/26.
//  Copyright © 2018年 Appfactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AspInterceptCrash : NSObject
@property (nonatomic, assign) BOOL isReasonToast;

+ (AspInterceptCrash *)sharedInstance;

- (void)asp_startSafeExtension;

@end
