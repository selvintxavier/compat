#ifndef LINUX_3_12_COMPAT_H
#define LINUX_3_12_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0))

#ifndef PTR_ERR_OR_ZERO
#define PTR_ERR_OR_ZERO(p) PTR_RET(p)
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)) */

#endif /* LINUX_3_12_COMPAT_H */
