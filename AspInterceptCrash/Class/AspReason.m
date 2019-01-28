//
//  AspReason.m
//  muticallDemo
//
//  Created by liguohui on 2018/11/23.
//  Copyright © 2018年 liguohui. All rights reserved.
//

#import "AspReason.h"
#import <UIKit/UIKit.h>
#import "AspInterceptCrash.h"

@implementation AspReason

+ (void)asp_catchReason:(nullable NSString *)reason
            errorType:(AspCatchType)type {
    NSLog(@"----------------------------------------------------------------------------------------------------");
    NSLog(@"AspCatchType:%lu has catch a non-fatal error:  %@",(unsigned long)type, reason);

    if (![AspInterceptCrash sharedInstance].isReasonToast) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"此处异常请截图联系开发" message:reason delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        //    AppDelegate.showingAlert = alertView;
        [alertView show];
    });
}

@end
