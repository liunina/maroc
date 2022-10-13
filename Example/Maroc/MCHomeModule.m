//
//  MCHomeModule.m
//  Maroc_Example
//
//  Created by liu nian on 2022/10/11.
//  Copyright © 2022 liunina. All rights reserved.
//

#import "MCHomeModule.h"
#import <Maroc/Maroc.h>

@interface MCHomeModule () <MCModuleProtocol>

@end

@implementation MCHomeModule

- (void)modSetUp:(MCContext *)context {
    NSLog(@"MCHomeModule setup");
}

- (void)modInit:(MCContext *)context {
}

@end
