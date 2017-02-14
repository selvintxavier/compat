#include <linux/export.h>
#include <linux/vmalloc.h>

#define kvfree LINUX_BACKPORT(kvfree)
void kvfree(const void *addr)
{
	if (is_vmalloc_addr(addr))
		vfree(addr);
	else
		kfree(addr);
}
EXPORT_SYMBOL(kvfree);

#define idr_is_empty LINUX_BACKPORT(idr_is_empty)
static int idr_has_entry(int id, void *p, void *data)
{
        return 1;
}

bool idr_is_empty(struct idr *idp)
{
        return !idr_for_each(idp, idr_has_entry, NULL);
}
EXPORT_SYMBOL(idr_is_empty);
