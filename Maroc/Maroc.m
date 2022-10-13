#import "Maroc.h"

@implementation Maroc

#pragma mark - public

+ (instancetype)shareInstance {
    static dispatch_once_t p;
    static id MCInstance = nil;

    dispatch_once(&p, ^{
        MCInstance = [[self alloc] init];
    });

    return MCInstance;
}

+ (void)registerDynamicModule:(Class)moduleClass {
    [[MCModuleManager sharedManager] registerDynamicModule:moduleClass];
}

- (id)createService:(Protocol *)proto {
    return [[MCServiceManager sharedManager] createService:proto];
}

- (void)registerService:(Protocol *)proto service:(Class)serviceClass {
    [[MCServiceManager sharedManager] registerService:proto implClass:serviceClass];
}

+ (void)triggerCustomEvent:(NSInteger)eventType {
    if (eventType < 1000) {
        return;
    }

    [[MCModuleManager sharedManager] triggerEvent:eventType];
}

#pragma mark - Private

- (void)setContext:(MCContext *)context {
    _context = context;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadStaticServices];
        [self loadStaticModules];
    });
}

- (void)loadStaticModules {
    [[MCModuleManager sharedManager] loadLocalModules];
    [[MCModuleManager sharedManager] registedAllModules];
}

- (void)loadStaticServices {
    [MCServiceManager sharedManager].enableException = self.enableException;
    [[MCServiceManager sharedManager] registerLocalServices];
}

@end
