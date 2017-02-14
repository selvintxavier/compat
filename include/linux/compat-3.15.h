#ifndef LINUX_3_15_COMPAT_H
#define LINUX_3_15_COMPAT_H

#include <linux/version.h>
#include <linux/idr.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))

#define kvfree LINUX_BACKPORT(kvfree)
extern void kvfree(const void *addr);

#ifndef HAVE_IDR_IS_EMPTY
#define idr_is_empty LINUX_BACKPORT(idr_is_empty)
bool idr_is_empty(struct idr *idp);
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)) */

#endif /* LINUX_3_15_COMPAT_H */
