#import "MCAnnotation.h"
#import "MCCommon.h"
#include <dlfcn.h>
#include <mach-o/dyld.h>
#include <mach-o/getsect.h>
#include <mach-o/ldsyms.h>
#include <mach-o/loader.h>
#import <objc/message.h>
#import <objc/runtime.h>

NSArray<NSString *> *MCReadConfiguration(char *sectionName, const struct mach_header *mhp);
static void dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide) {
    NSArray *mods = MCReadConfiguration(MarocModSectName, mhp);
    for (NSString *modName in mods) {
        Class cls;
        if (modName) {
            cls = NSClassFromString(modName);
            if (cls) {
                [[MCModuleManager sharedManager] registerDynamicModule:cls];
            }
        }
    }

    //register services
    NSArray<NSString *> *services = MCReadConfiguration(MarocServiceSectName, mhp);
    for (NSString *map in services) {
        NSData *jsonData = [map dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (!error) {
            if ([json isKindOfClass:[NSDictionary class]] && [json allKeys].count) {

                NSString *protocol = [json allKeys][0];
                NSString *clsName = [json allValues][0];

                if (protocol && clsName) {
                    [[MCServiceManager sharedManager] registerService:NSProtocolFromString(protocol) implClass:NSClassFromString(clsName)];
                }
            }
        }
    }
}

__attribute__((constructor)) void initProphet(void) {
    _dyld_register_func_for_add_image(dyld_callback);
}

NSArray<NSString *> *MCReadConfiguration(char *sectionName, const struct mach_header *mhp) {
    NSMutableArray *configs = [NSMutableArray array];
    unsigned long size = 0;
#ifndef __LP64__
    uintptr_t *memory = (uintptr_t *) getsectiondata(mhp, SEG_DATA, sectionName, &size);
#else
    const struct mach_header_64 *mhp64 = (const struct mach_header_64 *) mhp;
    uintptr_t *memory = (uintptr_t *) getsectiondata(mhp64, SEG_DATA, sectionName, &size);
#endif

    unsigned long counter = size / sizeof(void *);
    for (int idx = 0; idx < counter; ++idx) {
        char *string = (char *) memory[idx];
        NSString *str = [NSString stringWithUTF8String:string];
        if (!str) continue;

        MCLog(@"config = %@", str);
        if (str) [configs addObject:str];
    }
    return configs;
}

@implementation MCAnnotation
@end
