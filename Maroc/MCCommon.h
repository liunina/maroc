
#ifndef MCCommon_h
#define MCCommon_h

// Debug Logging
#ifdef DEBUG
#define MCLog(x, ...) NSLog(x, ##__VA_ARGS__);
#else
#define MCLog(x, ...)
#endif

#endif /* MCCommon_h */
