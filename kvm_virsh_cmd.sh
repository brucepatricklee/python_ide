
DOWNLOAD_SERVER_CN=10.66.4.123
DOWNLOAD_SERVER_US=10.12.0.20

# get guest rhel7 os image
wget http://$DOWNLOAD_SERVER_CN/libvirt-CI-resources/RHEL-7.6-x86_64-latest.qcow2 -O $HOME/Download/rhel76-x86_64.qcow2

# get guest rhel8 os image
wget http://$DOWNLOAD_SERVER_CN/libvirt-CI-resources/RHEL-8.0-x86_64-latest.qcow2 -O $HOME/Download/rhel80-x86_64.qcow2

# kvm guest os name - avocado-vt-vm1



