# run as root
yum install -y git tcpdump tar attr

# for rhel7
yum install -y gcc make patch openssl gdbm-devel openssl-devel sqlite-devel readline-devel zlib zlib-devel bzip2-devel python-devel ncurses-devel.x86_64

# for rhel8
yum install -y gcc make patch openssl gdbm-devel openssl-devel sqlite-devel readline-devel zlib zlib-devel bzip2-devel platform-python-devel ncurses-devel.x86_64

# libvirt package
yum install -y libvirt libvirt-devel virt-install
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
