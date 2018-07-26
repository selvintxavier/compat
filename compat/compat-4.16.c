#ifndef HAVE_KOBJ_NS_DROP_EXPORTED
// SPDX-License-Identifier: GPL-2.0
/*
 * kobject.c - library routines for handling generic kernel objects
 *
 * Copyright (c) 2002-2003 Patrick Mochel <mochel@osdl.org>
 * Copyright (c) 2006-2007 Greg Kroah-Hartman <greg@kroah.com>
 * Copyright (c) 2006-2007 Novell Inc.
 *
 * Please see the file Documentation/kobject.txt for critical information
 * about using the kobject interface.
 */

#include <linux/kobject.h>
#include <linux/string.h>
#include <linux/export.h>
#include <linux/stat.h>
#include <linux/slab.h>
#include <linux/random.h>

static DEFINE_SPINLOCK(kobj_ns_type_lock);
static const struct kobj_ns_type_operations *kobj_ns_ops_tbl[KOBJ_NS_TYPES];

#define kobj_ns_grab_current LINUX_BACKPORT(kobj_ns_grab_current)
void *kobj_ns_grab_current(enum kobj_ns_type type)
{
	void *ns = NULL;

	spin_lock(&kobj_ns_type_lock);
	if ((type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES) &&
	    kobj_ns_ops_tbl[type])
		ns = kobj_ns_ops_tbl[type]->grab_current_ns();
	spin_unlock(&kobj_ns_type_lock);

	return ns;
}
EXPORT_SYMBOL_GPL(kobj_ns_grab_current);

#define kobj_ns_drop LINUX_BACKPORT(kobj_ns_drop)
void kobj_ns_drop(enum kobj_ns_type type, void *ns)
{
	spin_lock(&kobj_ns_type_lock);
	if ((type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES) &&
	    kobj_ns_ops_tbl[type] && kobj_ns_ops_tbl[type]->drop_ns)
		kobj_ns_ops_tbl[type]->drop_ns(ns);
	spin_unlock(&kobj_ns_type_lock);
}
EXPORT_SYMBOL_GPL(kobj_ns_drop);
#endif
