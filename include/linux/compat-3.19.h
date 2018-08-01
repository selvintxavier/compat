#ifndef LINUX_3_19_COMPAT_H
#define LINUX_3_19_COMPAT_H

#include <linux/version.h>
#include "../../compat/config.h"

#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0))

#ifndef writel_relaxed
#define writel_relaxed writel
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)) */

#endif /* LINUX_3_19_COMPAT_H */
