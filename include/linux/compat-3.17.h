#ifndef LINUX_3_17_COMPAT_H
#define LINUX_3_17_COMPAT_H

#include <linux/version.h>
#include "../../compat/config.h"
#include <linux/dma-mapping.h>
#include <linux/pci.h>
#include <linux/device.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0))

#define pci_zalloc_consistent backport_pci_zalloc_consistent
static inline void *
backport_pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
                      dma_addr_t *dma_handle)
{
        return dma_zalloc_coherent(hwdev == NULL ? NULL : &hwdev->dev,
				size, dma_handle, GFP_ATOMIC);
}

#ifndef HAVE_KTIME_GET_REAL_NS
#include <linux/hrtimer.h>
#include <linux/ktime.h>
static inline u64 ktime_get_real_ns(void) {
	return ktime_to_ns(ktime_get_real());
}
#endif /* HAVE_KTIME_GET_REAL_NS */

#ifndef HAVE_KTIME_GET_BOOT_NS
#include <linux/hrtimer.h>
static inline u64 ktime_get_boot_ns(void)
{
	return ktime_to_ns(ktime_get_boottime());
}
#endif /* HAVE_KTIME_GET_BOOT_NS */

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)) */

#endif /* LINUX_3_17_COMPAT_H */
