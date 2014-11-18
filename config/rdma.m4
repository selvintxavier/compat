dnl Checks for the in-box ib_core
AC_DEFUN([RDMA_CONFIG_COMPAT],
[
	AC_MSG_CHECKING([if ib_verbs has ib_dma_map_single])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/ib_verbs.h>
	],[
		ib_dma_map_single(NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INBOX_IB_DMA_MAP, 1,
			  [ib_dma_map_single defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ib_create_cq wants comp_vector])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/ib_verbs.h>
	],[
		ib_create_cq(NULL, NULL, NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INBOX_IB_COMP_VECTOR, 1,
			  [has completion vector])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rdma_cm has RDMA_CM_EVENT_ADDR_CHANGE])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/rdma_cm.h>
	],[
		return (RDMA_CM_EVENT_ADDR_CHANGE == 0);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INBOX_RDMA_CMEV_ADDRCHANGE, 1,
			  [has completion vector])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rdma_cm has RDMA_CM_EVENT_TIMEWAIT_EXIT])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/rdma_cm.h>
	],[
		return (RDMA_CM_EVENT_TIMEWAIT_EXIT == 0);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INBOX_RDMA_CMEV_TIMEWAIT_EXIT, 1,
			  [has completion vector])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rdma_cm has rdma_set_reuseaddr])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/rdma_cm.h>
	],[
		rdma_set_reuseaddr(NULL, 1);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INBOX_RDMA_SET_REUSEADDR, 1,
			  [rdma_set_reuse defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ib_wc has member named ts])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <rdma/ib_verbs.h>
	],[
        struct ib_wc wc;
        wc->ts.timestamp = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INBOX_IB_WC_TS, 1,
			  [ib_wc has member named ts])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ib_ah_attr has member named dmac])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <rdma/ib_verbs.h>
	],[
        struct ib_ah_attr *ah_attr;
        memset(ah_attr->dmac, 0, 6);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INBOX_IB_AH_ATTR_DMAC, 1,
			  [ah_attr has member named dmac])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ib_ah_attr has member named vlan_id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <rdma/ib_verbs.h>
	],[
        struct ib_ah_attr *ah_attr;
        ah_attr->vlan_id = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INBOX_IB_AH_ATTR_VLAN_ID, 1,
			  [ah_attr has member named vlan_id])
	],[
		AC_MSG_RESULT(no)
	])
])

