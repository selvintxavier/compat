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
	AC_MSG_CHECKING([if file_system_type has mount method])
	LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		struct file_system_type fst;

		fst.mount = NULL;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_MOUNT_METHOD, 1,
			  [mount method defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kernel has get_next_ino])
	LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		unsigned int ino;

		ino = get_next_ino();
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_NEXT_INO, 1,
			  [get_next_ino defined])
	],[
		AC_MSG_RESULT(no)
	])

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

	AC_MSG_CHECKING([if kernel has ktime_get_boot_ns])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ktime.h>
	],[
		unsigned long long ns;

		ns = ktime_get_boot_ns();
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_KTIME_GET_BOOT_NS, 1,
			  [ktime_get_boot_ns defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if timekeeping.h has ktime_get_real_ns])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ktime.h>
		#include <linux/timekeeping.h>
	],[
		ktime_get_real_ns();

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_KTIME_GET_REAL_NS, 1,
			  [ktime_get_real_ns is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if time.h has time64_to_tm])
	LB_LINUX_TRY_COMPILE([
		#include <linux/time.h>
	],[
		struct tm tm;
		time64_t now = 0;

		time64_to_tm(now, 0, &tm);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TIME64_TO_TM, 1,
			  [time64_to_tm is defined])
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

	AC_MSG_CHECKING([if netdev_master_upper_dev_link gets 4 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_master_upper_dev_link(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(NETDEV_MASTER_UPPER_DEV_LINK_4_PARAMS, 1,
			  [netdev_master_upper_dev_link gets 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_rxfh])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_rxfh_key_size = NULL,
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

	AC_MSG_CHECKING([if struct ethtool_ops has get_rxfh_indir_size])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_rxfh_indir_size = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RXFH_INDIR_SIZE, 1,
			[get_rxfh_indir_size is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops_ext has get_rxfh_indir_size])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops_ext en_ethtool_ops_ext = {
			.get_rxfh_indir_size = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RXFH_INDIR_SIZE_EXT, 1,
			[get_rxfh_indir_size is defined in ethtool_ops_ext])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_rxfh_indir])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>

		int mlx4_en_get_rxfh_indir(struct net_device *d, u32 *r)
		{
			return 0;
		}
	],[
		struct ethtool_ops en_ethtool_ops;
		en_ethtool_ops.get_rxfh_indir = mlx4_en_get_rxfh_indir;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_RXFH_INDIR, 1,
			[get/set_rxfh_indir is defined])
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

	AC_MSG_CHECKING([if exist struct ethtool_ops_ext])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops_ext en_ethtool_ops_ext = {
			.size = sizeof(struct ethtool_ops_ext),
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_OPS_EXT, 1,
			  [struct ethtool_ops_ext is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops_ext has get/set_rxfh_indir])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops_ext en_ethtool_ops_ext = {
			.get_rxfh_indir = NULL,
			.set_rxfh_indir = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_RXFH_INDIR_EXT, 1,
			  [get/set_rxfh_indir is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has dev_port])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		dev->dev_port = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_DEV_PORT, 1,
			  [dev_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_extended has dev_port])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		netdev_extended(dev)->dev_port = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_EXTENDED_DEV_PORT, 1,
			  [ is defined])
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

	AC_MSG_CHECKING([if pci.h pci_msix_vec_count])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		int x = pci_msix_vec_count(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_MSIX_VEC_COUNT, 1,
			  [pci_msix_vec_count is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci_dev has msix_cap])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		struct pci_dev pdev;
		pdev.msix_cap = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_MSIX_CAP, 1,
			  [msix_cap is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm_struct has pinned_vm])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
	],[
		struct mm_types mmt;
		mmt.pinned_vm = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PINNED_VM, 1,
			  [pinned_vm is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kernel has idr_alloc])
	LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		int x;
		x =  idr_alloc(NULL, NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IDR_ALLOC, 1,
			  [idr_alloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kernel has percpu variables])
	LB_LINUX_TRY_COMPILE([
		#include <linux/percpu.h>
	],[
		static DEFINE_PER_CPU(unsigned int, x);
		this_cpu_inc(x);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PERCPU_VARS, 1,
			  [percpu variables are defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct iscsi_transport has attr_is_visible])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_transport_iscsi.h>
	],[
		static struct iscsi_transport iscsi_iser_transport = {
			.attr_is_visible = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSI_ATTR_IS_VISIBLE, 1,
			  [attr_is_visible is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct iscsi_transport has get_ep_param])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_transport_iscsi.h>
	],[
		static struct iscsi_transport iscsi_iser_transport = {
			.get_ep_param = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSI_GET_EP_PARAM, 1,
			  [get_ep_param is defined])
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

	AC_MSG_CHECKING([if iscsi_proto.h has struct iscsi_scsi_req])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/iscsi_proto.h>
	],[
		struct iscsi_scsi_req req = {
			.opcode = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSI_SCSI_REQ, 1,
			  [struct iscsi_scsi_req is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct request_queue has request_fn_active])
	LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct request_queue rq = {
			.request_fn_active = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_REQUEST_QUEUE_REQUEST_FN_ACTIVE, 1,
			  [struct request_queue has request_fn_active])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has select_queue_fallback_t])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		select_queue_fallback_t fallback;

		fallback = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SELECT_QUEUE_FALLBACK_T, 1,
			  [select_queue_fallback_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has skb_set_hash])
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

	AC_MSG_CHECKING([if netdevice.h has alloc_netdev with 4 params])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;

		dev = alloc_netdev(0, NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ALLOC_NETDEV_4P, 1,
			  [alloc_netdev has 4 parameters])
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
		#include <linux/pci_hotplug.h>
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
		#include <linux/pci_hotplug.h>
	],[
		enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;

		return speed;
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
		struct netdev_phys_port_id *x = NULL;

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
		struct ifla_vf_info *x;
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

	AC_MSG_CHECKING([if netdevice.h has __dev_uc_sync])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		__dev_uc_sync(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE___DEV_UC_SYNC, 1,
			  [__dev_uc_sync is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has __dev_mc_sync])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		__dev_mc_sync(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE___DEV_MC_SYNC, 1,
			  [__dev_mc_sync is defined])
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

	AC_MSG_CHECKING([if struct sk_buff has encapsulation])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		struct sk_buff *skb;
		skb->encapsulation = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SK_BUFF_ENCAPSULATION, 1,
			  [encapsulation is defined])
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

	AC_MSG_CHECKING([if struct skbuff.h has skb_inner_transport_header])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_inner_transport_header(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SKB_INNER_TRANSPORT_HEADER, 1,
			  [skb_inner_transport_header is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct skbuff.h has skb_inner_network_header])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_inner_network_header(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SKB_INNER_NETWORK_HEADER, 1,
			  [skb_inner_network_header is defined])
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

		static u16 select_queue(struct net_device *dev, struct sk_buff *skb,
				        void *accel_priv)
		{
			return 0;
		}
	],[
		struct net_device_opts ndops;

		ndops.ndo_select_queue = select_queue;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(NDO_SELECT_QUEUE_HAS_ACCEL_PRIV, 1,
			  [ndo_select_queue has accel_priv])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/bonding.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <net/bonding.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BONDING_H, 1,
			  [include/net/bonding.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bonding.h bond_for_each_slave has 3 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <net/bonding.h>
	],[
		struct bonding *bond = NULL;
		struct list_head *iter = NULL;
		struct slave *slave = NULL;

		bond_for_each_slave(bond, slave, iter) ;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BOND_FOR_EACH_SLAVE_3_PARAMS, 1,
			  [bond_for_each_slave has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if u64_stats_sync.h has u64_stats_init])
	LB_LINUX_TRY_COMPILE([
		#include <linux/u64_stats_sync.h>
	],[
		struct u64_stats_sync sync;
		u64_stats_init(&sync);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_U64_STATS_SYNC, 1,
			  [u64_stats_sync is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if u64_stats_sync.h has u64_stats_fetch_begin_irq])
	LB_LINUX_TRY_COMPILE([
		#include <linux/u64_stats_sync.h>
	],[
		struct u64_stats_sync sync;
		u64_stats_fetch_begin_irq(&sync);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_U64_STATS_FETCH_BEGIN_IRQ, 1,
			  [u64_stats_fetch_begin_irq is defined])
	],[
		AC_MSG_RESULT(no)
	])
	AC_MSG_CHECKING([if etherdevice.h has ether_addr_copy])
	LB_LINUX_TRY_COMPILE([
		#include <linux/etherdevice.h>
	],[
		char dest[6], src[6];
		ether_addr_copy(&dest, &src);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHER_ADDR_COPY, 1,
			  [ether_addr_copy is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_set_vf_rate])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_rate(struct net_device *dev, int vf, int min_tx_rate,
                                                   int max_tx_rate)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_set_vf_rate = set_vf_rate;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SET_VF_RATE, 1,
			  [ndo_set_vf_rate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_extended has hw_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		netdev_extended(dev)->hw_features = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_EXTENDED_HW_FEATURES, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_extended has _tx_ext])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		netdev_extended(dev)->_tx_ext = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_EXTENDED_TX_EXT, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_extended has ndo_busy_poll])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int busy_poll(struct napi_struct *napi)
		{
			return 0;
		}
	],[
		struct net_device *dev = NULL;

		netdev_extended(dev)->ndo_busy_poll = busy_poll;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_EXTENDED_NDO_BUSY_POLL, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has set_netdev_hw_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		set_netdev_hw_features(dev, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SET_NETDEV_HW_FEATURES, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_set_xps_queue])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		netif_set_xps_queue(dev, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_SET_XPS_QUEUE, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if struct net_device_ops has *ndo_set_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_features(struct net_device *dev, netdev_features_t features)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_set_features = set_features;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SET_FEATURES, 1,
			  [ndo_set_features is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_rx_flow_steer])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int rx_flow_steer(struct net_device *dev,
                                                     const struct sk_buff *skb,
                                                     u16 rxq_index,
                                                     u32 flow_id)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_rx_flow_steer = rx_flow_steer;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_RX_FLOW_STEER, 1,
			  [ndo_rx_flow_steer is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has priv_flags])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *netdev;
		netdev->priv_flags = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_PRIV_FLAGS, 1,
			  [priv_flags is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_get_stats64])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		struct rtnl_link_stats64* get_stats_64(struct net_device *dev,
                                                     struct rtnl_link_stats64 *storage)
		{
			struct rtnl_link_stats64 stats_64;
			return &stats_64;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_get_stats64 = get_stats_64;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_GET_STATS64, 1,
			  [ndo_get_stats64 is defined])
	],[
		AC_MSG_RESULT(no)
	])
	AC_MSG_CHECKING([if struct net_device_ops has ndo_bridge_set/getlink])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops =  {
			.ndo_bridge_setlink = NULL,
			.ndo_bridge_getlink = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_BRIDGE_SET_GET_LINK, 1,
			  [ndo_bridge_set/getlink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rtnetlink.h ndo_dflt_bridge_getlink has 7 params])
	LB_LINUX_TRY_COMPILE([
		#include <linux/rtnetlink.h>
	],[
		ndo_dflt_bridge_getlink(NULL, 0, 0, NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_DFLT_BRIDGE_GETLINK_7_PARAMS, 1,
			[ ndo_dflt_bridge_getlink with 7 params is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops ndo_vlan_rx_add_vid has 3 parameters ])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

	],[
		int vlan_rx_add_vid(struct net_device *dev,__be16 proto, u16 vid)
		{
			return 0;
		}
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_vlan_rx_add_vid = vlan_rx_add_vid;
		netdev_ops.ndo_vlan_rx_add_vid (NULL, 1, 1) ;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_RX_ADD_VID_HAS_3_PARAMS, 1,
			  [ndo_vlan_rx_add_vid has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops has ndo_get_phys_port_id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int get_phys_port_id(struct net_device *dev,
				     struct netdev_phys_port_id *ppid)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_get_phys_port_id = get_phys_port_id;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_NDO_GET_PHYS_PORT_ID, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_ext exist])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_ext netdev_ops_ext = {
			.size = sizeof(struct net_device_ops_ext),
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_OPS_EXT, 1,
			  [struct net_device_ops_ext is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended exist])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended ops_extended;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_OPS_EXTENDED, 1,
			  [struct net_device_ops_extended is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_ext has ndo_get_phys_port_id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int get_phys_port_id(struct net_device *dev,
				     struct netdev_phys_port_id *ppid)
		{
			return 0;
		}
	],[
		struct net_device_ops_ext netdev_ops_ext;

		netdev_ops_ext.ndo_get_phys_port_id = get_phys_port_id;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_EXT_NDO_GET_PHYS_PORT_ID, 1,
			  [ndo_get_phys_port_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops has ndo_set_vf_spoofchk])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_spoofchk(struct net_device *dev, int vf, bool setting)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_set_vf_spoofchk = set_vf_spoofchk;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_OPS_NDO_SET_VF_SPOOFCHK, 1,
			  [ndo_set_vf_spoofchk is defined in net_device_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_ext has ndo_set_vf_spoofchk])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_spoofchk(struct net_device *dev, int vf, bool setting)
		{
			return 0;
		}
	],[
		struct net_device_ops_ext netdev_ops_ext;

		netdev_ops_ext.ndo_set_vf_spoofchk = set_vf_spoofchk;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_OPS_EXT_NDO_SET_VF_SPOOFCHK, 1,
			  [ndo_set_vf_spoofchk is defined in net_device_ops_ext])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops has ndo_set_vf_link_state])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_link_state(struct net_device *dev, int vf, int link_state)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_set_vf_link_state = set_vf_link_state;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_OPS_NDO_SET_VF_LINK_STATE, 1,
			  [ndo_set_vf_link_state is defined in net_device_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_ext has ndo_set_vf_link_state])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_link_state(struct net_device *dev, int vf, int link_state)
		{
			return 0;
		}
	],[
		struct net_device_ops_ext netdev_ops_ext;

		netdev_ops_ext.ndo_set_vf_link_state = set_vf_link_state;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_OPS_EXT_NDO_SET_VF_LINK_STATE, 1,
			  [ndo_set_vf_link_state is defined])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if netdevice.h netif_set_real_num_tx_queues returns int])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device dev;
		int ret;
		ret = netif_set_real_num_tx_queues(&dev, 2);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RETURN_INT_FOR_SET_NUM_TX_QUEUES, 1,
			  [netif_set_real_num_tx_queues returns int])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netdevice.h has struct xps_map])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct xps_map map;
		map.len = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_XPS_MAP, 1,
			  [struct xps_map is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has set_phys_id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.set_phys_id= NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SET_PHYS_ID, 1,
			  [set_phys_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_channels])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_channels = NULL,
			.set_channels = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_CHANNELS, 1,
			  [get/set_channels is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops_ext has get/set_channels])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops_ext en_ethtool_ops_ext = {
			.get_channels = NULL,
			.set_channels = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_CHANNELS_EXT, 1,
			  [get/set_channels is defined in ethtool_ops_ext])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get_ts_info])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_ts_info = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_TS_INFO, 1,
			  [get_ts_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has set_dump])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.set_dump = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_OPS_SET_DUMP, 1,
			  [set_dump is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get_module_info])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_module_info = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_OPS_GET_MODULE_INFO, 1,
			  [get_module_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get_module_eeprom])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_module_eeprom = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_OPS_GET_MODULE_EEPROM, 1,
			  [get_module_eeprom is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops_ext has get_ts_info])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops_ext en_ethtool_ops_ext = {
			.get_ts_info = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_TS_INFO_EXT, 1,
			  [get_ts_info is defined in ethtool_ops_ext])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_flow_ext has h_dest])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		unsigned char mac[ETH_ALEN];
		struct ethtool_flow_ext h_ext;

		memcpy(&mac, h_ext.h_dest, ETH_ALEN);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_FLOW_EXT_H_DEST, 1,
			  [ethtool_flow_ext has h_dest])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has struct dev_addr_list])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct dev_addr_list addr;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_DEV_ADDR, 1,
			  [dev_addr_list is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_vfs_assigned])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		struct pci_dev pdev;
		pci_vfs_assigned(&pdev);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_VF_ASSIGNED, 1,
			  [pci_vfs_assigned is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vlan_insert_tag_set_proto is defined])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		struct sk_buff *skb;
		vlan_insert_tag_set_proto(skb, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VLAN_INSERT_TAG_SET_PROTO, 1,
			  [vlan_insert_tag_set_proto is defined])
	],[
		AC_MSG_RESULT(no)
		AC_MSG_CHECKING([if __vlan_put_tag has 3 parameters])
		LB_LINUX_TRY_COMPILE([
			#include <linux/if_vlan.h>
		],[
			struct sk_buff *skb;
			__vlan_put_tag(skb, 0, 0);
			return 0;
		],[
			AC_MSG_RESULT(yes)
			AC_DEFINE(HAVE_3_PARAMS_FOR_VLAN_PUT_TAG, 1,
				  [__vlan_put_tag has 3 parameters])
		],[
			AC_MSG_RESULT(no)
		])
	])

	AC_MSG_CHECKING([if __vlan_hwaccel_put_tag has 3 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		struct sk_buff *skb;
		__vlan_hwaccel_put_tag(skb, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_3_PARAMS_FOR_VLAN_HWACCEL_PUT_TAG, 1,
			  [__vlan_hwaccel_put_tag has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct inet6_ifaddr has if_next])
	LB_LINUX_TRY_COMPILE([
		#include <net/if_inet6.h>
	],[
		struct inet6_ifaddr ifp ;
		ifp.if_next = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INETADDR_IF_NEXT, 1,
			  [if_next is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has hw_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device dev;
		dev.hw_features = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_HW_FEATURES, 1,
			  [hw_features is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has hw_enc_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device dev;
		dev.hw_enc_features = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_HW_ENC_FEATURES, 1,
			  [hw_enc_features is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has rx_cpu_rmap])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device dev;
		dev.rx_cpu_rmap = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_RX_CPU_RMAP, 1,
			  [rx_cpu_rmap is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has vlan_hwaccel_receive_skb])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		struct sk_buff *skb;
		vlan_hwaccel_receive_skb(skb,0,0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VLAN_HWACCEL_RECEIVE_SKB, 1,
			  [vlan_hwaccel_receive_skb is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if irqdesc.h has irq_desc_get_irq_data])
	LB_LINUX_TRY_COMPILE([
		#include <linux/irq.h>
		#include <linux/irqdesc.h>
	],[
		struct irq_desc desc;
		struct irq_data *data = irq_desc_get_irq_data(&desc);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IRQ_DESC_GET_IRQ_DATA, 1,
			  [irq_desc_get_irq_data is defined])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if pci_dev has pcie_mpss])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		struct pci_dev *pdev;

		pdev->pcie_mpss = 0;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_DEV_PCIE_MPSS, 1,
			  [pcie_mpss is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/if_ether.h exist])
	LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/if_ether.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_UAPI_LINUX_IF_ETHER_H, 1,
			  [uapi/linux/if_ether.h exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ifla_vf_info has spoofchk])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		struct ifla_vf_info *ivf;

		ivf->spoofchk = 0;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VF_INFO_SPOOFCHK, 1,
			  [spoofchk is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan.h has vxlan_gso_check])
	LB_LINUX_TRY_COMPILE([
		#include <net/vxlan.h>
	],[
		vxlan_gso_check(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VXLAN_GSO_CHECK, 1,
			  [vxlan_gso_check is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dst.h has dst_get_neighbour])
	LB_LINUX_TRY_COMPILE([
		#include <net/dst.h>
	],[
		struct neighbour *neigh = dst_get_neighbour(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DST_GET_NEIGHBOUR, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink_dump_start has 6 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netlink.h>
	],[
		int ret = netlink_dump_start(NULL, NULL, NULL, NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETLINK_DUMP_START_6P, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink_dump_start has 5 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netlink.h>
	],[
		int ret = netlink_dump_start(NULL, NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETLINK_DUMP_START_5P, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct dcbnl_rtnl_ops has ieee_getmaxrate/ieee_setmaxrate])
	LB_LINUX_TRY_COMPILE([
		#include <net/dcbnl.h>
	],[
		const struct dcbnl_rtnl_ops en_dcbnl_ops = {
			.ieee_getmaxrate = NULL,
			.ieee_setmaxrate = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IEEE_GET_SET_MAXRATE, 1,
			  [ieee_getmaxrate/ieee_setmaxrate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_LANG_PUSH(C)
	ac_c_werror_flag=yes
	save_EXTRA_KCFLAGS=$EXTRA_KCFLAGS
	EXTRA_KCFLAGS="$EXTRA_KCFLAGS -Werror"

	AC_MSG_CHECKING([if bonding.h bond_for_each_slave has int for 3rd parameter])
	LB_LINUX_TRY_COMPILE([
		#include <net/bonding.h>
	],[
		struct bonding *bond = NULL;
		struct slave *slave = NULL;
		int iter;

		bond_for_each_slave(bond, slave, iter) ;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BOND_FOR_EACH_SLAVE_3RD_PARAM_IS_INT, 1,
			  [bond_for_each_slave has int for 3rd parameter])
	],[
		AC_MSG_RESULT(no)
	])
	EXTRA_KCFLAGS="$save_EXTRA_KCFLAGS"
	ac_c_werror_flag=
	AC_LANG_POP

	AC_MSG_CHECKING([if netdevice.h has netdev_master_upper_dev_get_rcu])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_master_upper_dev_get_rcu(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_MASTER_UPPER_DEV_GET_RCU, 1,
			  [netdev_master_upper_dev_get_rcu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if __vlan_find_dev_deep has 3 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		__vlan_find_dev_deep(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE__VLAN_FIND_DEV_DEEP_3P, 1,
			  [__vlan_find_dev_deep has 3 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if sk_buff.h has __skb_alloc_page])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		__skb_alloc_page(0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE__SKB_ALLOC_PAGE, 1,
			  [sk_buff has __skb_alloc_page])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if __vlan_hwaccel_put_tag has 3 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		__vlan_hwaccel_put_tag(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE__VLAN_HWACCEL_PUT_TAG_3P, 1,
			  [__vlan_hwaccel_put_tag has 3 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/mm_types.h has struct page_frag])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
	],[
		struct page_frag frag = {0};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_MM_TYPES_PAGE_FRAG, 1,
			  [linux/mm_types.h has struct page_frag])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has __vlan_find_dev_deep])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		__vlan_find_dev_deep(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE___VLAN_FIND_DEV_DEEP, 1,
			  [__vlan_find_dev_deep is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr .h has idr_Alloc])
	LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		idr_alloc(NULL, NULL, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IDR_NEW_INTERFACE, 1,
			  [idr_Alloc is defined]) ],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr.h has idr_is_empty])
	LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		bool x = idr_is_empty(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IDR_IS_EMPTY, 1,
			  [idr_is_empty is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if completion.h has reinit_completion])
	LB_LINUX_TRY_COMPILE([
		#include <linux/completion.h>
	],[
		struct completion c;

		reinit_completion(&c);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_REINIT_COMPLETION, 1,
			  [reinit_completion is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma-mapping.h has dma_set_mask_and_coherent])
	LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		dma_set_mask_and_coherent(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DMA_SET_MASK_AND_COHERENT, 1,
			  [dma_set_mask_and_coherent is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if in.h has proto_ports_offset])
	LB_LINUX_TRY_COMPILE([
		#include <linux/in.h>
	],[
		int x = proto_ports_offset(IPPROTO_TCP);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PROTO_PORTS_OFFSET, 1,
			  [proto_ports_offset is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([elfcorehdr_addr],
		[kernel/crash_dump.c],
		[AC_DEFINE(HAVE_ELFCOREHDR_ADDR_EXPORTED, 1,
			[elfcorehdr_addr is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if netif_set_real_num_rx_queues is defined])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		int rc = netif_set_real_num_rx_queues(NULL, 0);

		return rc;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_SET_REAL_NUM_RX_QUEUES, 1,
			  [netif_set_real_num_rx_queues is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has is_vlan_dev])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <linux/if_vlan.h>
	],[
		struct net_device dev;
		is_vlan_dev(&dev);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IS_VLAN_DEV, 1,
			  [is_vlan_dev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/timecounter.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/timecounter.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TIMECOUNTER_H, 1,
			  [linux/timecounter.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	# timecounter_adjtime can be in timecounter.h or clocksource.h
	AC_MSG_CHECKING([if linux/clocksource.h has timecounter_adjtime])
	LB_LINUX_TRY_COMPILE([
		#include <linux/timecounter.h>
	],[
		struct timecounter x;
		s64 y = 0;
		timecounter_adjtime(&x, y);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TIMECOUNTER_ADJTIME, 1,
			  [timecounter_adjtime is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/clocksource.h has timecounter_adjtime])
	LB_LINUX_TRY_COMPILE([
		#include <linux/clocksource.h>
	],[
		struct timecounter x;
		s64 y = 0;
		timecounter_adjtime(&x, y);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TIMECOUNTER_ADJTIME, 1,
			  [timecounter_adjtime is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if cyclecounter_cyc2ns has 4 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/timecounter.h>
	],[
		cyclecounter_cyc2ns(NULL, NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_CYCLECOUNTER_CYC2NS_4_PARAMS, 1,
			  [cyclecounter_cyc2ns has 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h struct net_device_ops has ndo_features_check])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		static const struct net_device_ops mlx4_netdev_ops = {
			.ndo_features_check	= NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_FEATURES_T, 1,
			  [netdev_features_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops get_rxnfc gets u32 *rule_locs])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
		static int mlx4_en_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *c,
					     u32 *rule_locs)
		{
			return 0;
		}
	],[
		struct ethtool_ops x = {
			.get_rxnfc = mlx4_en_get_rxnfc,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_OPS_GET_RXNFC_U32_RULE_LOCS, 1,
			  [ethtool_ops get_rxnfc gets u32 *rule_locs])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h enum ethtool_stringset has ETH_SS_RSS_HASH_FUNCS])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		enum ethtool_stringset x = ETH_SS_RSS_HASH_FUNCS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETH_SS_RSS_HASH_FUNCS, 1,
			  [ETH_SS_RSS_HASH_FUNCS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/irq_poll.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/irq_poll.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IRQ_POLL_H, 1,
			  [include/linux/irq_poll.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-mapping.h has struct dma_attrs])
	LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		struct dma_attrs *attrs;
		int ret;

		ret = dma_get_attr(DMA_ATTR_WRITE_BARRIER, attrs);

		return ret;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_STRUCT_DMA_ATTRS, 1,
			  [struct dma_attrs is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pcie_get_minimum_link])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		int ret;
		ret = pcie_get_minimum_link(NULL, NULL, NULL);

		return ret;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCIE_GET_MINIMUM_LINK, 1,
			  [pcie_get_minimum_link is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_for_each_all_upper_dev_rcu])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;
		struct net_device *upper;
		struct list_head *list;

		netdev_for_each_all_upper_dev_rcu(dev, upper, list);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_FOR_EACH_ALL_UPPER_DEV_RCU, 1,
			  [netdev_master_upper_dev_get_rcu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_has_upper_dev])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;
		struct net_device *upper;
		netdev_has_upper_dev(dev, upper);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_HAS_UPPER_DEV, 1,
			  [netdev_has_upper_dev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has __ethtool_get_link_ksettings])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		 __ethtool_get_link_ksettings(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE___ETHTOOL_GET_LINK_KSETTINGS, 1,
			  [__ethtool_get_link_ksettings is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if addrconf.h has addrconf_ifid_eui48])
	LB_LINUX_TRY_COMPILE([
		#include <net/addrconf.h>
	],[
		int x = addrconf_ifid_eui48(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ADDRCONF_IFID_EUI48, 1,
			  [addrconf_ifid_eui48 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h get_user_pages_remote])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages_remote(NULL, NULL, 0, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_USER_PAGES_REMOTE, 1,
			  [get_user_pages_remote exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ip_fib.h fib_lookup has 4 params])
	LB_LINUX_TRY_COMPILE([
		#include <linux/bug.h>
		#include <net/ip_fib.h>
	],[
		fib_lookup(NULL, NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_FIB_LOOKUP_4_PARAMS, 1,
			  [fib_lookup has 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/devlink.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVLINK_H, 1,
			  [include/net/devlink.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if io_mapping_map_wc has 3 params])
	LB_LINUX_TRY_COMPILE([
		#include <linux/io-mapping.h>
	],[
		io_mapping_map_wc(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IO_MAPPING_MAP_WC_3_PARAMS, 1,
			  [io_mapping_map_wc has 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/dcbnl.h struct dcbnl_rtnl_ops has *ieee_getqcn])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>
	],[
		struct dcbnl_rtnl_ops x = {
			.ieee_getqcn = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IEEE_GETQCN, 1,
			  [ieee_getqcn is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dcbnl.h has struct ieee_qcn])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>
	],[
		struct ieee_qcn x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_STRUCT_IEEE_QCN, 1,
			  [ieee_qcn is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has napi_consume_skb])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		napi_consume_skb(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NAPI_CONSUME_SKB, 1,
			  [napi_consume_skb is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/bpf.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_LINUX_BPF_H, 1,
			  [include/linux/bpf.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm_types.h struct page has _count])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		#include <linux/mm_types.h>
	],[
		struct page p;
		p._count.counter = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_MM_PAGE__COUNT, 1,
			  [struct page has _count])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/page_ref.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/page_ref.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_LINUX_PAGE_REF_H, 1,
			  [include/linux/page_ref.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/ethtool.h has ETHTOOL_xLINKSETTINGS API])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		enum ethtool_link_mode_bit_indices x = ETHTOOL_LINK_MODE_TP_BIT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_xLINKSETTINGS, 1,
			  [ETHTOOL_xLINKSETTINGS API is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/printk.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/printk.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_LINUX_PRINTK_H, 1,
			  [linux/printk.h is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if printk.h has struct va_format])
	LB_LINUX_TRY_COMPILE([
		#include <linux/printk.h>
	],[
		struct va_format x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VA_FORMAT, 1,
			  [va_format is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if irq.h irq_data has member affinity])
	LB_LINUX_TRY_COMPILE([
		#include <linux/irq.h>
		#include <linux/cpumask.h>
	],[
		cpumask_var_t x;
		struct irq_data y = {
			.affinity = x,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IRQ_DATA_AFFINITY, 1,
			  [irq_data member affinity is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if irq.h irq_data_get_affinity_mask])
	LB_LINUX_TRY_COMPILE([
		#include <linux/irq.h>
	],[
		irq_data_get_affinity_mask(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IRQ_DATA_GET_AFFINITY_MASK, 1,
			  [irq_data_get_affinity_mask exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_tx_napi_add])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_tx_napi_add(NULL, NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_TX_NAPI_ADD, 1,
			  [netif_tx_napi_add is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_setup_tc])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops x = {
			.ndo_setup_tc = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SETUP_TC, 1,
			  [ndo_setup_tc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_setup_tc takes 4 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx4_en_setup_tc(struct net_device *dev, u32 handle,
							 __be16 protocol, struct tc_to_netdev *tc)
		{
			return 0;
		}
	],[
		struct net_device_ops x = {
			.ndo_setup_tc = mlx4_en_setup_tc,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SETUP_TC_4_PARAMS, 1,
			  [ndo_setup_tc takes 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if etherdevice.h has alloc_etherdev_mqs, alloc_etherdev_mqs, num_tc])
	LB_LINUX_TRY_COMPILE([
		#include <linux/etherdevice.h>
		#include <linux/netdevice.h>
	],[
		struct net_device x = {
			.num_tx_queues = 0,
			.num_tc = 0,
		};
		alloc_etherdev_mqs(0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NEW_TX_RING_SCHEME, 1,
			  [alloc_etherdev_mqs, alloc_etherdev_mqs, num_tc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_set_tx_maxrate])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops x = {
			.ndo_set_tx_maxrate = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SET_TX_MAXRATE, 1,
			  [ndo_set_tx_maxrate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has gso_partial_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		dev->gso_partial_features = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_GSO_PARTIAL_FEATURES, 1,
			  [gso_partial_features is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan have ndo_add_vxlan_port])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		#if IS_ENABLED(CONFIG_VXLAN)
		void add_vxlan_port(struct net_device *dev, sa_family_t sa_family, __be16 port)
		{
			return 0;
		}
		#endif
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_add_vxlan_port = add_vxlan_port;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VXLAN_DYNAMIC_PORT, 1,
			[ndo_add_vxlan_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan has vxlan_get_rx_port])
	LB_LINUX_TRY_COMPILE([
		#if IS_ENABLED(CONFIG_VXLAN)
		#include <net/vxlan.h>
		#endif
	],[
		vxlan_get_rx_port(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VXLAN_ENABLED, 1,
			  [vxlan_get_rx_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan have ndo_udp_tunnel_add])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		#if IS_ENABLED(CONFIG_VXLAN)
		void udp_tunnel_add(struct net_device *dev, sa_family_t sa_family, __be16 port)
		{
			return 0;
		}
		#endif
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_udp_tunnel_add = udp_tunnel_add;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_UDP_TUNNEL_ADD, 1,
			[ndo_udp_tunnel_add is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan has udp_tunnel_get_rx_info])
	LB_LINUX_TRY_COMPILE([
		#include <net/udp_tunnel.h>
	],[
		udp_tunnel_get_rx_info(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_UDP_TUNNEL_GET_RX_INFO, 1,
			  [udp_tunnel_get_rx_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has struct netdev_bonding_info])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_bonding_info x;
		x.master.num_slaves = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_BONDING_INFO, 1,
			  [netdev_bonding_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has struct netdev_phys_item_id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_phys_item_id x;
		x.id_len = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_PHYS_ITEM_ID, 1,
			  [netdev_phys_item_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_set_vf_mac])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_mac(struct net_device *dev, int queue, u8 *mac)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_set_vf_mac = set_vf_mac;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SET_VF_MAC, 1,
			  [ndo_set_vf_mac is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if getnumtcs returns int])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>

		static int mlx4_en_dcbnl_getnumtcs(struct net_device *netdev, int tcid, u8 *num)

		{
			return 0;
		}

	],[
		struct dcbnl_rtnl_ops mlx4_en_dcbnl_ops = {
			.getnumtcs	= mlx4_en_dcbnl_getnumtcs,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(NDO_GETNUMTCS_RETURNS_INT, 1,
			  [if getnumtcs returns int])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if getapp returns int])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>

		static int mlx4_en_dcbnl_getapp(struct net_device *netdev, u8 idtype,
						u16 id)
		{
			return 0;
		}
	],[
		struct dcbnl_rtnl_ops mlx4_en_dcbnl_ops = {
			.getapp		= mlx4_en_dcbnl_getapp,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(NDO_GETAPP_RETURNS_INT, 1,
			  [if getapp returns int])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if setapp returns int])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>

		static int mlx4_en_dcbnl_setapp(struct net_device *netdev, u8 idtype,
						u16 id, u8 up)
		{
			return 0;
		}

	],[
		struct dcbnl_rtnl_ops mlx4_en_dcbnl_ops = {
			.setapp		= mlx4_en_dcbnl_setapp,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(NDO_SETAPP_RETURNS_INT, 1,
			  [if setapp returns int])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/inetdevice.h inet_confirm_addr has 5 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/inetdevice.h>
	],[
		inet_confirm_addr(NULL, NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INET_CONFIRM_ADDR_5_PARAMS, 1,
			  [inet_confirm_addr has 5 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([inet_confirm_addr],
		[net/ipv4/devinet.c],
		[AC_DEFINE(HAVE_INET_CONFIRM_ADDR_EXPORTED, 1,
			[inet_confirm_addr is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if netdevice.h has netdev_rss_key_fill])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_rss_key_fill(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_RSS_KEY_FILL, 1,
			  [netdev_rss_key_fill is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_get_vf_stats])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int get_vf_stats(struct net_device *dev, int vf, struct ifla_vf_stats *vf_stats)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_get_vf_stats = get_vf_stats;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_GET_VF_STATS, 1,
			  [ndo_get_vf_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ifla_vf_stats has rx_dropped])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		struct ifla_vf_stats stat = {
			.rx_dropped = 0,
			};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IFLA_VF_STATS_RX_DROPPED, 1,
			  [struct ifla_vf_stats has rx_dropped])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_set_vf_guid])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_guid(struct net_device *dev, int vf, u64 guid, int guid_type)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_set_vf_guid = set_vf_guid;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SET_VF_GUID, 1,
			  [ndo_set_vf_guid is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_trans_update])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_trans_update(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_TRANS_UPDATE, 1,
			  [netif_trans_update is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h alloc_netdev_mqs has 6 params])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		alloc_netdev_mqs(0, NULL, NET_NAME_UNKNOWN, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ALLOC_NETDEV_MQS_6_PARAMS, 1,
			  [alloc_netdev_mqs has 6 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if filter.h has XDP])
	LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		enum xdp_action action = XDP_ABORTED;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_FILTER_XDP, 1,
			  [filter.h has XDP])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct xdp_buff has rxq])
	LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		struct xdp_buff x = {
			.rxq = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_XDP_BUFF_RXQ, 1,
			  [struct xdp_buff has rxq])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if firmware.h has request_firmware_direct])
	LB_LINUX_TRY_COMPILE([
		#include <linux/firmware.h>
	],[
		(void)request_firmware_direct(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_REQUEST_FIRMWARE_DIRECT, 1,
			  [firmware.h has request_firmware_direct])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_set_vpd_size])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		(void)pci_set_vpd_size(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_SET_VPD_SIZE, 1,
			  [pci.h has pci_set_vpd_size])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtooL_drvinfo has erom_version])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_drvinfo e;

		return (e.erom_version);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_DRVINFO_EROM_VERSION, 1,
			  [ethtool_drvinfo has erom_version])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string_helpers.h string_get_size has 5 params])
	LB_LINUX_TRY_COMPILE([
		#include <linux/sched.h>
		#include <linux/bug.h>
		#include <linux/kernel.h>
		#include <linux/math64.h>
		#include <linux/export.h>
		#include <linux/ctype.h>
		#include <linux/errno.h>
		#include <linux/string.h>
		#include <linux/string_helpers.h>
	],[
		(void)string_get_size(0, 0, 0, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_STRING_GET_SIZE_5_PARAMS, 1,
			  [string_get_size has 5 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if debugfs.h debugfs_create_bool has bool pointer])
	LB_LINUX_TRY_COMPILE([
		#include <linux/debugfs.h>
	],[
		(void)debugfs_create_bool(NULL, 0, NULL, (bool *)0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DEBUGFS_CREATE_BOOL_USES_BOOL_PTR, 1,
			  [debugfs_create_bool has bool pointer])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pat_enabled is a function on X86])
	LB_LINUX_TRY_COMPILE([
#if defined(CONFIG_X86)
		#include <asm/pat.h>
#else
		#error "Not X86"
#endif
	],[
#if defined(CONFIG_X86)
		if (pat_enabled())
			return 0;
#endif

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PAT_ENABLED_FUNCTION_X86, 1,
			  [pat_enabled is a function])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/switchdev.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_SWITCHDEV_H, 1,
			  [include/net/switchdev.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops has ndo_udp_tunnel_add])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		void add_udp_tunnel(struct net_device *dev, struct udp_tunnel_info *ti)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_udp_tunnel_add = add_udp_tunnel;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_UDP_TUNNEL_ADD, 1,
			[ndo_udp_tunnel_add is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/netdev_features.h has tc offload feature])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_features_t hw_features = NETIF_F_HW_TC;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_OFFLOAD, 1,
			  [tc offload is supported])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct skbuff.h has skb_flow_dissect_flow_keys])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_flow_dissect_flow_keys(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SKB_FLOW_DISSECT_FLOW_KEYS, 1,
			  [skb_flow_dissect_flow_keys is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if workqueue.h has __cancel_delayed_work])
	LB_LINUX_TRY_COMPILE([
		#include <linux/workqueue.h>
	],[
		__cancel_delayed_work(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE___CANCEL_DELAYED_WORK, 1,
			  [__cancel_delayed_work is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_priv_flags])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_priv_flags = NULL,
			.set_priv_flags = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_PRIV_FLAGS, 1,
			  [get/set_priv_flags is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_get_num_tc])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_get_num_tc(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_GET_NUM_TC, 1,
			  [netdev_get_num_tc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops has ndo_set_vf_trust])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_trust(struct net_device *dev, int vf, bool setting)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_set_vf_trust = set_vf_trust;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_OPS_NDO_SET_VF_TRUST, 1,
			  [ndo_set_vf_trust is defined in net_device_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_features.h has NETIF_F_HW_VLAN_STAG_RX])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdev_features.h>
	],[
		netdev_features_t stag = NETIF_F_HW_VLAN_STAG_RX;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_F_HW_VLAN_STAG_RX, 1,
			[NETIF_F_HW_VLAN_STAG_RX is defined in netdev_features.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netdevice.h has NETIF_F_RXHASH])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		int x = NETIF_F_RXHASH;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_F_RXHASH, 1,
			  [NETIF_F_RXHASH is defined in netdevice.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_link.h has IFLA_VF_IB_NODE_PORT_GUID])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		int type = IFLA_VF_IB_NODE_GUID;

		type = IFLA_VF_IB_PORT_GUID;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IFLA_VF_IB_NODE_PORT_GUID, 1,
			  [trust is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h skb_shared_info has UNION tx_flags])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		struct skb_shared_info x;
		x.tx_flags.flags = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SKB_SHARED_INFO_UNION_TX_FLAGS, 1,
			  [skb_shared_info has union tx_flags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if nelems is atomic_t in struct rhashtable])
	LB_LINUX_TRY_COMPILE([
		#include <linux/atomic.h>
		#include <linux/poison.h>
		#include <linux/rhashtable.h>
	],[
		struct rhashtable *ht;
		atomic_read(&ht->nelems);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RHASHTABLE_NELEMS_ATOMIC_T, 1,
			  [nelems is atomic_t in struct rhashtable])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([pat_enabled],
		[arch/x86/mm/pat.c],
		[AC_DEFINE(HAVE_PAT_ENABLED_EXPORTED, 1,
			[pat_enabled is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([xprt_put],
		[net/sunrpc/xprt.c],
		[AC_DEFINE(HAVE_XPRT_PUT_EXPORTED, 1,
			[xprt_put is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if configfs.h default_groups is list_head])
	LB_LINUX_TRY_COMPILE([
		#include <linux/configfs.h>
	],[
		struct config_group x = {
			.group_entry = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_CONFIGFS_DEFAULT_GROUPS_LIST, 1,
			  [default_groups is list_head])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h enum ethtool_link_mode_bit_indices has ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT])
	LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/ethtool.h>
	],[
		enum ethtool_link_mode_bit_indices x = ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT, 1,
			  [ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/flow_dissector.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_FLOW_DISSECTOR_H, 1,
			  [include/net/flow_dissector.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/dcache.h has d_inode])
	LB_LINUX_TRY_COMPILE([
		#include <linux/dcache.h>
	],[
		struct inode *inode = d_inode(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_D_INODE, 1,
			[d_inode is defined in dcache.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/pkt_cls.h has tcf_exts_to_list])
	LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tcf_exts_to_list(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TCF_EXTS_TO_LIST, 1,
			  [tcf_exts_to_list is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/act_api.h has tcf_action_stats_update])
	LB_LINUX_TRY_COMPILE([
		#include <net/act_api.h>
	],[
		tcf_action_stats_update(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TCF_ACTION_STATS_UPDATE, 1,
			  [tcf_action_stats_update is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_mirred.h has is_tcf_mirred_redirect])
	LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		is_tcf_mirred_redirect(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IS_TCF_MIRRED_REDIRECT, 1,
			  [is_tcf_mirred_redirect is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_mirred.h has tcf_mirred_dev])
	LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		tcf_mirred_dev(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TCF_MIRRED_DEV, 1,
			  [tcf_mirred_dev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum tc_fl_command has TC_CLSFLOWER_STATS])
	LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		enum tc_fl_command x = TC_CLSFLOWER_STATS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_CLSFLOWER_STATS, 1,
			  [TC_CLSFLOWER_STATS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if time64.h has ns_to_timespec64])
	LB_LINUX_TRY_COMPILE([
		#include <linux/clocksource.h>
		#include <linux/time64.h>
	],[
		ns_to_timespec64(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NS_TO_TIMESPACE64, 1,
			  [ns_to_timespec64 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ptp_clock_info exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		struct ptp_clock_info info;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PTP_CLOCK_INFO, 1,
			  [ptp_clock_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ptp_clock_info has gettime])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		struct ptp_clock_info info = {
			.gettime = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PTP_CLOCK_INFO_GETTIME_32BIT, 1,
			  [gettime 32bit is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has get_module_eeprom])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_ops x = {
			.get_module_eeprom = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_MODULE_EEPROM, 1,
			  [HAVE_GET_MODULE_EEPROM is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has get_module_eeprom])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_ops_ext x = {
			.get_module_eeprom = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_MODULE_EEPROM_EXT, 1,
			[HAVE_GET_MODULE_EEPROM_EXT is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has napi_complete_done])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		napi_complete_done(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NAPI_COMPLETE_DONE, 1,
			  [napi_complete_done is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool_ext has set_phys_id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops_ext en_ethtool_ops_ext = {
			.set_phys_id = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SET_PHYS_ID_EXT, 1,
			  [set_phys_id is defined in ethtool_ops_ext])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_cls_flower_offload exists])
	LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_cls_flower_offload x;
		x = x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_FLOWER_OFFLOAD, 1,
			  [struct tc_cls_flower_offload is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has vlan_features_check])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		vlan_features_check(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VLAN_FEATURES_CHECK, 1,
			  [vlan_features_check is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_get_iflink])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops x = {
			.ndo_get_iflink = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_GET_IFLINK, 1,
			  [ndo_get_iflink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has __vlan_get_protocol])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		__vlan_get_protocol(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VLAN_GET_PROTOCOL, 1,
			  [__vlan_get_protocol defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has skb_vlan_tagged])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		skb_vlan_tagged(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SKB_VLAN_TAGGED, 1,
			  [skb_vlan_tagged defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_notifier_changeupper_info])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_notifier_changeupper_info info;

		info.master = 1;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_NOTIFIER_CHANGEUPPER_INFO, 1,
			  [netdev_notifier_changeupper_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-mq.h has blk_mq_unique_tag])
	LB_LINUX_TRY_COMPILE([
		#include <blk-mq.h>
	],[
		blk_mq_unique_tag(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BLK_MQ_UNIQUE_TAG, 1,
				[blk_mq_unique_tag exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_queue_virt_boundary exist])
	LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_virt_boundary(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BLK_QUEUE_VIRT_BOUNDARY, 1,
				[blk_queue_virt_boundary exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has scsi_change_queue_depth])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		scsi_change_queue_depth(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSCI_CHANGE_QUEUE_DEPTH, 1,
			[scsi_change_queue_depth exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct Scsi_Host has member nr_hw_queues])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct Scsi_Host sh = {
			.nr_hw_queues = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_HOST_NR_HW_QUEUES, 1,
				[Scsi_Host has members nr_hw_queues])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member track_queue_depth])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.track_queue_depth = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_TRACK_QUEUE_DEPTH, 1,
			[scsi_host_template has members track_queue_depth])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has SCSI_SCAN_INITIAL])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		int x = SCSI_SCAN_INITIAL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_SCAN_INITIAL, 1,
			  [SCSI_SCAN_INITIAL is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi.h has SG_MAX_SEGMENTS])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi.h>
	],[
		int x = SG_MAX_SEGMENTS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SG_MAX_SEGMENTS, 1,
			  [SG_MAX_SEGMENTS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct file_operations has write_iter])
	LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		const struct file_operations fo = {
			.write_iter = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_FILE_OPS_WRITE_ITER, 1,
			[write_iter is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/fs.h has inode_lock])
	LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		inode_lock(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INODE_LOCK, 1,
			[inode_lock is defined in fs.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dcache.h has simple_positive])
	LB_LINUX_TRY_COMPILE([
		#include <linux/dcache.h>
	],[
		int i = simple_positive(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SIMPLE_POSITIVE, 1,
			[simple_positive is defined in dcache.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if __GFP_RECLAIM is defined])
	LB_LINUX_TRY_COMPILE([
		#include <linux/gfp.h>
	],[
		gfp_t rc = __GFP_RECLAIM;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GFP_RECLAIM, 1,
			[__GFP_RECLAIM is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has napi_schedule_irqoff])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		napi_schedule_irqoff(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NAPI_SCHEDULE_IRQOFF, 1,
			  [napi_schedule_irqoff is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h has dev_alloc_pages])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		dev_alloc_pages(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DEV_ALLOC_PAGES, 1,
			  [dev_alloc_pages is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h has napi_alloc_skb])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		napi_alloc_skb(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NAPI_ALLOC_SKB, 1,
			  [napi_alloc_skb is defined])
	],[
		AC_MSG_RESULT(no)
	])

    AC_MSG_CHECKING([if netlink.h has netlink_capable])
    LB_LINUX_TRY_COMPILE([
            #include <linux/netlink.h>
    ],[
            bool b = netlink_capable(NULL, 0);

            return 0;
    ],[
            AC_MSG_RESULT(yes)
            AC_DEFINE(HAVE_NETLINK_CAPABLE, 1,
                      [netlink_capable is defined])
    ],[
            AC_MSG_RESULT(no)
    ])

	AC_MSG_CHECKING([if netlink.h netlink_skb_parms has sk])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netlink.h>
	],[
		struct netlink_skb_parms nsp = {
			.sk = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETLINK_SKB_PARMS_SK, 1,
			  [netlink_skb_params has sk])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if etherdevice.h has ether_addr_copy])
	LB_LINUX_TRY_COMPILE([
		#include <linux/etherdevice.h>
	],[
		ether_addr_copy(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ETHER_ADDR_COPY, 1,
			  [ether_addr_copy is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct dcbnl_rtnl_ops has get/set ets and dcbnl defined])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>
	],[
		const struct dcbnl_rtnl_ops en_dcbnl_ops = {
			.ieee_getets = NULL,
			.ieee_setets = NULL,
		};

		struct net_device dev = {
			.dcbnl_ops = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IEEE_DCBNL_ETS, 1,
			  [ieee_getets/ieee_setets is defined and dcbnl defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kernel.h has reciprocal_scale])
	LB_LINUX_TRY_COMPILE([
		#include <linux/kernel.h>
	],[
		reciprocal_scale(0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RECIPROCAL_SCALE, 1,
			  [reciprocal_scale is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if libiscsi.h struct iscsi_session has member discovery_sess])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/libiscsi.h>
	],[
		struct iscsi_session iscsi_sess = {
			.discovery_sess = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DISCOVERY_SESSION, 1,
			  [discovery_sess is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if iscsi_proto.h has structure iscsi_cmd])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/iscsi_proto.h>
	],[
		struct iscsi_cmd hdr;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSI_CMD, 1,
			  [iscsi_proto.h has structure iscsi_cmd])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h struct scsi_device has u64 lun])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		struct scsi_device sdev = {
			.lun = 0,
		};

		pr_err("lun %llu", sdev.lun);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_DEVICE_U64_LUN, 1,
			  [scsi_device.h struct scsi_device has u64 lun])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_transport_iscsi.h struct iscsi_transport has member check_protection])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_transport_iscsi.h>
	],[
		struct iscsi_transport iscsi_iser_transport = {
			.check_protection = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSI_TRANSPORT_CHECK_PROTECTION, 1,
			  [check_protection is defined])
	],[
		AC_MSG_RESULT(no)
	])

    AC_MSG_CHECKING([if iscsi_transport.h struct iscsit_transport has member iscsit_get_sup_prot_ops])
	LB_LINUX_TRY_COMPILE([
		#include <target/iscsi/iscsi_transport.h>

		enum target_prot_op get_sup_prot_ops(struct iscsi_conn *conn)
		{
			return 0;
		}

	],[
		struct iscsit_transport it = {
			.iscsit_get_sup_prot_ops = get_sup_prot_ops,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ISCSIT_TRANSPORT_HAS_GET_SUP_PROT_OPS, 1,
			[iscsit_transport has member iscsit_get_sup_prot_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if highmem.h has kmap_atomic function with km_type])
	LB_LINUX_TRY_COMPILE([
		#include <linux/highmem.h>
	],[
		kmap_atomic(NULL, KM_USER0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_KM_TYPE, 1,
			  [highmem.h has kmap_atomic function with km_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has flag QUEUE_FLAG_SG_GAPS])
	LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int flag = QUEUE_FLAG_SG_GAPS;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_QUEUE_FLAG_SG_GAPS, 1,
			[blkdev.h has flag QUEUE_FLAG_SG_GAPS])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has scsi_change_queue_depth])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		scsi_change_queue_depth(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_CHANGE_QUEUE_DEPTH, 1,
			[scsi_change_queue_depth exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_cmnd.h struct scsi_cmnd  has member prot_flags])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_cmnd.h>
	],[
		struct scsi_cmnd sc = {
			.prot_flags = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_CMND_PROT_FLAGS, 1,
			[scsi_cmnd has members prot_flags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member change_queue_type])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.change_queue_type = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_CHANGE_QUEUE_TYPE, 1,
			[scsi_host_template has members change_queue_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member use_blk_tags])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.use_blk_tags = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_USE_BLK_TAGS, 1,
			[scsi_host_template has members use_blk_tags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member use_host_wide_tags])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.use_host_wide_tags = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_USE_HOST_WIDE_TAGS, 1,
			[scsi_host_template has members use_host_wide_tags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct Scsi_Host has member use_blk_mq])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct Scsi_Host sh = {
			.use_blk_mq = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_HOST_USE_BLK_MQ, 1,
				[Scsi_Host has members use_blk_mq])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_tcq.h has function scsi_change_queue_type])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_tcq.h>
	],[
		scsi_change_queue_type(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_TCQ_SCSI_CHANGE_QUEUE_TYPE, 1,
			[scsi_tcq.h has function scsi_change_queue_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_tcq.h has function scsi_init_shared_tag_map])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_tcq.h>
	],[
		scsi_init_shared_tag_map(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_TCQ_SCSI_INIT_SHARED_TAG_MAP, 1,
			[scsi_tcq.h has function scsi_init_shared_tag_map])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_transfer_length is defind])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_cmnd.h>
	],[
		scsi_transfer_length(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_TRANSFER_LENGTH, 1,
			  [scsi_transfer_length is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if MIN_NICE is defined in prio.h])
	LB_LINUX_TRY_COMPILE([
		#include <linux/sched/prio.h>
	],[
		long nice = MIN_NICE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_MIN_NICE, 1,
			[MIN_NICE is defined in prio.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if has netdev_notifier_info_to_dev])
	LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		return netdev_notifier_info_to_dev(NULL) ? 1 : 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_NOTIFIER_INFO_TO_DEV, 1,
			[netdev_notifier_info_to_dev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has struct netdev_notifier_info])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_notifier_info x = {
			.dev = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_NOTIFIER_INFO, 1,
			  [struct netdev_notifier_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has register_netdevice_notifier_rh])
	LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		return register_netdevice_notifier_rh(NULL);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_REGISTER_NETDEVICE_NOTIFIER_RH, 1,
			[register_netdevice_notifier_rh is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if has pci_is_bridge])
	LB_LINUX_TRY_COMPILE([
	#include <linux/pci.h>
	],[
		return pci_is_bridge(NULL);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCI_IS_BRIDGE, 1,
			[pci_is_bridge is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ifla_vf_info has vlan_proto])
	LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		struct ifla_vf_info *ivf;

		ivf->vlan_proto = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VF_VLAN_PROTO, 1,
			  [vlan_proto is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if alloc_etherdev_mq is defined])
	LB_LINUX_TRY_COMPILE([
		#include <linux/etherdevice.h>
	],[
		alloc_etherdev_mq(0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ALLOC_ETHERDEV_MQ, 1,
			  [alloc_etherdev_mq is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_get_phys_port_name])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops ndops = {
			.ndo_get_phys_port_name = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_GET_PHYS_PORT_NAME, 1,
			  [ndo_get_phys_port_name is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_set_vf_vlan])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops = {
			.ndo_set_vf_vlan = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SET_VF_VLAN, 1,
			  [ndo_set_vf_vlan is defined in net_device_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_change_mtu_rh74])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops = {
			.ndo_change_mtu_rh74 = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_CHANGE_MTU_RH74, 1,
			  [ndo_change_mtu_rh74 is defined in net_device_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has ndo_set_vf_vlan])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended netdev_ops_extended = {
			.ndo_set_vf_vlan = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SET_VF_VLAN_EXTENDED, 1,
			  [ndo_set_vf_vlan is defined in net_device_ops_extended])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_ext has ndo_set_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_ext netdev_ops_ext;

		netdev_ops_ext.ndo_set_features = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_OPS_EXT_NDO_SET_FEATURES, 1,
			  [ndo_set_features is defined in net_device_ops_ext])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_ext has ndo_fix_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_ext netdev_ops_ext;

		netdev_ops_ext.ndo_fix_features = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_OPS_EXT_NDO_FIX_FEATURES, 1,
			  [ndo_fix_features is defined in net_device_ops_ext])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_set_real_num_tx_queues])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device dev;
		netif_set_real_num_tx_queues(&dev, 2);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_SET_REAL_NUM_TX_QUEUES, 1,
			  [netif_set_real_num_tx_queues is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h get_user_pages has 8 params])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages(NULL, NULL, 0, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_USER_PAGES_8_PARAMS, 1,
			[get_user_pages has 8 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if get_user_pages uses gup flags])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		unsigned long start;
		unsigned long nr_pages;
		unsigned int gup_flags;
		struct page **page_list;
		struct vm_area_struct **vmas;
		int ret;

		ret = get_user_pages(start, nr_pages, gup_flags, page_list,
					vmas);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_USER_PAGES_GUP_FLAGS, 1,
			[get_user_pages uses gup_flags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm has get_user_pages_remote with 7 parameters])
	LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
	],[
		get_user_pages_remote(NULL, NULL, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_USER_PAGES_REMOTE_7_PARAMS, 1,
			[get_user_pages_remote is defined with 7 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm has get_user_pages_remote with 8 parameters])
	LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
	],[
		get_user_pages_remote(NULL, NULL, 0, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_USER_PAGES_REMOTE_8_PARAMS, 1,
			[get_user_pages_remote is defined with 8 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm has get_user_pages_remote with 8 parameters with locked])
	LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
	],[
		get_user_pages_remote(NULL, NULL, 0, 0, 0, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_USER_PAGES_REMOTE_8_PARAMS_W_LOCKED, 1,
			[get_user_pages_remote is defined with 8 parameters with locked])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops has *ndo_get_stats64 that returns void])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		void get_stats_64(struct net_device *dev,
						  struct rtnl_link_stats64 *storage)
		{
			return;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_get_stats64 = get_stats_64;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_GET_STATS64_RET_VOID, 1,
			  [ndo_get_stats64 is defined and returns void])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has function scsi_internal_device_block])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		scsi_internal_device_block(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_DEVICE_SCSI_INTERNAL_DEVICE_BLOCK, 1,
			[scsi_device.h has function scsi_internal_device_block])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has max_mtu])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		dev->max_mtu = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_MAX_MTU, 1,
			  [max_mtu is in struct net_device])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/sched/task.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/sched/task.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_LINUX_SCHED_TASK_H, 1,
			  [linux/sched/task.h is exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h has struct netlink_ext_ack])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netlink.h>
	],[
		struct netlink_ext_ack x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETLINK_EXT_ACK, 1,
			  [struct netlink_ext_ack is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if device.h struct device has dma_ops])
	LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>
	],[
		struct device devx = {
			.dma_ops = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DEVICE_DMA_OPS, 1,
			  [struct device has dma_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rtnetlink.h has net_rwsem])
	LB_LINUX_TRY_COMPILE([
		#include <linux/rtnetlink.h>
		#include <linux/rwsem.h>
	],[
		down_read(&net_rwsem);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_RWSEM, 1,
			[ net_rwsem is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h nla_parse takes 6 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nla_parse(NULL, 0, NULL, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NLA_PARSE_6_PARAMS, 1,
			  [nla_parse takes 6 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/netlink.h has nla_put_u64_64bit])
	LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nla_put_u64_64bit(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NLA_PUT_U64_64BIT, 1,
			  [nla_put_u64_64bit is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/sched/task.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/sched/task.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCHED_TASK_H, 1,
			  [linux/sched/task.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/mm.h has get_user_pages_longterm])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages_longterm(0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_USER_PAGES_LONGTERM, 1,
			[get_user_pages_longterm is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rt6_lookup has 6 params])
	LB_LINUX_TRY_COMPILE([
		#include <net/ip6_route.h>
	],[
		rt6_lookup(NULL, NULL, NULL, 0, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RT6_LOOKUP_6_PARAMS, 1,
			  [rt6_lookup has 6 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has *ndo_chane_mtu_extended])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended x = {
			.ndo_change_mtu = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_CHANGE_MTU_EXTENDED, 1,
			  [extended ndo_change_mtu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dst.h has dst_get_neighbour])
	LB_LINUX_TRY_COMPILE([
		#include <net/dst.h>
	],[
		struct neighbour *neigh = dst_get_neighbour(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DST_GET_NEIGHBOUR, 1,
			  [dst_get_neighbour is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dst.h has skb_dst_update_pmtu])
	LB_LINUX_TRY_COMPILE([
		#include <net/dst.h>
	],[
		struct sk_buff x;
		skb_dst_update_pmtu(&x, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SKB_DST_UPDATE_PMTU, 1,
			  [skb_dst_update_pmtu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dst.h has dst_neigh_lookup])
	LB_LINUX_TRY_COMPILE([
		#include <net/dst.h>
	],[
		struct neighbour *neigh = dst_neigh_lookup(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DST_NEIGH_LOOKUP, 1,
			  [dst_neigh_lookup is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dst_ops.h update_pmtu has 4 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
		#include <net/dst_ops.h>

		static void mtu_up (struct dst_entry *dst, struct sock *sk,
				    struct sk_buff *skb, u32 mtu)
		{
			return;
		}
	],[
		struct dst_ops x = {
			.update_pmtu = mtu_up,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_UPDATE_PMTU_4_PARAMS, 1,
			  [update_pmtu has 4 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rtnetlink.h rtnl_link_ops newlink has 4 paramters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/rtnetlink.h>

		static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
						struct nlattr *tb[], struct nlattr *data[])
		{
			return 0;
		}
	],[
		struct rtnl_link_ops x = {
			.newlink = ipoib_new_child_link,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RTNL_LINK_OPS_NEWLINK_4_PARAMS, 1,
			  [newlink has 4 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rtnetlink.h rtnl_link_ops newlink has 5 paramters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/rtnetlink.h>

		static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
										struct nlattr *tb[], struct nlattr *data[],
										struct netlink_ext_ack *extack)
		{
			return 0;
		}
	],[
		struct rtnl_link_ops x = {
			.newlink = ipoib_new_child_link,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RTNL_LINK_OPS_NEWLINK_5_PARAMS, 1,
			  [newlink has 5 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rtnetlink.h rtnl_link_ops dellink newlink has 2 paramters])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/rtnetlink.h>

		static void ipoib_unregister_child_dev(struct net_device *dev, struct list_head *head)
		{
			return;
		}
	],[
		struct rtnl_link_ops x = {
			.dellink = ipoib_unregister_child_dev,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_RTNL_LINK_OPS_DELLINK_2_PARAMS, 1,
			  [dellink has 2 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if argument 3 of config_group_init_type_name should const])
	LB_LINUX_TRY_COMPILE([
		#include <linux/configfs.h>

		static const struct config_item_type cma_port_group_type = {
			.ct_attrs	= cma_configfs_attributes,
		};

	],[
		config_group_init_type_name(NULL,
					    NULL,
					    &cma_port_group_type);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(CONFIG_GROUP_INIT_TYPE_NAME_PARAM_3_IS_CONST, 1,
			[argument 3 of config_group_init_type_name should const])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if timer.h has timer_setup])
	LB_LINUX_TRY_COMPILE([
		#include <linux/timer.h>

		static void activate_timeout_handler_task(struct timer_list *t)
		{
			return;
		}
	],[
		struct timer_list tmr;
		timer_setup(&tmr, activate_timeout_handler_task, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TIMER_SETUP, 1,
			[timer_setup is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pci.h has pcie_get_minimum_link])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pcie_print_link_status(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCIE_PRINT_LINK_STATUS, 1,
			  [pcie_print_link_status is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr.h has ida_is_empty])
	LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		struct ida ida;
		ida_is_empty(&ida);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IDA_IS_EMPTY, 1,
			  [ida_is_empty is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr.h has idr_is_empty])
	LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		struct ida ida;
		idr_is_empty(&ida.idr);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IDR_IS_EMPTY, 1,
			  [idr_is_empty is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h exist])
	LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_XDP_H, 1,
			  [net/xdp.h exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_dim.h exist])
	LB_LINUX_TRY_COMPILE([
		#include <linux/net_dim.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DIM_H, 1,
			  [linux/net_dim.h exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has TC_SETUP_QDISC_MQPRIO])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		enum tc_setup_type x = TC_SETUP_QDISC_MQPRIO;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_SETUP_QDISC_MQPRIO, 1,
			  [TC_SETUP_QDISC_MQPRIO is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has TC_SETUP_BLOCK])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		enum tc_setup_type x = TC_SETUP_BLOCK;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_SETUP_BLOCK, 1,
			  [TC_SETUP_BLOCK is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netdev_xdp exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_xdp xdp;
		xdp = xdp;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_XDP, 1,
			  [struct netdev_xdp is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct xdp_rxq_info exists])
	LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_rxq_info xdp_rxq_inf;
		xdp_rxq_inf = xdp_rxq_inf;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_XDP_RXQ_INFO, 1,
			  [struct xdp_rxq_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has min/max])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		dev->min_mtu = 0;
		dev->max_mtu = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_MIN_MAX_MTU, 1,
			  [net_device min/max is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_extended has min/max_mtu])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_extended x = {
			.min_mtu = 0,
			.max_mtu = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NET_DEVICE_MIN_MAX_MTU_EXTENDED, 1,
			  [extended min/max_mtu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netdev_bpf exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_bpf nbpf;
		nbpf = nbpf;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_BPF, 1,
			  [struct netdev_bpf is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan have ndo_add_vxlan_port])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		#if IS_ENABLED(CONFIG_VXLAN)
		void add_vxlan_port(struct net_device *dev, sa_family_t sa_family, __be16 port)
		{
			return;
		}
		#endif
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_add_vxlan_port = add_vxlan_port;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_ADD_VXLAN_PORT, 1,
			[ndo_add_vxlan_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if function pcie_bandwidth_available exist])
	LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pcie_bandwidth_available(NULL, NULL, NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PCIE_BANDWIDTH_AVAILABLE, 1,
			  [function pcie_bandwidth_available is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bpf.h bpf_prog_aux has feild id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
	],[
		struct bpf_prog_aux x = {
			.id = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BPF_PROG_AUX_FEILD_ID, 1,
			  [bpf_prog_aux has feild id])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has set_dump])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_ops x = {
			.set_dump = NULL,
			.get_dump_data = NULL,
			.get_dump_flag = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_DUMP, 1,
			[HAVE_GET_SET_DUMP is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_flags])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_flags = NULL,
			.set_flags = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_FLAGS, 1,
			  [get/set_flags is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_link_ksettings])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_link_ksettings = NULL,
			.set_link_ksettings = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_LINK_KSETTINGS, 1,
			  [get/set_link_ksettings is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_msglevel])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_msglevel = NULL,
			.set_msglevel = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_MSGLEVEL, 1,
			  [get/set_msglevel is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_rx_csum])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_rx_csum = NULL,
			.set_rx_csum = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_RX_CSUM, 1,
			  [get/set_rx_csum is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_sg])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_sg = NULL,
			.set_sg = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_SG, 1,
			  [get/set_sg is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_tso])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_tso = NULL,
			.set_tso = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_TSO, 1,
			  [get/set_tso is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_tx_csum])
	LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_tx_csum = NULL,
			.set_tx_csum = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_SET_TX_CSUM, 1,
			  [get/set_tx_csum is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kthread.h has kthread_queue_work])
	LB_LINUX_TRY_COMPILE([
		#include <linux/kthread.h>
	],[
		kthread_queue_work(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_KTHREAD_QUEUE_WORK, 1,
			  [kthread_queue_work is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_get_offload_stats defined])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx5e_get_offload_stats(int attr_id, const struct net_device *dev,
									void *sp)
		{
			return 0;
		}
	],[
		struct net_device_ops ndops = {
			.ndo_get_offload_stats = mlx5e_get_offload_stats,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_GET_OFFLOAD_STATS, 1,
			  [ndo_get_offload_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has ndo_get_offload_stats])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx5e_get_offload_stats(int attr_id, const struct net_device *dev,
									void *sp)
		{
			return 0;
		}
	],[
		struct net_device_ops_extended ndops = {
			.ndo_get_offload_stats = mlx5e_get_offload_stats,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_GET_OFFLOAD_STATS_EXTENDED, 1,
			  [extended ndo_get_offload_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_extended has ndo_has_offload_stats])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		bool mlx5e_has_offload_stats(const struct net_device *dev, int attr_id)
		{
			return true;
		}
	],[
		struct net_device_ops_extended ndops = {
			.ndo_has_offload_stats = mlx5e_has_offload_stats,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_HAS_OFFLOAD_STATS_EXTENDED, 1,
			  [ndo_has_offload_stats gets net_device])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has *ndo_set_tx_maxrate])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended x = {
			.ndo_set_tx_maxrate = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SET_TX_MAXRATE_EXTENDED, 1,
			  [extended ndo_set_tx_maxrate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has  has *ndo_setup_tc_rh])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended x = {
			.ndo_setup_tc_rh = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SETUP_TC_RH_EXTENDED, 1,
			  [ndo_setup_tc_rh is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_setup_tc takes chain_index])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx_en_setup_tc(struct net_device *dev, u32 handle, u32 chain_index,
							__be16 protocol, struct tc_to_netdev *tc)
		{
			return 0;
		}
	],[
		struct net_device_ops x = {
			.ndo_setup_tc = mlx_en_setup_tc,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SETUP_TC_TAKES_CHAIN_INDEX, 1,
			  [ndo_setup_tc takes chain_index])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_setup_tc takes tc_setup_type])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx_en_setup_tc(struct net_device *dev, enum tc_setup_type type,
				    void *type_data)
		{
			return 0;
		}
	],[
		struct net_device_ops x = {
			.ndo_setup_tc = mlx_en_setup_tc,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_SETUP_TC_TAKES_TC_SETUP_TYPE, 1,
			  [ndo_setup_tc takes tc_setup_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has ndo_udp_tunnel_add])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		#if IS_ENABLED(CONFIG_VXLAN)
		void add_vxlan_port(struct net_device *dev, struct udp_tunnel_info *ti)
		{
			return;
		}
		#endif

	],[
		struct net_device_ops_extended x = {
			.ndo_udp_tunnel_add = add_vxlan_port,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_UDP_TUNNEL_ADD_EXTENDED, 1,
			[extended ndo_add_vxlan_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_extended has ndo_set_vf_trust])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_trust(struct net_device *dev, int vf, bool setting)
		{
			return 0;
		}
	],[
		struct net_device_ops_extended netdev_ops;

		netdev_ops.ndo_set_vf_trust = set_vf_trust;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_OPS_NDO_SET_VF_TRUST_EXTENDED, 1,
			  [extended ndo_set_vf_trust is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_is_rxfh_configured])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_is_rxfh_configured(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_IS_RXFH_CONFIGURED, 1,
			  [netif_is_rxfh_configured is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pat.h has pat_enabled as a function])
	LB_LINUX_TRY_COMPILE([
		#include <asm/pat.h>
	],[
		bool px = pat_enabled();

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_PAT_ENABLED_AS_FUNCTION, 1,
			  [pat.h has pat_enabled as a function])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_block_offload exists])
	LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_block_offload x;
		x = x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_BLOCK_OFFLOAD, 1,
			  [struct tc_block_offload is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if act_apt.h tc_setup_cb_egdev_register])
	LB_LINUX_TRY_COMPILE([
		#include <net/act_api.h>
	],[
		tc_setup_cb_egdev_register(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_SETUP_CB_EGDEV_REGISTER, 1,
			  [tc_setup_cb_egdev_register is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_set_vf_tx_rate])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops ndops = {
			.ndo_set_vf_tx_rate = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VF_TX_RATE, 1,
			  [ndo_set_vf_tx_rate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if route.h has ip4_dst_hoplimit])
	LB_LINUX_TRY_COMPILE([
		#include <net/route.h>
	],[
		ip4_dst_hoplimit(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IP4_DST_HOPLIMIT, 1,
		[ip4_dst_hoplimit is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([irq_to_desc],
		[kernel/irq/irqdesc.c],
		[AC_DEFINE(HAVE_IRQ_TO_DESC_EXPORTED, 1,
			[irq_to_desc is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if struct net_device_ops_extended has ndo_xdp])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended netdev_ops_extended = {
			.ndo_xdp = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_XDP_EXTENDED, 1,
			  [extended ndo_xdp is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_features.h has NETIF_F_RXALL])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdev_features.h>
	],[
		netdev_features_t rxfcs = NETIF_F_RXALL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_F_RXALL, 1,
			[NETIF_F_RXALL is defined in netdev_features.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_features.h has NETIF_F_RXFCS])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdev_features.h>
	],[
		netdev_features_t rxfcs = NETIF_F_RXFCS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETIF_F_RXFCS, 1,
			[NETIF_F_RXFCS is defined in netdev_features.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan.h has vxlan_features_check])
	LB_LINUX_TRY_COMPILE([
		#include <net/vxlan.h>
	],[
		vxlan_features_check(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_VXLAN_FEATURES_CHECK, 1,
			  [vxlan_features_check is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tcp.h tcp_parse_options has 5 parameters])
	LB_LINUX_TRY_COMPILE([
		#include <net/tcp.h>
	],[
		tcp_parse_options(NULL, NULL, NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TCP_PARSE_OPTIONS_5_PARAMETERS, 1,
			  [tcp_parse_options_5_parameters is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/pkt_cls.h has tc_cls_can_offload_and_chain0])
	LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tc_cls_can_offload_and_chain0(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_CLS_CAN_OFFLOAD_AND_CHAIN0, 1,
			  [tc_cls_can_offload_and_chain0 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/rhashtable.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <linux/rhashtable.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_LINUX_RHASHTABLE_H, 1,
			  [linux/rhashtable.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_mirred.h has tcf_mirred_dev])
	LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		tcf_mirred_dev(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TCF_MIRRED_DEV, 1,
			  [tcf_mirred_dev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_gact.h has is_tcf_gact_ok])
	LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_gact.h>
	],[
		is_tcf_gact_ok(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_IS_TCF_GACT_OK, 1,
			  [is_tcf_gact_ok is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h has build_skb])
	LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		 build_skb(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BUILD_SKB, 1,
			  [build_skb is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/devlink.h exists])
	LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DEVLINK_H, 1,
			  [include/net/devlink.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_extended has ndo_get_phys_port_id])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int get_phys_port_name(struct net_device *dev,
				       char *name, size_t len)
		{
			return 0;
		}
	],[
		struct net_device_ops_extended netdev_ops;

		netdev_ops.ndo_get_phys_port_name = get_phys_port_name;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_GET_PHYS_PORT_NAME_EXTENDED, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops ndo_vlan_rx_add_vid has 2 parameters and returns int])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int vlan_rx_add_vid(struct net_device *dev, u16 vid)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops = {
			.ndo_vlan_rx_add_vid = vlan_rx_add_vid,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NDO_RX_ADD_VID_HAS_2_PARAMS_RET_INT, 1,
			  [ndo_vlan_rx_add_vid has 2 parameters and returns int])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_extended has wanted_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		netdev_extended(dev)->wanted_features = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_EXTENDED_WANTED_FEATURES, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has IFF_UNICAST_FLT])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		int x = IFF_UNICAST_FLT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_IFF_UNICAST_FLT, 1,
			  [IFF_UNICAST_FLT is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has wanted_features])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device dev;
		dev.wanted_features = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_WANTED_FEATURES, 1,
			  [wanted_features is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dcbnl.h has struct ieee_pfc])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>
	],[
		struct ieee_pfc x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_STRUCT_IEEE_PFC, 1,
			  [ieee_pfc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_to_netdev has egress_dev])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct tc_to_netdev x = {
			.egress_dev = false,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_TO_NETDEV_EGRESS_DEV, 1,
			  [struct tc_to_netdev has egress_dev])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_to_netdev has tc])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct tc_to_netdev x;
		x.tc = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TC_TO_NETDEV_TC, 1,
			  [struct tc_to_netdev has tc])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bpf_trace has trace_xdp_exception])
	LB_LINUX_TRY_COMPILE([
		#include <linux/bpf_trace.h>
	],[
		trace_xdp_exception(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TRACE_XDP_EXCEPTION, 1,
			  [trace_xdp_exception is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if filter.h has struct xdp_buff])
	LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		struct xdp_buff d = {
			.data = NULL,
			.data_end = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_XDP_BUFF, 1,
			  [xdp is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if filter.h struct xdp_buff has data_hard_start])
	LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		struct xdp_buff d = {
			.data_hard_start = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_XDP_BUFF_DATA_HARD_START, 1,
			  [xdp_buff data_hard_start is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if filter.h has xdp_set_data_meta_invalid])
	LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		struct xdp_buff d;
		xdp_set_data_meta_invalid(&d);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_XDP_SET_DATA_META_INVALID, 1,
			  [xdp_set_data_meta_invalid is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bpf.h has bpf_prog_sub])
	LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
	],[
		bpf_prog_sub(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BPF_PROG_SUB, 1,
			  [bpf_prog_sub is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has enum netdev_lag_tx_type])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		enum netdev_lag_tx_type x;
		x = 0;

		return x;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_LAG_TX_TYPE, 1,
			  [enum netdev_lag_tx_type is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_reg_state])
	LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_reg_state(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_NETDEV_REG_STATE, 1,
			  [netdev_reg_state is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([bpf_prog_inc],
		[kernel/bpf/syscall.c],
		[AC_DEFINE(HAVE_BPF_PROG_INC_EXPORTED, 1,
			[bpf_prog_inc is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if linux/inet.h inet_pton_with_scope])
	LB_LINUX_TRY_COMPILE([
		#include <linux/inet.h>
	],[
		inet_pton_with_scope(NULL, 0, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_INET_PTON_WITH_SCOPE, 1,
			[inet_pton_with_scope is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has blist_flags_t])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
    ],[
		blist_flags_t x = 0;

		return 0;
    ],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_BLIST_FLAGS_T, 1,
			[blist_flags_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h struct scsi_device has member state_mutex])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mutex.h>
		#include <scsi/scsi_device.h>
	],[
		struct scsi_device sdev;
		mutex_init(&sdev.state_mutex);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_SCSI_DEVICE_STATE_MUTEX, 1,
			  [scsi_device.h struct scsi_device has member state_mutex])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has enum scsi_scan_mode])
	LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		enum scsi_scan_mode xx = SCSI_SCAN_INITIAL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_ENUM_SCSI_SCAN_MODE, 1,
			  [enum scsi_scan_mode is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([kobj_ns_drop],
		[lib/kobject.c],
		[AC_DEFINE(HAVE_KOBJ_NS_DROP_EXPORTED, 1,
			[kobj_ns_drop is exported by the kernel])],
	[])
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
