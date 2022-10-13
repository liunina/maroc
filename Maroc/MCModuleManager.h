#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MCModuleLevel) {
    MCModuleBasic = 0,
    MCModuleNormal = 1
};

typedef NS_ENUM(NSInteger, MCModuleEventType) {
    MCMSetupEvent = 0,
    MCMInitEvent,
    MCMTearDownEvent,
    MCMSplashEvent,
    MCMQuickActionEvent,
    MCMWillResignActiveEvent,
    MCMDidEnterBackgroundEvent,
    MCMWillEnterForegroundEvent,
    MCMDidBecomeActiveEvent,
    MCMWillTerminateEvent,
    MCMUnmountEvent,
    MCMOpenURLEvent,
    MCMDidReceiveMemoryWarningEvent,
    MCMDidFailToRegisterForRemoteNotificationsEvent,
    MCMDidRegisterForRemoteNotificationsEvent,
    MCMDidReceiveRemoteNotificationEvent,
    MCMDidReceiveLocalNotificationEvent,
    MCMWillPresentNotificationEvent,
    MCMDidReceiveNotificationResponseEvent,
    MCMWillContinueUserActivityEvent,
    MCMContinueUserActivityEvent,
    MCMDidFailToContinueUserActivityEvent,
    MCMDidUpdateUserActivityEvent,
    MCMHandleWatchKitExtensionRequestEvent,
    MCMDidCustomEvent = 1000
};

@class MCModule;

@interface MCModuleManager : NSObject

+ (instancetype)sharedManager;

// If you do not comply with set Level protocol, the default Normal
- (void)registerDynamicModule:(Class)moduleClass;

- (void)registerDynamicModule:(Class)moduleClass
       shouldTriggerInitEvent:(BOOL)shouldTriggerInitEvent;

- (void)unRegisterDynamicModule:(Class)moduleClass;

- (void)loadLocalModules;

- (void)registedAllModules;

- (void)registerCustomEvent:(NSInteger)eventType
         withModuleInstance:(id)moduleInstance
             andSelectorStr:(NSString *)selectorStr;

- (void)triggerEvent:(NSInteger)eventType;

- (void)triggerEvent:(NSInteger)eventType
     withCustomParam:(NSDictionary *)customParam;

@end
