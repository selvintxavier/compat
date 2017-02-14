#ifndef LINUX_3_16_COMPAT_H
#define LINUX_3_16_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0))

#include <linux/cpumask.h>

#define cpumask_set_cpu_local_first LINUX_BACKPORT(cpumask_set_cpu_local_first)

#if NR_CPUS == 1
static inline int cpumask_set_cpu_local_first(int i, int numa_node, cpumask_t *dstp)
{
	set_bit(0, cpumask_bits(dstp));

	return 0;
}
#else
int cpumask_set_cpu_local_first(int i, int numa_node, cpumask_t *dstp);
#endif

#include <linux/ktime.h>

#ifndef smp_mb__after_atomic
#define smp_mb__after_atomic()	smp_mb()
#endif

#ifndef smp_mb__before_atomic
#define smp_mb__before_atomic()	smp_mb()
#endif

#define RPC_CWNDSHIFT		(8U)
#define RPC_CWNDSCALE		(1U << RPC_CWNDSHIFT)
#define RPC_INITCWND		RPC_CWNDSCALE
#define RPC_MAXCWND(xprt)	((xprt)->max_reqs << RPC_CWNDSHIFT)
#define RPCXPRT_CONGESTED(xprt) ((xprt)->cong >= (xprt)->cwnd)

#include <linux/netdev_features.h>

#ifndef NETIF_F_GSO_UDP_TUNNEL_CSUM
#define NETIF_F_GSO_UDP_TUNNEL_CSUM 0
#endif

#if !defined(HAVE___DEV_UC_SYNC) && !defined(HAVE___DEV_MC_SYNC)

#include <linux/netdevice.h>

#define __hw_addr_sync_dev LINUX_BACKPORT(__hw_addr_sync_dev)
int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
                       struct net_device *dev,
                       int (*sync)(struct net_device *, const unsigned char *),
                       int (*unsync)(struct net_device *,
                                     const unsigned char *));

/**
 *  __dev_uc_sync - Synchonize device's unicast list
 *  @dev:  device to sync
 *  @sync: function to call if address should be added
 *  @unsync: function to call if address should be removed
 *
 *  Add newly added addresses to the interface, and release
 *  addresses that have been deleted.
 */
#define __dev_uc_sync LINUX_BACKPORT(__dev_uc_sync)
static inline int __dev_uc_sync(struct net_device *dev,
                                int (*sync)(struct net_device *,
                                            const unsigned char *),
                                int (*unsync)(struct net_device *,
                                              const unsigned char *))
{
        return __hw_addr_sync_dev(&dev->uc, dev, sync, unsync);
}

/**
 *  __dev_mc_sync - Synchonize device's multicast list
 *  @dev:  device to sync
 *  @sync: function to call if address should be added
 *  @unsync: function to call if address should be removed
 *
 *  Add newly added addresses to the interface, and release
 *  addresses that have been deleted.
 */
#define __dev_mc_sync LINUX_BACKPORT(__dev_mc_sync)
static inline int __dev_mc_sync(struct net_device *dev,
                                int (*sync)(struct net_device *,
                                            const unsigned char *),
                                int (*unsync)(struct net_device *,
                                              const unsigned char *))
{
        return __hw_addr_sync_dev(&dev->mc, dev, sync, unsync);
}
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)) */

#endif /* LINUX_3_16_COMPAT_H */
