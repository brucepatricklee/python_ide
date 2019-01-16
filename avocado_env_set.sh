# install python3.6 env for avocado
pyenv install -v 3.6.0
mkdir $HOME/code && cd $HOME/code
pyenv versions
pyenv local 3.6.0
pyenv versions
export CODE_PATH=$HOME/code
cd $CODE_PATH

# install avocado and testcase git repo for libvirt
git clone https://github.com/avocado-framework/avocado.git
git clone https://github.com/avocado-framework/avocado-vt.git
git clone https://github.com/autotest/tp-libvirt

# configure avocado repo
cd $CODE_PATH/avocado
pip install -r requirements-selftests.txt --upgrade
python setup.py develop

# configure avocado-vt repo
cd $CODE_PATH/avocado-vt
pip install -r requirements.txt --upgrade
sed -i -e "s%uri:.*%uri: file://$CODE_PATH/tp-libvirt%" $CODE_PATH/avocado-vt/test-providers.d/io-github-autotest-libvirt.ini
python setup.py develop

# bootstrap avocado-vt
# !!!!add the difference between develop and install
# the task the bootstrap subcommand do
#   1. check the system tool availability
#   2. check the test provider(test suite)
#   3. update the config files with necessary parameters to run test case

avocado vt-bootstrap --vt-type libvirt

# after this replacement, you can just modify the code in $CODE_PATH/tp-libvirt, and your change will take effect directly (This is only for changes in .py files. Your changes in .cfg file won’t take effect directly. You have rerun bootstrap each time you modified .cfg file





DOWNLOAD_SERVER_CN=10.66.4.123
DOWNLOAD_SERVER_US=10.12.0.20

# get guest rhel7 os image
wget http://$DOWNLOAD_SERVER_CN/libvirt-CI-resources/RHEL-7.6-x86_64-latest.qcow2 -O $HOME/Download/rhel76-x86_64.qcow2

# get guest rhel8 os image
wget http://$DOWNLOAD_SERVER_CN/libvirt-CI-resources/RHEL-8.0-x86_64-latest.qcow2 -O $HOME/Download/rhel80-x86_64.qcow2

# kvm guest os name - avocado-vt-vm1



