#ifndef LINUX_4_9_COMPAT_H
#define LINUX_4_9_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,9,0))

#include <linux/pci_regs.h>

#ifndef PCI_EXP_DEVCAP2_ATOMIC_COMP64
#define PCI_EXP_DEVCAP2_ATOMIC_COMP64		(1 << 8)
#endif

#ifndef PCI_EXP_DEVCAP2_ATOMIC_ROUTE
#define PCI_EXP_DEVCAP2_ATOMIC_ROUTE		(1 << 6)
#endif

#ifndef PCI_EXP_DEVCTL2_ATOMIC_REQ
#define PCI_EXP_DEVCTL2_ATOMIC_REQ		(1 << 6)
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(4,9,0)) */

#endif /* LINUX_4_9_COMPAT_H */
