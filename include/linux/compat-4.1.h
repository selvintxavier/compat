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

#define cpumask_local_spread LINUX_BACKPORT(cpumask_local_spread)

#if NR_CPUS == 1
static inline unsigned int cpumask_local_spread(unsigned int i, int node)
{
	return 0;
}
#else
unsigned int cpumask_local_spread(unsigned int i, int node);
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)) */

#endif /* LINUX_4_1_COMPAT_H */
