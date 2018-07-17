#ifndef _COMPAT_LINUX_NETDEVICE_H
#define _COMPAT_LINUX_NETDEVICE_H 1

#include "../../compat/config.h"
#include <linux/kconfig.h>

#include_next <linux/netdevice.h>


#if IS_ENABLED(CONFIG_VXLAN) && (defined(HAVE_NDO_ADD_VXLAN_PORT) || defined(HAVE_NDO_UDP_TUNNEL_ADD))
#define HAVE_KERNEL_WITH_VXLAN_SUPPORT_ON
#endif
#ifdef HAVE_NETDEV_XDP
#define HAVE_NETDEV_BPF 1
#define netdev_bpf	netdev_xdp
#define ndo_bpf		ndo_xdp
#endif

static inline const char *netdev_reg_state(const struct net_device *dev)
{
	switch (dev->reg_state) {
	case NETREG_UNINITIALIZED: return " (uninitialized)";
	case NETREG_REGISTERED: return "";
	case NETREG_UNREGISTERING: return " (unregistering)";
	case NETREG_UNREGISTERED: return " (unregistered)";
	case NETREG_RELEASED: return " (released)";
	case NETREG_DUMMY: return " (dummy)";
	}

	WARN_ONCE(1, "%s: unknown reg_state %d\n", dev->name, dev->reg_state);
	return " (unknown)";
}

#ifndef HAVE_TC_SETUP_QDISC_MQPRIO
#define TC_SETUP_QDISC_MQPRIO TC_SETUP_MQPRIO

#ifndef netdev_WARN_ONCE

#define netdev_level_once(level, dev, fmt, ...)			\
do {								\
	static bool __print_once __read_mostly;			\
								\
	if (!__print_once) {					\
		__print_once = true;				\
		netdev_printk(level, dev, fmt, ##__VA_ARGS__);	\
	}							\
} while (0)

#define netdev_emerg_once(dev, fmt, ...) \
	netdev_level_once(KERN_EMERG, dev, fmt, ##__VA_ARGS__)
#define netdev_alert_once(dev, fmt, ...) \
	netdev_level_once(KERN_ALERT, dev, fmt, ##__VA_ARGS__)
#define netdev_crit_once(dev, fmt, ...) \
	netdev_level_once(KERN_CRIT, dev, fmt, ##__VA_ARGS__)
#define netdev_err_once(dev, fmt, ...) \
	netdev_level_once(KERN_ERR, dev, fmt, ##__VA_ARGS__)
#define netdev_warn_once(dev, fmt, ...) \
	netdev_level_once(KERN_WARNING, dev, fmt, ##__VA_ARGS__)
#define netdev_notice_once(dev, fmt, ...) \
	netdev_level_once(KERN_NOTICE, dev, fmt, ##__VA_ARGS__)
#define netdev_info_once(dev, fmt, ...) \
	netdev_level_once(KERN_INFO, dev, fmt, ##__VA_ARGS__)


#define netdev_WARN_ONCE(dev, format, args...)				\
	WARN_ONCE(1, "netdevice: %s%s: " format, netdev_name(dev),	\
		  netdev_reg_state(dev), ##args)

#endif /* netdev_WARN_ONCE */
#endif

#endif	/* _COMPAT_LINUX_NETDEVICE_H */
