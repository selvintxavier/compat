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

	AC_MSG_CHECKING([if mm.h get_user_pages has 6 params])
	LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages(0, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_GET_USER_PAGES_6_PARAMS, 1,
			  [get_user_pages has 6 params])
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
