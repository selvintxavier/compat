/*
 * Copyright 2012  Luis R. Rodriguez <mcgrof@frijolero.org>
 * Copyright (c) 2012 Mellanox Technologies. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * Compatibility file for Linux wireless for kernels 3.2.
 */

#include <linux/kernel.h>
#include <linux/device.h>
#include <linux/ethtool.h>
#include <linux/rtnetlink.h>

int __netdev_printk(const char *level, const struct net_device *dev,
			   struct va_format *vaf)
{
	int r;

	if (dev && dev->dev.parent)
#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,35))
		r = dev_printk(level, dev->dev.parent, "%s: %pV",
			       netdev_name(dev), vaf);
#else
		/* XXX: this could likely be done better but I'm lazy */
		r = printk("%s%s: %pV", level, netdev_name(dev), vaf);
#endif
	else if (dev)
		r = printk("%s%s: %pV", level, netdev_name(dev), vaf);
	else
		r = printk("%s(NULL net_device): %pV", level, vaf);

	return r;
}
EXPORT_SYMBOL(__netdev_printk);

int __ethtool_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
{
        ASSERT_RTNL();

        if (!dev->ethtool_ops || !dev->ethtool_ops->get_settings)
                return -EOPNOTSUPP;

        memset(cmd, 0, sizeof(struct ethtool_cmd));
        cmd->cmd = ETHTOOL_GSET;
        return dev->ethtool_ops->get_settings(dev, cmd);
}
EXPORT_SYMBOL(__ethtool_get_settings);
