#ifndef LINUX_3_10_COMPAT_H
#define LINUX_3_10_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0))

#include <linux/if_vlan.h>
#define __vlan_hwaccel_put_tag(a, b, c) __vlan_hwaccel_put_tag(a, c)

#include <linux/netdev_features.h>
#define NETIF_F_HW_VLAN_CTAG_RX NETIF_F_HW_VLAN_RX

#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */

#endif /* LINUX_3_10_COMPAT_H */
