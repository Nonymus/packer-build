#!/bin/sh

# Clean apt gubbins
apt-get -y autoremove --purge
apt-get clean
rm -rv /var/lib/apt/lists/*

# Clear and regenrate host keys
rm -v /etc/ssh/ssh_host_*
sed -i 's/exit 0//g' /etc/rc.local
cat >>/etc/rc.local <<EOF
test -f /etc/ssh/ssh_host_rsa_key || dpkg-reconfigure openssh-server
exit 0
EOF

# Zero unused disk space
dd if=/dev/zero of=/ZEROFILL || true
rm /ZEROFILL
sync
