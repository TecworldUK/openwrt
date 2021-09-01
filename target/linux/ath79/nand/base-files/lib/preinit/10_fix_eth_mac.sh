. /lib/functions.sh
. /lib/functions/system.sh

preinit_set_mac_address() {
	case $(board_name) in
	zyxel,nbg6716)
		ethaddr=$(mtd_get_mac_ascii u-boot-env ethaddr)
		ip link set dev eth0 address $(macaddr_add $ethaddr 2)
		ip link set dev eth1 address $(macaddr_add $ethaddr 3)
		;;
	meraki,mr18)
		ethaddr=$(mtd_get_mac_binary_ubi board-config 102)
		[ -n "$ethaddr" ] && ip link set dev eth0 address $(macaddr_add $ethaddr)
		;;
	esac
}

boot_hook_add preinit_main preinit_set_mac_address
