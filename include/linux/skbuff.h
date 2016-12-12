#ifndef _COMPAT_LINUX_SKBUFF_H
#define _COMPAT_LINUX_SKBUFF_H

#include <linux/version.h>
#include "../../compat/config.h"

#include_next <linux/skbuff.h>

#ifndef HAVE_DEV_ALLOC_PAGES
static inline struct page *dev_alloc_pages(unsigned int order)
{
	gfp_t gfp_mask = GFP_ATOMIC | __GFP_NOWARN | __GFP_COLD | __GFP_COMP | __GFP_MEMALLOC;
	return alloc_pages_node(NUMA_NO_NODE, gfp_mask, order);
}

static inline struct page *dev_alloc_page(void)
{
	return dev_alloc_pages(0);
}
#endif
#endif /* _COMPAT_LINUX_SKBUFF_H */
