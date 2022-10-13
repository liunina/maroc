#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const MCRURLSchemeGlobalKey = @"URLGlobalScheme";
static NSString *const MCRURLHostCallService = @"call.service.maroc";
static NSString *const MCRURLHostRegister = @"register.maroc";
static NSString *const MCRURLHostJumpViewController = @"jump.vc.maroc";
static NSString *const MCRURLSubPathSplitPattern = @".";
static NSString *const MCRURLQueryParamsKey = @"params";
static NSString *const MCRURLFragmentViewControlerEnterModePush = @"push";
static NSString *const MCRURLFragmentViewControlerEnterModeModal = @"modal";

typedef void(^MCRPathComponentCustomHandler)(Protocol *proto, _Nullable SEL selector, NSDictionary<NSString *, id> *params);

@interface MCRouter : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)globalRouter;
+ (instancetype)routerForScheme:(NSString *)scheme;

+ (void)unRegisterRouterForScheme:(NSString *)scheme;
+ (void)unRegisterAllRouters;

//handler is a custom module or service solve function
- (void)addPathComponent:(NSString *)pathComponentKey
                forClass:(Class)mClass;
- (void)addPathComponent:(NSString *)pathComponentKey
                forClass:(Class)mClass
                 handler:(nullable MCRPathComponentCustomHandler)handler;
- (void)removePathComponent:(NSString *)pathComponentKey;

//url - >  com.example.maroc://call.service.maroc/pathComponentKey.protocolName.selector/...?params={}(value url encode)
//url - >  com.example.maroc://register.maroc/pathComponentKey.protocolName/...?params={}(value url encode)
//url - >  com.example.maroc://jump.vc.maroc/pathComponentKey.protocolName.push(modal)/...?params={}(value url encode)#push
//params -> {pathComponentKey:{paramName:paramValue,...},...}
//when call service， paramName = @1,@2,...(order of paramValue)
+ (BOOL)canOpenURL:(NSURL *)URL;
+ (BOOL)openURL:(NSURL *)URL;
+ (BOOL)openURL:(NSURL *)URL
     withParams:(nullable NSDictionary<NSString *, NSDictionary<NSString *, id> *> *)params;
+ (BOOL)openURL:(NSURL *)URL
     withParams:(nullable NSDictionary<NSString *, NSDictionary<NSString *, id> *> *)params
        andThen:(nullable void(^)(NSString *pathComponentKey, id obj, id returnValue))then;

+ (id)safePerformAction:(SEL)action
              forTarget:(NSObject *)target
             withParams:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
