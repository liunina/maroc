#ifndef MCDefines_h
#define MCDefines_h

#if defined(__cplusplus)
#define MC_EXTERN extern "C" __attribute__((visibility("default")))
#else
#define MC_EXTERN extern __attribute__((visibility("default")))
#endif

#endif /* MCDefines_h */
