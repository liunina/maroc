#import "MCAnnotation.h"
#import <Foundation/Foundation.h>

@protocol MCServiceProtocol <NSObject>

@optional

/// 是否支持单例
+ (BOOL)singleton;

/// 若支持单例则可以调用该单例方法
+ (id)shareInstance;

@end