dnl Examine kernel functionality
AC_DEFUN([LINUX_CONFIG_COMPAT],
[
	AC_MSG_CHECKING([if kernel has ktime_get_ns])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ktime.h>
	],[
		unsigned long long ns;

		ns = ktime_get_ns();
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_KTIME_GET_NS, 1,
			  [ktime_get_ns defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if svc_xprt_class has xcl_ident])
	LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
		#include <linux/sunrpc/svc_xprt.h>
	],[
		struct svc_xprt_class svc_rdma_class = {
			.xcl_ident = XPRT_TRANSPORT_RDMA,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_XCL_IDENT, 1,
			  [xcl_ident defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ifla_vf_info has max_tx_rate])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		struct ifla_vf_info *ivf;

		ivf->max_tx_rate = 0;
		ivf->min_tx_rate = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TX_RATE_LIMIT, 1,
			  [max_tx_rate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_rxfh])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_rxfh_indir_size = NULL,
			.get_rxfh = NULL,
			.set_rxfh = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_RXFH, 1,
			  [get/set_rxfh is defined])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if struct ethtool_ops has get/set_tunable])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_tunable = NULL,
			.set_tunable = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_TUNABLE, 1,
			  [get/set_tunable is defined])
	],[
		AC_MSG_RESULT(no)
	])
	AC_MSG_CHECKING([if struct net_device has dev_port])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;

		dev->dev_port = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_DEV_PORT, 1,
			  [dev_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ptp_clock_info has n_pins])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		struct ptp_clock_info *info;
		info->n_pins = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PTP_CLOCK_INFO_N_PINS, 1,
			  [n_pins is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h pci_enable_msi_exact])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		int x = pci_enable_msi_exact(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_ENABLE_MSI_EXACT, 1,
			  [pci_enable_msi_exact is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h pci_enable_msix_range])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		int x = pci_enable_msix_range(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_ENABLE_MSIX_RANGE, 1,
			  [pci_enable_msix_range is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct iscsi_transport has check_protection])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_transport_iscsi.h>
	],[
		static struct iscsi_transport iscsi_iser_transport = {
			.check_protection = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSI_CHECK_PROTECTION, 1,
			  [check_protection is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has select_queue_fallback_t])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		select_queue_fallback_t fallback;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SELECT_QUEUE_FALLBACK_T, 1,
			  [select_queue_fallback_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h has skb_set_hash])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		skb_set_hash(NULL, 0, PKT_HASH_TYPE_L3);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SKB_SET_HASH, 1,
			  [skb_set_hash is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if sockios.h has SIOCGHWTSTAMP])
	LB_LINUX_TRY_COMPILE([
		#include <linux/sockios.h>
	],[
		int x = SIOCGHWTSTAMP;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SIOCGHWTSTAMP, 1,
			  [SIOCGHWTSTAMP is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ip.h inet_get_local_port_range has 3 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <net/ip.h>
	],[
		inet_get_local_port_range(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INET_GET_LOCAL_PORT_RANGE_3_PARAMS, 1,
			  [inet_get_local_port_range has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net.h has net_get_random_once])
	LB_LINUX_TRY_COMPILE([
		#include <linux/net.h>
	],[
		net_get_random_once(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_GET_RANDOM_ONCE, 1,
			  [net_get_random_once is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if inet_sock.h has __inet_ehashfn])
	LB_LINUX_TRY_COMPILE([
		#include <net/inet_sock.h>
	],[
		__inet_ehashfn(0, 0, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INET_EHASHFN, 1,
			  [__inet_ehashfn is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if err.h has PTR_ERR_OR_ZERO])
	LB_LINUX_TRY_COMPILE([
		#include <linux/err.h>
	],[
		int x = PTR_ERR_OR_ZERO(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PTR_ERR_OR_ZERO, 1,
			  [PTR_ERR_OR_ZERO is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct iscsi_session has discovery_sess])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/libiscsi.h>
	],[
		struct iscsi_session session;
		session.discovery_sess = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSI_DISCOVERY_SESS, 1,
			  [discovery_sess is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum iscsi_param has ISCSI_PARAM_DISCOVERY_SESS])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/iscsi_if.h>
	],[
		int x = ISCSI_PARAM_DISCOVERY_SESS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSI_PARAM_DISCOVERY_SESS, 1,
			  [ISCSI_PARAM_DISCOVERY_SESS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has enum pcie_link_width])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		enum pcie_link_width width = PCIE_LNK_WIDTH_UNKNOWN;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCIE_LINK_WIDTH, 1,
			  [pcie_link_width is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has enum pci_bus_speed])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_BUS_SPEED, 1,
			  [pci_bus_speed is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has struct netdev_phys_port_id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_phys_port_id x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_PHYS_PORT_ID, 1,
			  [netdev_phys_port_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ifla_vf_info has linkstate])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		struct struct ifla_vf_info x;
		x->linkstate = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_LINKSTATE, 1,
			  [linkstate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if busy_poll.h has skb_mark_napi_id])
	LB_LINUX_TRY_COMPILE([
		#include <net/busy_poll.h>
	],[
		skb_mark_napi_id(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SKB_MARK_NAPI_ID, 1,
			  [skb_mark_napi_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has napi_hash_add])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		napi_hash_add(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NAPI_HASH_ADD, 1,
			  [napi_hash_add is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_keep_dst])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_keep_dst(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_KEEP_DST, 1,
			  [netif_keep_dst is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has kvfree])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		kvfree(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_KVFREE, 1,
			  [kvfree is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has dev_consume_skb_any])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		dev_consume_skb_any(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DEV_CONSUME_SKB_ANY, 1,
			  [dev_consume_skb_any is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_txq_bql_complete_prefetchw])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_txq_bql_complete_prefetchw(NULL);
		netdev_txq_bql_enqueue_prefetchw(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_TXQ_BQL_PREFETCHW, 1,
			  [netdev_txq_bql_complete_prefetchw is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct sk_buff has xmit_more])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		struct sk_buff *skb;
		skb->xmit_more = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SK_BUFF_XMIT_MORE, 1,
			  [xmit_more is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if etherdevice.h has eth_get_headlen])
	LB_LINUX_TRY_COMPILE([
		#include <linux/etherdevice.h>
	],[
		eth_get_headlen(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETH_GET_HEADLEN, 1,
			  [eth_get_headlen is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct sk_buff has csum_level])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		struct sk_buff *skb;
		skb->csum_level = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SK_BUFF_CSUM_LEVEL, 1,
			  [csum_level is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has vlan_dev_get_egress_qos_mask])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		vlan_dev_get_egress_qos_mask(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VLAN_DEV_GET_EGRESS_QOS_MASK, 1,
			  [vlan_dev_get_egress_qos_mask is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_get_prio_tc_map])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_get_prio_tc_map(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_GET_PRIO_TC_MAP, 1,
			  [netdev_get_prio_tc_map is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has __vlan_find_dev_deep_rcu])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		__vlan_find_dev_deep_rcu(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE___VLAN_FIND_DEV_DEEP_RCU, 1,
			  [__vlan_find_dev_deep_rcu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_select_queue has accel_priv])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_opts ndops;

		static u16 select_queue(struct net_device *dev, struct sk_buff *skb,
				        void *accel_priv)
		{
			return 0;
		}

		ndoops.ndo_select_queue = select_queue;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(NDO_SELECT_QUEUE_HAS_ACCEL_PRIV, 1,
			  [ndo_select_queue has accel_priv])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if drivers/net/bonding/bonding.h exists])
	LB_LINUX_TRY_COMPILE([
		#include "../drivers/net/bonding/bonding.h"
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BONDING_H, 1,
			  [drivers/net/bonding/bonding.h exists])
	],[
		AC_MSG_RESULT(no)
	])

])
#
# COMPAT_CONFIG_HEADERS
#
# add -include config.h
#
AC_DEFUN([COMPAT_CONFIG_HEADERS],[
	AC_CONFIG_HEADERS([config.h])
	EXTRA_KCFLAGS="-include $PWD/config.h $EXTRA_KCFLAGS"
	AC_SUBST(EXTRA_KCFLAGS)
])

AC_DEFUN([OFA_PROG_LINUX],
[

LB_LINUX_PATH
LB_LINUX_SYMVERFILE
LB_LINUX_CONFIG([MODULES],[],[
    AC_MSG_ERROR([module support is required to build mlnx kernel modules.])
])
LB_LINUX_CONFIG([MODVERSIONS])
LB_LINUX_CONFIG([KALLSYMS],[],[
    AC_MSG_ERROR([compat_mlnx requires that CONFIG_KALLSYMS is enabled in your kernel.])
])

LINUX_CONFIG_COMPAT
COMPAT_CONFIG_HEADERS

])
