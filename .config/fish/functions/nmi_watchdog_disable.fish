function nmi_watchdog_disable
	sudo bash -c "echo 0 > /proc/sys/kernel/nmi_watchdog"
end
