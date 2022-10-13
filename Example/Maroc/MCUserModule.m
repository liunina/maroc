//
//  MCUserModule.m
//  Maroc_Example
//
//  Created by liu nian on 2022/10/11.
//  Copyright © 2022 liunina. All rights reserved.
//

#import "Consts.h"
#import "MCUserModule.h"
#import "MCUserService.h"
#import "NSString+encode.h"
#import <Maroc/MCCommon.h>
#import <Maroc/Maroc.h>

@interface MCUserModule () <MCModuleProtocol>
@end

@MarocMod(MCUserModule)

    @implementation MCUserModule
//MC_EXPORT_MODULE(NO

- (void)modSetUp:(MCContext *)context {
    MCLog(@"MCUserModule setup");
}

- (void)modInit:(MCContext *)context {
    switch (context.env) {
        case MCEnvironmentDev:
            //....初始化开发环境
            break;
        case MCEnvironmentProd:
            //....初始化生产环境
        default:
            break;
    }

    //    MCRouter *router = [MCRouter routerForScheme:marocScheme];
    //    [router addPathComponent:userPathComponentKey forClass:[MCUserService class] handler:^(NSDictionary<NSString *,id> *params) {
    //
    //    }];
}

- (void)basicModuleLevel {
}

@end
