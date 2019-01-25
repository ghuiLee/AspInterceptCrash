//
//  ViewController.m
//  AspInterceptCrash
//
//  Created by liguohui on 2019/1/25.
//  Copyright © 2019年 liguohui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextField *testField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 400, 50)];
    [self.view addSubview:testField];
    testField.backgroundColor = [UIColor yellowColor];
    
    //    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"1",@"002",@"3"]];
    ////    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    ////        if ([obj isEqualToString:@"002"]) {
    ////            [arr removeObject:@"002"];
    ////        }
    ////        NSLog(@"%@",obj);
    ////    }];
    //    for (int i = 0; i<arr.count; i++) {
    //        if ([arr[i] isEqualToString:@"002"]) {
    //            [arr addObject:@"004"];
    //        }
    //    }
    //    for (NSString *str in arr) {
    //        if ([str isEqualToString:@"002"]) {
    //            [arr addObject:@"004"];// 不加break会崩溃
    //            //*** Terminating app due to uncaught exception 'NSGenericException', reason: '*** Collection <__NSArrayM: 0x600000255f00> was mutated while being enumerated.'
    ////            [arr removeObjectsInRange:NSMakeRange(1, 1)];
    ////            break;
    //        }
    //        NSLog(@"%@",str);
    //    }
    //
    //    return;
    
    //    --- @[nil];
    //    [SubThreadViewController test];
    return;
    //    1、类型错误
    id d = [NSDate date];
    [d boolValue];
    return;
    //        2、数组下标越界
    //        NSArray *a = @[@1,@2];
    NSMutableArray *a = [NSMutableArray arrayWithObjects:@1,@2, nil];
    NSLog(@"%@",[a objectAtIndex:2]);
    NSLog(@"%@",a[2]); // 不支持
    [a removeObjectsInRange:NSMakeRange(1, 2)]; // 不支持
    [a addObject:nil];
    [a replaceObjectAtIndex:2 withObject:nil];
    [a insertObject:@"d" atIndex:5];
    NSArray *arr1 = [[NSArray alloc] init];
    NSLog(@"%@",[arr1 objectAtIndex:2]);
    NSLog(@"%@",arr1[2]);
    NSArray *arr2 = [[NSArray alloc] initWithObjects:@1, nil];
    NSLog(@"%@",[arr2 objectAtIndex:2]);
    NSLog(@"%@",arr2[2]);
    
    
    //        3、字典
    NSDictionary *dict = @{@"key0":@"value0",@"key1":@"value1"};
    NSLog(@"%@",[dict objectForKey:@"sdsd"]);
    id cObjects[2];
    id cKeys[2];
    cObjects[0] = @1;
    cKeys[0] = @"1";
    [NSDictionary dictionaryWithObjects:cObjects forKeys:cKeys count:1];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:nil forKey:nil];
    
    //    4、字符串
    NSString *str = @"123456";
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"123456"];
    [str substringWithRange:NSMakeRange(7, 3)];
    [str1 substringWithRange:NSMakeRange(7, 3)];
    
    //  5、plist保存
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@"sd" forKey:@"d"];
    [def setObject:[NSNull null] forKey:@"d"];
    [def setObject:@{@"key":@"value",[NSNull null]:@"d"} forKey:@"sd"];
    [def setObject:@[@"sds",[NSNull null]] forKey:@"sd"];
}


@end
