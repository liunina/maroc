#import "MCContext.h"

@interface MCContext ()
@property (nonatomic, strong) NSMutableDictionary *modulesByName;
@property (nonatomic, strong) NSMutableDictionary *servicesByName;
@property (nonatomic, strong) MCConfig *config;
// 3D-Touch model
@property (nonatomic, strong) MCShortcutItem *touchShortcutItem;
// OpenURL model
@property (nonatomic, strong) MCOpenURLItem *openURLItem;
// Notifications Remote or Local
@property (nonatomic, strong) MCNotificationsItem *notificationsItem;
// user Activity Model
@property (nonatomic, strong) MCUserActivityItem *userActivityItem;
// watch Model
@property (nonatomic, strong) MCWatchItem *watchItem;
@end

@implementation MCContext
+ (instancetype)shareInstance {
    static dispatch_once_t p;
    static id MCInstance = nil;
    dispatch_once(&p, ^{
      MCInstance = [[[self class] alloc] init];
      if ([MCInstance isKindOfClass:[MCContext class]]) {
          ((MCContext *)MCInstance).config = [MCConfig shareInstance];
      }
    });
    return MCInstance;
}

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName {
    [[MCContext shareInstance].servicesByName setObject:implInstance forKey:serviceName];
}
- (void)removeServiceWithServiceName:(NSString *)serviceName {
    [[MCContext shareInstance].servicesByName removeObjectForKey:serviceName];
}
- (id)getServiceInstanceFromServiceName:(NSString *)serviceName {
    return [[MCContext shareInstance].servicesByName objectForKey:serviceName];
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.modulesByName = [[NSMutableDictionary alloc] initWithCapacity:1];
        self.servicesByName = [[NSMutableDictionary alloc] initWithCapacity:1];
        self.moduleConfigName = @"Maroc.bundle/Maroc";
        self.serviceConfigName = @"Maroc.bundle/Maroc";
        self.touchShortcutItem = [MCShortcutItem new];
        self.openURLItem = [MCOpenURLItem new];
        self.notificationsItem = [MCNotificationsItem new];
        self.userActivityItem = [MCUserActivityItem new];
    }
    return self;
}
- (instancetype)copyWithZone:(NSZone *)zone {
    MCContext *context = [[self.class allocWithZone:zone] init];
    context.env = self.env;
    context.config = self.config;
    context.appkey = self.appkey;
    context.customEvent = self.customEvent;
    context.application = self.application;
    context.launchOptions = self.launchOptions;
    context.moduleConfigName = self.moduleConfigName;
    context.serviceConfigName = self.serviceConfigName;
    context.touchShortcutItem = self.touchShortcutItem;
    context.openURLItem = self.openURLItem;
    context.notificationsItem = self.notificationsItem;
    context.userActivityItem = self.userActivityItem;
    context.customParam = self.customParam;
    return context;
}
@end
