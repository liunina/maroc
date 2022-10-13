#import <Foundation/Foundation.h>

@interface MCTimeProfiler : NSObject

#define kTimeProfilerResultNotificationName @"MCTimeProfilerResult"
#define kNotificationUserInfoKey            @"logArray"

+ (MCTimeProfiler *)sharedTimeProfiler;

- (instancetype)initTimeProfilerWithMainKey:(NSString *)mainKey;
- (void)recordEventTime:(NSString *)eventName;

- (void)printOutTimeProfileResult;
- (void)saveTimeProfileDataIntoFile:(NSString *)filePath;
- (void)postTimeProfileResultNotification;

@end
