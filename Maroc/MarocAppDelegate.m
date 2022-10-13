
#import <UIKit/UIKit.h>

#import "MCModuleManager.h"
#import "MCTimeProfiler.h"
#import "Maroc.h"
#import "MarocAppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface MarocAppDelegate () <UNUserNotificationCenterDelegate>
@end

@implementation MarocAppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[MCModuleManager sharedManager] triggerEvent:MCMSetupEvent];
    [[MCModuleManager sharedManager] triggerEvent:MCMInitEvent];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[MCModuleManager sharedManager] triggerEvent:MCMSplashEvent];
    });
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;

#ifdef DEBUG
    [[MCTimeProfiler sharedTimeProfiler] saveTimeProfileDataIntoFile:@"MarocTimeProfiler"];
#endif

    return YES;
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    [[Maroc shareInstance].context.touchShortcutItem setShortcutItem:shortcutItem];
    [[Maroc shareInstance].context.touchShortcutItem setScompletionHandler:completionHandler];
    [[MCModuleManager sharedManager] triggerEvent:MCMQuickActionEvent];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[MCModuleManager sharedManager] triggerEvent:MCMWillResignActiveEvent];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[MCModuleManager sharedManager] triggerEvent:MCMDidEnterBackgroundEvent];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[MCModuleManager sharedManager] triggerEvent:MCMWillEnterForegroundEvent];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[MCModuleManager sharedManager] triggerEvent:MCMDidBecomeActiveEvent];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[MCModuleManager sharedManager] triggerEvent:MCMWillTerminateEvent];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    [[Maroc shareInstance].context.openURLItem setOpenURL:url];
    [[Maroc shareInstance].context.openURLItem setOptions:options];
    [[MCModuleManager sharedManager] triggerEvent:MCMOpenURLEvent];
    return YES;
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[MCModuleManager sharedManager] triggerEvent:MCMDidReceiveMemoryWarningEvent];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[Maroc shareInstance].context.notificationsItem setNotificationsError:error];
    [[MCModuleManager sharedManager] triggerEvent:MCMDidFailToRegisterForRemoteNotificationsEvent];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[Maroc shareInstance].context.notificationsItem setDeviceToken:deviceToken];
    [[MCModuleManager sharedManager] triggerEvent:MCMDidRegisterForRemoteNotificationsEvent];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[Maroc shareInstance].context.notificationsItem setUserInfo:userInfo];
    [[Maroc shareInstance].context.notificationsItem setNotificationResultHander:completionHandler];
    [[MCModuleManager sharedManager] triggerEvent:MCMDidReceiveRemoteNotificationEvent];
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    [[Maroc shareInstance].context.userActivityItem setUserActivity:userActivity];
    [[MCModuleManager sharedManager] triggerEvent:MCMDidUpdateUserActivityEvent];
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    [[Maroc shareInstance].context.userActivityItem setUserActivityType:userActivityType];
    [[Maroc shareInstance].context.userActivityItem setUserActivityError:error];
    [[MCModuleManager sharedManager] triggerEvent:MCMDidFailToContinueUserActivityEvent];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *__nullable restorableObjects))restorationHandler {
    [[Maroc shareInstance].context.userActivityItem setUserActivity:userActivity];
    [[Maroc shareInstance].context.userActivityItem setRestorationHandler:restorationHandler];
    [[MCModuleManager sharedManager] triggerEvent:MCMContinueUserActivityEvent];
    return YES;
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    [[Maroc shareInstance].context.userActivityItem setUserActivityType:userActivityType];
    [[MCModuleManager sharedManager] triggerEvent:MCMWillContinueUserActivityEvent];
    return YES;
}
- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void (^)(NSDictionary *__nullable replyInfo))reply {
    [Maroc shareInstance].context.watchItem.userInfo = userInfo;
    [Maroc shareInstance].context.watchItem.replyHandler = reply;
    [[MCModuleManager sharedManager] triggerEvent:MCMHandleWatchKitExtensionRequestEvent];
}

// MARK: - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    [[Maroc shareInstance].context.notificationsItem setNotification:notification];
    [[Maroc shareInstance].context.notificationsItem setNotificationPresentationOptionsHandler:completionHandler];
    [[Maroc shareInstance].context.notificationsItem setCenter:center];
    [[MCModuleManager sharedManager] triggerEvent:MCMWillPresentNotificationEvent];
};

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    [[Maroc shareInstance].context.notificationsItem setNotificationResponse:response];
    [[Maroc shareInstance].context.notificationsItem setNotificationCompletionHandler:completionHandler];
    [[Maroc shareInstance].context.notificationsItem setCenter:center];
    [[MCModuleManager sharedManager] triggerEvent:MCMDidReceiveNotificationResponseEvent];
};

@end

@implementation MCOpenURLItem

@end

@implementation MCShortcutItem

@end

@implementation MCUserActivityItem

@end

@implementation MCNotificationsItem

@end
