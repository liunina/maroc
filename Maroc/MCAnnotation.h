#import "Maroc.h"
#import <Foundation/Foundation.h>

#ifndef MarocModSectName
#define MarocModSectName "MarocMods"
#endif

#ifndef MarocServiceSectName
#define MarocServiceSectName "MarocServices"
#endif

#define MarocDATA(sectname) __attribute((used, section("__DATA," #sectname " ")))

#define MarocMod(name) \
    class Maroc;       \
    char *k##name##_mod MarocDATA(MarocMods) = "" #name "";

#define MarocService(servicename, impl) \
    class Maroc;                        \
    char *k##servicename##_service MarocDATA(MarocServices) = "{ \"" #servicename "\" : \"" #impl "\"}";

@interface MCAnnotation : NSObject

@end
