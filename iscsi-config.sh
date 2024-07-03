#!/bin/bash

# Start dbus service
service dbus start

# Ensure the directory exists
mkdir -p /var/lib/iscsi_disks

# Configure iSCSI target
targetcli /backstores/fileio create name=disk1 file_or_dev=/var/lib/iscsi_disks/disk1.img size=10G
targetcli /iscsi create
targetcli /iscsi/iqn.2003-01.org.linux-iscsi.ubuntu24-platform.x8664:sn.3088098c87b7/tpg1/luns create /backstores/fileio/disk1
targetcli /iscsi/iqn.2003-01.org.linux-iscsi.ubuntu24-platform.x8664:sn.3088098c87b7/tpg1/acls create iqn.2024-07.com.badis:initiator
targetcli saveconfig

# Keep the container running
tail -f /dev/null
