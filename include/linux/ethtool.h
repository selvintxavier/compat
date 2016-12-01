#ifndef __COMPAT_ETHTOOL_H
#define __COMPAT_ETHTOOL_H

#include_next <linux/ethtool.h>

#ifndef ETH_MODULE_SFF_8636
#define ETH_MODULE_SFF_8636		0x3
#define ETH_MODULE_SFF_8636_LEN		256
#endif

#ifndef ETH_MODULE_SFF_8436
#define ETH_MODULE_SFF_8436		0x4
#define ETH_MODULE_SFF_8436_LEN		256
#endif
#endif
