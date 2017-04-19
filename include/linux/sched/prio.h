#ifndef _COMPAT_LINUX_PRIO_H
#define _COMPAT_LINUX_PRIO_H 1

#include "../../../compat/config.h"

#ifdef HAVE_MIN_NICE
#include_next <linux/sched/prio.h>
#else
#define MAX_NICE        19
#define MIN_NICE        -20
#define NICE_WIDTH      (MAX_NICE - MIN_NICE + 1)
#endif /* HAVE_MIN_NICE */
#endif /* _COMPAT_LINUX_PRIO_H */

