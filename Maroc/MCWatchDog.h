#import <Foundation/Foundation.h>

@interface MCWatchDog : NSObject

- (instancetype)initWithThreshold:(double)threshold strictMode:(BOOL)strictMode;

@end
