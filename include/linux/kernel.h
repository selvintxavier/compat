#ifndef COMPAT_KERNEL_H
#define COMPAT_KERNEL_H

#include "../../compat/config.h"

#include_next <linux/kernel.h>


#ifndef u64_to_user_ptr
#define u64_to_user_ptr(x) (		\
{					\
	typecheck(u64, x);		\
	(void __user *)(uintptr_t)x;	\
}					\
)
#endif

#endif /* COMPAT_KERNEL_H */
