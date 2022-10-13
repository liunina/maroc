//
//  MCTrackServiceProtocol.h
//  Maroc_Example
//
//  Created by liu nian on 2022/10/11.
//  Copyright © 2022 liunina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Maroc/MCServiceProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCTrackServiceProtocol <NSObject, MCServiceProtocol>

- (BOOL)trackEvent:(NSString *)eventName;
@end

NS_ASSUME_NONNULL_END
