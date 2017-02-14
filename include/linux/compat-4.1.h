#ifndef LINUX_4_1_COMPAT_H
#define LINUX_4_1_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0))
#include "../../compat/config.h"
#include <linux/dma-mapping.h>

#ifndef dma_rmb
#define dma_rmb()       rmb()
#endif

#ifndef dma_wmb
#define dma_wmb()       wmb()
#endif

#include <linux/cpumask.h>
#include <linux/if_vlan.h>

#define cpumask_local_spread LINUX_BACKPORT(cpumask_local_spread)

#if NR_CPUS == 1
static inline unsigned int cpumask_local_spread(unsigned int i, int node)
{
	return 0;
}
#else
unsigned int cpumask_local_spread(unsigned int i, int node);
#endif

#ifndef HAVE_SKB_VLAN_TAGGED
/*
 * skb_vlan_tagged - check if skb is vlan tagged.
 * @skb: skbuff to query
 *
 * Returns true if the skb is tagged, regardless of whether it is hardware
 * accelerated or not.
 */
static inline bool skb_vlan_tagged(const struct sk_buff *skb)
{
        if (!skb_vlan_tag_present(skb) &&
            likely(skb->protocol != htons(ETH_P_8021Q) &&
                   skb->protocol != htons(ETH_P_8021AD)))
                return false;

        return true;
}
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)) */

#endif /* LINUX_4_1_COMPAT_H */
