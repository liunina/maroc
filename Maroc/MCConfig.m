#import "MCConfig.h"
#import "MCCommon.h"

@interface MCConfig()
@property(nonatomic, strong) NSMutableDictionary *config;
@end

@implementation MCConfig

static MCConfig *_MCConfigInstance;

+ (instancetype)shareInstance {
    static dispatch_once_t p;
    
    dispatch_once(&p, ^{
        _MCConfigInstance = [[[self class] alloc] init];
    });
    return _MCConfigInstance;
}


+ (NSString *)stringValue:(NSString *)key {
    if (![MCConfig shareInstance].config) {
        return nil;
    }
    
    return (NSString *)[[MCConfig shareInstance].config objectForKey:key];
}

+ (NSDictionary *)dictionaryValue:(NSString *)key {
    if (![MCConfig shareInstance].config) {
        return nil;
    }
    
    if (![[[MCConfig shareInstance].config objectForKey:key] isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return (NSDictionary *)[[MCConfig shareInstance].config objectForKey:key];
}

+ (NSArray *)arrayValue:(NSString *)key {
    if (![MCConfig shareInstance].config) {
        return nil;
    }
    
    if (![[[MCConfig shareInstance].config objectForKey:key] isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    return (NSArray *)[[MCConfig shareInstance].config objectForKey:key];
}

+ (NSInteger)integerValue:(NSString *)key
{
    if (![MCConfig shareInstance].config) {
        return 0;
    }
    
    return [[[MCConfig shareInstance].config objectForKey:key] integerValue];
}

+ (float)floatValue:(NSString *)key
{
    if (![MCConfig shareInstance].config) {
        return 0.0;
    }
    
    return [(NSNumber *)[[MCConfig shareInstance].config objectForKey:key] floatValue];
}

+ (BOOL)boolValue:(NSString *)key
{
    if (![MCConfig shareInstance].config) {
        return NO;
    }
    
    return [(NSNumber *)[[MCConfig shareInstance].config objectForKey:key] boolValue];
}


+ (id)get:(NSString *)key
{
    if (![MCConfig shareInstance].config) {
        @throw [NSException exceptionWithName:@"ConfigNotInitialize" reason:@"config not initialize" userInfo:nil];
        
        return nil;
    }
    
    id v = [[MCConfig shareInstance].config objectForKey:key];
    if (!v) {
        MCLog(@"InvaildKeyValue %@ is nil", key);
    }
    
    return v;
}

+ (BOOL)has:(NSString *)key
{
    if (![MCConfig shareInstance].config) {
        return NO;
    }
    
    if (![[MCConfig shareInstance].config objectForKey:key]) {
        return NO;
    }
    
    return YES;
}

+ (void)set:(NSString *)key value:(id)value
{
    if (![MCConfig shareInstance].config) {
        [MCConfig shareInstance].config = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    
    [[MCConfig shareInstance].config setObject:value forKey:key];
}


+ (void)set:(NSString *)key boolValue:(BOOL)value
{
    [self set:key value:[NSNumber numberWithBool:value]];
}

+ (void)set:(NSString *)key integerValue:(NSInteger)value
{
    [self set:key value:[NSNumber numberWithInteger:value]];
}


+ (void) add:(NSDictionary *)parameters
{
    if (![MCConfig shareInstance].config) {
        [MCConfig shareInstance].config = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    
    [[MCConfig shareInstance].config addEntriesFromDictionary:parameters];
}

+ (NSDictionary *) getAll
{
    return [MCConfig shareInstance].config;
}

+ (void)clear
{
    if ([MCConfig shareInstance].config) {
        [[MCConfig shareInstance].config removeAllObjects];
    }
}

@end
