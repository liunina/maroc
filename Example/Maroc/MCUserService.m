//
//  MCUserService.m
//  Maroc_Example
//
//  Created by liu nian on 2022/10/11.
//  Copyright © 2022 liunina. All rights reserved.
//

#import "MCUserService.h"
#import <Maroc/Maroc.h>

@MarocService(MCUserServiceProtocol, MCUserService);

@interface MCUserService ()

@end

@implementation MCUserService

- (void)wantToGoWorld:(NSString *)world {
    NSLog(@"执行:wantToGoWorld");
}

@end
