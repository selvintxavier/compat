#ifndef _COMPAT_LINUX_SKBUFF_H
#define _COMPAT_LINUX_SKBUFF_H

#include "../../compat/config.h"
#include <linux/version.h>

#include_next <linux/skbuff.h>


#ifndef HAVE_SKB_PUT_ZERO
#define skb_put_zero LINUX_BACKPORT(skb_put_zero)
static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
{
	void *tmp = skb_put(skb, len);

	memset(tmp, 0, len);

	return tmp;
}
#endif

#endif /* _COMPAT_LINUX_SKBUFF_H */
