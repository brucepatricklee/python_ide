# run as root
yum install -y git tcpdump tar attr

# for rhel7
# config rhel7 repo

yum install -y gcc make patch openssl gdbm-devel openssl-devel sqlite-devel readline-devel zlib zlib-devel bzip2-devel python-devel ncurses-devel.x86_64


# for rhel8
# config rhel8 repo

yum install -y gcc make patch openssl gdbm-devel openssl-devel sqlite-devel readline-devel zlib zlib-devel bzip2-devel platform-python-devel ncurses-devel.x86_64

# enable intel_iommu in grub2 command line
# Modify /etc/default/grub, just add intel_iommu=on to the end of the line which starts with: GRUB_CMDLINE_LINUX
grub2-mkconfig -o /boot/grub2/grub.cfg
# Reboot the machine.

# libvirt package
yum install -y libvirt libvirt-devel libvirt-python virt-install policycoreutils-python

# install and config pyenv
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc


