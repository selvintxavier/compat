#ifndef LINUX_4_5_COMPAT_H
#define LINUX_4_5_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0))

#include <linux/netdevice.h>

#ifndef NETIF_F_CSUM_MASK
#define NETIF_F_CSUM_MASK NETIF_F_ALL_CSUM
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)) */

#endif /* LINUX_4_5_COMPAT_H */
