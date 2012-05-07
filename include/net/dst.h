#ifndef _COMPAT_NET_DST_H
#define _COMPAT_NET_DST_H 1

#include <linux/version.h>

#if (LINUX_VERSION_CODE > KERNEL_VERSION(3, 0, 0))
#include_next <net/dst.h>
#else /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,0,0)) */
#include_next <net/dst.h>

static inline struct neighbour *dst_get_neighbour(struct dst_entry *dst)
{
	return dst->neighbour;
}

static inline void dst_set_neighbour(struct dst_entry *dst, struct neighbour *neigh)
{
	dst->neighbour = neigh;
}

static inline struct neighbour *dst_get_neighbour_raw(struct dst_entry *dst)
{
	return rcu_dereference_raw(dst->neighbour);
}
#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,0,0)) */

#endif	/* _COMPAT_NET_DST_H */
