set -xe
export PROXMOX_DEBUG=debug
/usr/libexec/proxmox/proxmox-datacenter-privileged-api setup
/usr/libexec/proxmox/proxmox-datacenter-privileged-api & 
sleep 3
chown -R www-data /var/log/proxmox-datacenter-manager
chown -R www-data /var/lib/proxmox-datacenter-manager
/usr/sbin/runuser -u www-data -g www-data /usr/libexec/proxmox/proxmox-datacenter-api & 
F=$(openssl x509 -noout -fingerprint -sha256 -inform pem -in /etc/proxmox-datacenter-manager/auth/api.pem  |sed s/"sha256 Fingerprint="//g | sed s/://g |tr '[:upper:]' '[:lower:]')
mkdir -p /root/.cache/proxmox-datacenter-client
echo "localhost $F" > /root/.cache/proxmox-datacenter-client/fingerprints
proxmox-datacenter-manager-client login --host localhost --user root@pam
proxmox-datacenter-manager-client user passwd root@pam --password proxmox
tail -f /dev/null
