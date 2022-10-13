#import "MCCommon.h"
#import "MCWatchDog.h"
#import <UIKit/UIKit.h>

typedef void (^MCWatchDogHandler)(void);
typedef void (^MCWatchDogFiredCallBack)(void);

@interface MCPingThread : NSThread
@property (nonatomic, assign) double threshold;
@property (nonatomic, assign) BOOL pingTaskIsRunning;
@property (nonatomic, copy) MCWatchDogHandler handler;
@end

@implementation MCPingThread
- (instancetype)initWithThreshold:(double)threshold handler:(MCWatchDogHandler)handler {
    if (self = [super init]) {
        self.pingTaskIsRunning = NO;
        self.threshold = threshold;
        self.handler = handler;
    }

    return self;
}

- (void)main {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    while (!self.cancelled) {
        self.pingTaskIsRunning = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pingTaskIsRunning = NO;
            dispatch_semaphore_signal(semaphore);
        });

        [NSThread sleepForTimeInterval:self.threshold];
        if (self.pingTaskIsRunning) {
            self.handler();
        }

        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
}

@end

@interface MCWatchDog ()
@property (nonatomic, assign) double threshold;
@property (nonatomic, strong) MCPingThread *pingThread;
@end

@implementation MCWatchDog
- (instancetype)initWithThreshold:(double)threshold strictMode:(BOOL)strictMode {
    self = [self initWIthThreshold:threshold
                          callBack:^() {
                              NSString *message = [NSString stringWithFormat:@"👮 Main thread was blocked 👮"];
                              if (strictMode) {
                                  //避免后台切换导致进入断言
                                  NSAssert([UIApplication sharedApplication].applicationState == UIApplicationStateBackground, message);
                              } else {
                                  MCLog(@"%@", message);
                              }
                          }];

    return self;
}

- (instancetype)initWIthThreshold:(double)threshold callBack:(MCWatchDogFiredCallBack)callBack {
    if (self = [self init]) {
        self.threshold = 0.4; //默认间隔
        self.threshold = threshold;
        self.pingThread = [[MCPingThread alloc] initWithThreshold:threshold handler:callBack];
        [self.pingThread start];
    }
    return self;
}

- (void)dealloc {
    [self.pingThread cancel];
}

@end
