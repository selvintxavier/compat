#include <linux/slab.h>
#include <linux/kernel.h>
#include <linux/bitops.h>
#include <linux/cpumask.h>
#include <linux/export.h>
#include <linux/bootmem.h>

/**
 * cpumask_set_cpu_local_first - set i'th cpu with local numa cpu's first
 *
 * @i: index number
 * @numa_node: local numa_node
 * @dstp: cpumask with the relevant cpu bit set according to the policy
 *
 * This function sets the cpumask according to a numa aware policy.
 * cpumask could be used as an affinity hint for the IRQ related to a
 * queue. When the policy is to spread queues across cores - local cores
 * first.
 *
 * Returns 0 on success, -ENOMEM for no memory, and -EAGAIN when failed to set
 * the cpu bit and need to re-call the function.
 */
#define cpumask_set_cpu_local_first LINUX_BACKPORT(cpumask_set_cpu_local_first)
int cpumask_set_cpu_local_first(int i, int numa_node, cpumask_t *dstp)
{
	cpumask_var_t mask;
	int cpu;
	int ret = 0;

	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
		return -ENOMEM;

	i %= num_online_cpus();

	if (numa_node == -1 || !cpumask_of_node(numa_node)) {
		/* Use all online cpu's for non numa aware system */
		cpumask_copy(mask, cpu_online_mask);
	} else {
		int n;

		cpumask_and(mask,
			    cpumask_of_node(numa_node), cpu_online_mask);

		n = cpumask_weight(mask);
		if (i >= n) {
			i -= n;

			/* If index > number of local cpu's, mask out local
			 * cpu's
			 */
			cpumask_andnot(mask, cpu_online_mask, mask);
		}
	}

	for_each_cpu(cpu, mask) {
		if (--i < 0)
			goto out;
	}

	ret = -EAGAIN;

out:
	free_cpumask_var(mask);

	if (!ret)
		cpumask_set_cpu(cpu, dstp);

	return ret;
}
EXPORT_SYMBOL(cpumask_set_cpu_local_first);

static int __hw_addr_del_entry(struct netdev_hw_addr_list *list,
                               struct netdev_hw_addr *ha, bool global,
                               bool sync)
{
        if (global && !ha->global_use)
                return -ENOENT;

        if (sync && !ha->synced)
                return -ENOENT;

        if (global)
                ha->global_use = false;

        if (sync)
                ha->synced--;

        if (--ha->refcount)
                return 0;
        list_del_rcu(&ha->list);
        kfree_rcu(ha, rcu_head);
        list->count--;
        return 0;
}

/**
 *  __hw_addr_sync_dev - Synchonize device's multicast list
 *  @list: address list to syncronize
 *  @dev:  device to sync
 *  @sync: function to call if address should be added
 *  @unsync: function to call if address should be removed
 *
 *  This funciton is intended to be called from the ndo_set_rx_mode
 *  function of devices that require explicit address add/remove
 *  notifications.  The unsync function may be NULL in which case
 *  the addresses requiring removal will simply be removed without
 *  any notification to the device.
 **/
#define __hw_addr_sync_dev LINUX_BACKPORT(__hw_addr_sync_dev)
int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
                       struct net_device *dev,
                       int (*sync)(struct net_device *, const unsigned char *),
                       int (*unsync)(struct net_device *,
                                     const unsigned char *))
{
        struct netdev_hw_addr *ha, *tmp;
        int err;

        /* first go through and flush out any stale entries */
        list_for_each_entry_safe(ha, tmp, &list->list, list) {
                if (!ha->sync_cnt || ha->refcount != 1)
                        continue;

                /* if unsync is defined and fails defer unsyncing address */
                if (unsync && unsync(dev, ha->addr))
                        continue;

                ha->sync_cnt--;
                __hw_addr_del_entry(list, ha, false, false);
        }

        /* go through and sync new entries to the list */
        list_for_each_entry_safe(ha, tmp, &list->list, list) {
                if (ha->sync_cnt)
                        continue;

                err = sync(dev, ha->addr);
                if (err)
                        return err;

                ha->sync_cnt++;
                ha->refcount++;
        }

        return 0;
}
EXPORT_SYMBOL(__hw_addr_sync_dev);
