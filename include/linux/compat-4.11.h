#ifndef LINUX_4_11_COMPAT_H
#define LINUX_4_11_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0))

#ifndef ETH_P_IBOE
#define ETH_P_IBOE     0x8915          /* Infiniband over Ethernet     */
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)) */

#endif /* LINUX_4_11_COMPAT_H */
