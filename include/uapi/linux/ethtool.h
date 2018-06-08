/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/*
 * ethtool.h: Defines for Linux ethtool.
 *
 * Copyright (C) 1998 David S. Miller (davem@redhat.com)
 * Copyright 2001 Jeff Garzik <jgarzik@pobox.com>
 * Portions Copyright 2001 Sun Microsystems (thockin@sun.com)
 * Portions Copyright 2002 Intel (eli.kupermann@intel.com,
 *                                christopher.leech@intel.com,
 *                                scott.feldman@intel.com)
 * Portions Copyright (C) Sun Microsystems 2008
 */

#ifndef __BACKPORT_UAPI_LINUX_ETHTOOL_H
#define __BACKPORT_UAPI_LINUX_ETHTOOL_H

#include_next <uapi/linux/ethtool.h>

#ifndef PFC_STORM_PREVENTION_AUTO
#define PFC_STORM_PREVENTION_AUTO	0xffff
#endif
#endif /* __BACKPORT_UAPI_LINUX_ETHTOOL_H */
