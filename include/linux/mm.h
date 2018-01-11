#ifndef _COMPAT_LINUX_MM_H
#define _COMPAT_LINUX_MM_H 1

#include "../../compat/config.h"
#include_next <linux/mm.h>

#ifndef HAVE_GET_USER_PAGES_REMOTE
#define get_user_pages_remote get_user_pages
#endif

#endif	/* _COMPAT_LINUX_MM_H */
