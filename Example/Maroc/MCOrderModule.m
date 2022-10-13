//
//  MCOrderModule.m
//  Maroc_Example
//
//  Created by liu nian on 2022/10/12.
//  Copyright © 2022 liunina. All rights reserved.
//

#import "MCOrderModule.h"
#import <Maroc/Maroc.h>

@interface MCOrderModule () <MCModuleProtocol>
@end

@implementation MCOrderModule

- (void)modSetUp:(MCContext *)context {
    NSLog(@"MCOrderModule setup");
}

- (void)modInit:(MCContext *)context {
}
@end
