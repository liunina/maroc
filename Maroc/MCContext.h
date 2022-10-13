
#import "MCConfig.h"
#import "MCServiceProtocol.h"
#import "MarocAppDelegate.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    MCEnvironmentDev = 0,
    MCEnvironmentTest,
    MCEnvironmentStage,
    MCEnvironmentProd
} MCEnvironmentType;

@interface MCContext : NSObject <NSCopying>

//global env
@property (nonatomic, assign) MCEnvironmentType env;

//global config
@property (nonatomic, strong, readonly) MCConfig *config;

//application appkey
@property (nonatomic, strong) NSString *appkey;
//customEvent>=1000
@property (nonatomic, assign) NSInteger customEvent;

@property (nonatomic, strong) UIApplication *application;

@property (nonatomic, strong) NSDictionary *launchOptions;

@property (nonatomic, strong) NSString *moduleConfigName;

@property (nonatomic, strong) NSString *serviceConfigName;

//3D-Touch model
@property (nonatomic, strong, readonly) MCShortcutItem *touchShortcutItem;

//OpenURL model
@property (nonatomic, strong, readonly) MCOpenURLItem *openURLItem;

//Notifications Remote or Local
@property (nonatomic, strong, readonly) MCNotificationsItem *notificationsItem;

//user Activity Model
@property (nonatomic, strong, readonly) MCUserActivityItem *userActivityItem;

//watch Model
@property (nonatomic, strong, readonly) MCWatchItem *watchItem;

//custom param
@property (nonatomic, copy) NSDictionary *customParam;

+ (instancetype)shareInstance;

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName;

- (void)removeServiceWithServiceName:(NSString *)serviceName;

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName;

@end

NS_ASSUME_NONNULL_END
