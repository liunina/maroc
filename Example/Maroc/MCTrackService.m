//
//  MCTrackService.m
//  Maroc_Example
//
//  Created by liu nian on 2022/10/11.
//  Copyright © 2022 liunina. All rights reserved.
//

#import "MCTrackService.h"

@implementation MCTrackService

+ (BOOL)singleton {
    return YES;
}

- (BOOL)trackEvent:(nonnull NSString *)eventName {
    NSLog(@"执行:trackEvent:%@",eventName);
    
    return YES;
}

@end
