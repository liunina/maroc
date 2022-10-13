#import "MCAnnotation.h"
#import <Foundation/Foundation.h>

@class MCContext;
@class Maroc;

#define MC_EXPORT_MODULE(isAsync)                                    \
    +(void) load {                                                   \
        [Maroc registerDynamicModule:[self class]];                  \
    }                                                                \
    -(BOOL) async {                                                  \
        return [[NSString stringWithUTF8String:#isAsync] boolValue]; \
    }

@protocol MCModuleProtocol <NSObject>

@optional

// 如果不去设置Level默认是Normal
// basicModuleLevel不去实现默认Normal
- (void)basicModuleLevel;
// 越大越优先
- (NSInteger)modulePriority;

- (BOOL)async;

- (void)modSetUp:(MCContext *)context;

- (void)modInit:(MCContext *)context;

- (void)modSplash:(MCContext *)context;

- (void)modQuickAction:(MCContext *)context;

- (void)modTearDown:(MCContext *)context;

- (void)modWillResignActive:(MCContext *)context;

- (void)modDidEnterBackground:(MCContext *)context;

- (void)modWillEnterForeground:(MCContext *)context;

- (void)modDidBecomeActive:(MCContext *)context;

- (void)modWillTerminate:(MCContext *)context;

- (void)modUnmount:(MCContext *)context;

- (void)modOpenURL:(MCContext *)context;

- (void)modDidReceiveMemoryWaring:(MCContext *)context;

- (void)modDidFailToRegisterForRemoteNotifications:(MCContext *)context;

- (void)modDidRegisterForRemoteNotifications:(MCContext *)context;

- (void)modDidReceiveRemoteNotification:(MCContext *)context;

- (void)modDidReceiveLocalNotification:(MCContext *)context;

- (void)modWillPresentNotification:(MCContext *)context;

- (void)modDidReceiveNotificationResponse:(MCContext *)context;

- (void)modWillContinueUserActivity:(MCContext *)context;

- (void)modContinueUserActivity:(MCContext *)context;

- (void)modDidFailToContinueUserActivity:(MCContext *)context;

- (void)modDidUpdateContinueUserActivity:(MCContext *)context;

- (void)modHandleWatchKitExtensionRequest:(MCContext *)context;

- (void)modDidCustomEvent:(MCContext *)context;
@end
