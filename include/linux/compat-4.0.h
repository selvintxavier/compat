#ifndef LINUX_4_0_COMPAT_H
#define LINUX_4_0_COMPAT_H

#include <linux/version.h>

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0))

#include "../../compat/config.h"
#include <linux/dcache.h>

/**
 * d_inode - Get the actual inode of this dentry
 * @dentry: The dentry to query
 *
 * This is the helper normal filesystems should use to get at their own inodes
 * in their own dentries and ignore the layering superimposed upon them.
 */
#ifndef HAVE_D_INODE
static inline struct inode *d_inode(const struct dentry *dentry)
{
	return dentry->d_inode;
}
#endif

#define debugfs_create_file_size LINUX_BACKPORT(debugfs_create_file_size)

struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
					struct dentry *parent, void *data,
					const struct file_operations *fops,
					loff_t file_size);

#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)) */

#endif /* LINUX_4.0_COMPAT_H */
