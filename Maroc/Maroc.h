#import <Foundation/Foundation.h>
#import "MCModuleProtocol.h"
#import "MCContext.h"
#import "MarocAppDelegate.h"
#import "MCModuleManager.h"
#import "MCServiceManager.h"
#import "MCRouter.h"

NS_ASSUME_NONNULL_BEGIN

#define MAROC(servicename) \
    [[Maroc shareInstance] createService:@protocol(servicename)];

@interface Maroc : NSObject
/// save application global context
@property (nonatomic, strong) MCContext *context;
/// 开启异常模式,如果为True则发生异常时崩溃
@property (nonatomic, assign) BOOL enableException;

/// 单例
+ (instancetype)shareInstance;

/// 动态注册模块
/// @param moduleClass 模块实现类
+ (void)registerDynamicModule:(Class) moduleClass;

/// 根据协议创建(调用)服务
/// @param proto 协议
- (id)createService:(Protocol *)proto;

/// 将服务和协议进行绑定注册,Registration is recommended to use a static way
/// @param proto 协议
/// @param serviceClass 服务
- (void)registerService:(Protocol *)proto service:(Class)serviceClass;

/// 出发自定义事件
/// @param eventType 事件类型
+ (void)triggerCustomEvent:(NSInteger)eventType;
    
@end

NS_ASSUME_NONNULL_END
