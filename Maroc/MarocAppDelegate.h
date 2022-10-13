#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface MarocAppDelegate : UIResponder <UIApplicationDelegate>
@end

typedef void (^MCNotificationResultHandler)(UIBackgroundFetchResult);
typedef void (^MCNotificationPresentationOptionsHandler)(UNNotificationPresentationOptions options);
typedef void (^MCNotificationCompletionHandler)(void);

@interface MCNotificationsItem : NSObject
@property (nonatomic, strong) NSError *notificationsError;
@property (nonatomic, strong) NSData *deviceToken;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) UNNotification *notification;
@property (nonatomic, strong) UNNotificationResponse *notificationResponse;
@property (nonatomic, strong) UNUserNotificationCenter *center;
@property (nonatomic, copy) MCNotificationResultHandler notificationResultHander;
@property (nonatomic, copy) MCNotificationPresentationOptionsHandler notificationPresentationOptionsHandler;
@property (nonatomic, copy) MCNotificationCompletionHandler notificationCompletionHandler;
@end

@interface MCOpenURLItem : NSObject
@property (nonatomic, strong) NSURL *openURL;
@property (nonatomic, copy) NSString *sourceApplication;
@property (nonatomic, strong) id annotation;
@property (nonatomic, strong) NSDictionary *options;

@end

typedef void (^MCShortcutCompletionHandler)(BOOL);

@interface MCShortcutItem : NSObject
@property (nonatomic, strong) UIApplicationShortcutItem *shortcutItem;
@property (nonatomic, copy) MCShortcutCompletionHandler scompletionHandler;
@end

typedef void (^MCUserActivityRestorationHandler)(NSArray *);

@interface MCUserActivityItem : NSObject
@property (nonatomic, copy) NSString *userActivityType;
@property (nonatomic, strong) NSUserActivity *userActivity;
@property (nonatomic, strong) NSError *userActivityError;
@property (nonatomic, copy) MCUserActivityRestorationHandler restorationHandler;

@end

typedef void (^MCWatchReplyHandler)(NSDictionary *replyInfo);

@interface MCWatchItem : NSObject
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, copy) MCWatchReplyHandler replyHandler;

@end
