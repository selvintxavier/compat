#ifndef LINUX_3_12_COMPAT_H
#define LINUX_3_12_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0))

#define PTR_ERR_OR_ZERO LINUX_BACKPORT(PTR_ERR_OR_ZERO)
static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
{
	if (IS_ERR(ptr))
		return PTR_ERR(ptr);
	else
		return 0;
}
#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0) */

#endif /* LINUX_3_12_COMPAT_H */
