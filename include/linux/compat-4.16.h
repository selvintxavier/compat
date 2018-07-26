#ifndef LINUX_4_16_COMPAT_H
#define LINUX_4_16_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,16,0))

#ifndef HAVE_KOBJ_NS_DROP_EXPORTED
#include <linux/kobject_ns.h>

#define kobj_ns_drop LINUX_BACKPORT(kobj_ns_drop)
void kobj_ns_drop(enum kobj_ns_type type, void *ns);

#define kobj_ns_grab_current LINUX_BACKPORT(kobj_ns_grab_current)
void *kobj_ns_grab_current(enum kobj_ns_type type);
#endif

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(4,16,0)) */

#endif /* LINUX_4_16_COMPAT_H */
