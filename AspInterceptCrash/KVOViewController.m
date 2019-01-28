//
//  KVOViewController.m
//  AspInterceptCrash
//
//  Created by liguohui on 2019/1/28.
//  Copyright © 2019年 liguohui. All rights reserved.
//

#import "KVOViewController.h"
#import "CommonObject.h"
#import "SolveCrashHelp.h"

@interface KVOViewController ()
@property (nonatomic, strong) NSMutableDictionary *kvoDict;
@end

@implementation KVOViewController
static void *kCloudServiceBackupCellContactQuantityStringContext = &kCloudServiceBackupCellContactQuantityStringContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self ADDKVO:nil];
}

- (void)ADDKVO:(id)sender {
    [self addObserver:self forKeyPath:@"testcount" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"context:%p",kCloudServiceBackupCellContactQuantityStringContext);
    [[CommonObject shareIntance] addObserver:self forKeyPath:@"testNum" options:0 context:kCloudServiceBackupCellContactQuantityStringContext];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(test)
                                                 name:@"testcount"
                                               object:nil];
}

- (void)dealloc {
    NSLog(@"dD");
    [self removeObserver:self forKeyPath:@"testcount"];
    //    [[CommonObject shareIntance] removeObserver:self forKeyPath:@"testNum" context:nil];//如果带context不对应会闪退
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)DELKVO:(id)sender {
    [self removeObserver:self forKeyPath:@"testcount"];
}

- (void)ChangeValue:(id)sender {
    
    self.testcount += 1;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSLog(@"%ld",(long)self.testcount);
    
}

- (void)test {
    NSLog(@"testcount");
}

@end
