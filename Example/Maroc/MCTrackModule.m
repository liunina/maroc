//
//  MCTrackModule.m
//  Maroc_Example
//
//  Created by liu nian on 2022/10/11.
//  Copyright © 2022 liunina. All rights reserved.
//

#import "MCTrackModule.h"
#import <Maroc/Maroc.h>
#import "MCTrackServiceProtocol.h"
#import "MCTrackService.h"


@interface MCTrackModule ()<MCModuleProtocol>
@end
@implementation MCTrackModule

/// 自定义静态注册
+ (void)load {
    [Maroc registerDynamicModule:[self class]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"MCTrackModule init");
    }
    return self;
}

- (void)modSetUp:(MCContext *)context {
    NSLog(@"MCTrackModule setup");
}

- (void)modInit:(MCContext *)context {
    [[Maroc shareInstance] registerService:@protocol(MCTrackServiceProtocol) service:[MCTrackService class]];

}

- (NSInteger)modulePriority {
    return 100;
}

@end
