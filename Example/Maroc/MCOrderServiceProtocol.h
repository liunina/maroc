//
//  MCOrderServiceProtocol.h
//  Maroc_Example
//
//  Created by liu nian on 2022/10/12.
//  Copyright © 2022 liunina. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCOrderServiceProtocol <NSObject>

- (NSInteger)createOrderByProductName:(NSString *)productName;
@end

NS_ASSUME_NONNULL_END
