//
//  MCAppDelegate.m
//  Maroc
//
//  Created by liunina on 10/11/2022.
//  Copyright (c) 2022 liunina. All rights reserved.
//

#import "MCAppDelegate.h"
#import "Consts.h"
#import "MCOrderService.h"

@implementation MCAppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MCContext shareInstance].application = application;
    [MCContext shareInstance].launchOptions = launchOptions;

    [self registerModulesByStatic];
    [self registerModulesByURLs];
    [Maroc shareInstance].enableException = YES;
    [[Maroc shareInstance] setContext:[MCContext shareInstance]];
    [[MCTimeProfiler sharedTimeProfiler] recordEventTime:@"Maroc::super start launch"];
    [self registerModulesByURLs];
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

/// 通过plist静态注册模块和服务
- (void)registerModulesByStatic {
    [MCContext shareInstance].moduleConfigName = @"HelloMaroc.bundle/HelloMaroc";//可选，默认为Maroc.bundle/Maroc.plist
    [MCContext shareInstance].serviceConfigName = @"HelloMaroc.bundle/HelloMarocService";
}
/// 通过URL注册模块和服务
- (void)registerModulesByURLs {
    MCRouter *router = [MCRouter routerForScheme:marocScheme];
    [router addPathComponent:orderPathComponentKey forClass:[MCOrderService class] handler:^(Protocol * _Nonnull protocol, SEL _Nullable selector, NSDictionary<NSString *,id> * _Nonnull params) {
        
        NSLog(@"path:%@ - protocol: %@ - method: %@ - params:%@", orderPathComponentKey, protocol, NSStringFromSelector(selector), params);
        if (selector) {
            
            MCOrderService *orderService = [MCOrderService new];
            id returnValue = [MCRouter safePerformAction:selector forTarget:orderService withParams:params];
            
        }
    }];
//        N
    NSString *urlOrderModuleReg = @"hellomacro://register.maroc/MCOrderModule.MCModuleProtocol";
    /// 注册模块
    BOOL result1 = [MCRouter openURL:[NSURL URLWithString:urlOrderModuleReg]];
    if (result1) {
        NSLog(@"订单模块URL注册成功");
    }else {
        NSLog(@"订单模块URL注册失败");
    }
    
    NSString *urlOrderServiceReg = @"hellomacro://register.maroc/order.MCOrderServiceProtocol";
    BOOL result2 = [MCRouter openURL:[NSURL URLWithString:urlOrderServiceReg]];
    if (result2) {
        NSLog(@"订单服务URL注册成功");
    }else {
        NSLog(@"订单服务URL注册失败");
    }
}

@end
