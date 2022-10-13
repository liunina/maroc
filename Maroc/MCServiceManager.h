#import <Foundation/Foundation.h>

@class MCContext;

@interface MCServiceManager : NSObject

@property (nonatomic, assign) BOOL enableException;

+ (instancetype)sharedManager;

- (void)registerLocalServices;

- (void)registerService:(Protocol *)service implClass:(Class)implClass;

- (id)createService:(Protocol *)service;
- (id)createService:(Protocol *)service withServiceName:(NSString *)serviceName;
- (id)createService:(Protocol *)service withServiceName:(NSString *)serviceName shouldCache:(BOOL)shouldCache;

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName;
- (void)removeServiceWithServiceName:(NSString *)serviceName;

@end
