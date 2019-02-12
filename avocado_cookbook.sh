

useful avocado command
----------------------

1, prepare a guest for testing

# virt-install --connect qemu:///system -n avocado-vt-vm1 --hvm --accelerate -r 1024 --vcpus=2 --disk path=/os_images/jeos-8.0-x86_64-latest.qcow2,bus=virtio,format=qcow2 --network bridge=virbr0,model=virtio --import --noreboot --noautoconsole --serial pty --memballoon model=virtio --graphics vnc --video cirrus

2, testcase list, run and Debug
avocado list --vt-type libvirt mycase
    - list available test cases
avocado list --vt-type libvirt virsh.migrate_vm
avocado list --vt-type libvirt <part of test case name>
avocado run --vt-type libvirt $test_name

3, re-run avocado test case from ci view
ci run --rerun <CI_JOB_LINK>


Test case run workflow in avocado framework
-------------------------------------------

# avocado run --vt-type libvirt $test_name
VirtTest --> runTest --> preprocess --> env_save --> run --> postprocess -->env_save
    - avocado-vt/avocado_vt/test.py
		class VirtTest --> runTest --> utils_misc.get_test_entrypoint_func
    - avocado-vt/virttest/utils_misc.py
    - avocado-vt/virttest/env_process.py
    - virttest/utils_env.py

The details in avocado framework
--------------------------------

1, bootstrap task workflow

Checking the mandatory programs and headers
Checking the recommended programs
Download/Updating all test providers( --vt-update-providers )
Verifying directories
	Check/create sub dirs: "images", "isos", "steps_data", "gpg", "downloads"
	Sync backend dirs: backend
	Sync download dir: shared/downloads
	Create config files( --vt-type )
	Verify selinux
Verify/Download guest image( --vt-no-downloads )

2, bootstrap task (verifying directory) details in virttest/bootstrap.py

create config files

from 
	cfg files
		avocado-vt/shared/cfg/
		avocado-vt/backends/libvirt/cfg/
TO
	create the whole test case cfg files
		/var/lib/avocado/data/avocado-vt/backends/libvirt/cfg/subtests.cfg

3, the final test case cfg files

the "include" order in avocado-vt/backends/libvirt/cfg/tests-shared.cfg will
affect the result of final cfg files !!!

test case cfg files is in subtests.cfg will be changed by the following config
such as guest-os.cfg


3, details in runtest workflow

preprocess
    - preprocess params
    - create env file
    - start_tcpdump, remove no needed vms in env, check KVM version, check KVM userspace(qemu-kvm)
    - preprocess image
    - preprocess vm


postprocess
    - postprocess vm
    - postprocess image
    - postprocess params
    - Kill VMs
    - stop_tcpdump
    - kill aexpect tail threads

important parameters
    - virttest/env_process.py
    - vm, main_vm, vm_type, connect_uri




How to add a libvirt test case to avocado
-----------------------------------------

1, in test-providers.d/

cp io-github-autotest-libvirt.ini local.ini
vim local.ini
uri: file:///home/jil/code/tp-libvirt/

avocado vt-bootstrap --vt-type libvirt --vt-no-downloads
avocado list --vt-type libvirt local
avocado run --show-job-log --vt-type libvirt 

# note the file in /var/lib/avocado/data/avocado-vt/test-providers.d/


2, in tp-libvirt/libvirt/tests/cfg/testcase/
touch apple.cfg && vim apple.cfg
# cfg file MUST have the last empty line

3, touch apple.py && vim apple.py
import logging
def run(test,params, env):
    vm = env.get_vm(params.get('main_vm')) # get the vm name - avocado-vt-vm1
    vm.verify_alive() # verify the vm is alive  
    logging.debug('~~~~~~~~~')
    session = vm.wait_for_login() # login guest
    output = session.cmd_output('uptime')
    logging.debug(output) # print out the result of command in guest

#use params to get parameters from the cfg files

4, update the cfg files after change cfg files
avocado vt-bootstrap --vt-type libvirt --vt-no-downloads
avocado list --vt-type libvirt mycase
avocado run --show-job-log --vt-type libvirt case_name

about vt-bootstrap - avocado-vt/virttest/bootstrap.py
    - check the mandatory programs and headers
    - check the recommended programs
    - download/update all test providers(--vt-update-providers)
    - verify directory
        - check/create sub dirs: images, isos, steps_data, gpg, downloads
        - sync backend dirs: backend
        - sync download dir: shared/downloads
        - create config files(--vt-type)
        - verify selinux
    - verify/download guest image(--vt-no-downloads)

5, check the testcase before send PR

inspekt style xxx
inspekt lint xxx
inspekt indent xxx




Useful modules when creating avocado-vt case
--------------------------------------------
1, avocado-vt/virttest/libvirt_vm.py
Utility classes and functions to handle Virtual Machine creation using libvirt

2, avocado-vt/virttest/virsh.py
virsh command wrapper, open debug when you need to add new command

3, avocado-vt/virttest/libvirt_xml/
    new_from_dumpxml
        get current guest os xml and change and redefine guest of
    vm_rename - useful example code

4, avocado-vt/virttest/utils_test/libvirt.py
libvirt test case common functions





add a tp-libvirt test case
--------------------------

1. create jira task of polarin mannual testcase
a. select a mannual testcase in polarin
b. find testcase in caselink via polarin testcase ID, such as RHEL7-17891
c. click "Create Automated Request" to create corresponding jira task to track your automation task
d. file jira task when you code is merged into git hub











1. match the auto test case with manual case for a detailed test steps


# how to add a feature
features_xml = vm_xml.VMFeaturesXML()
if feature == 'hpt':
    features_xml.hpt_resizing = value
elif feature == 'htm':
    features_xml.htm = value
vmxml.features = features_xml
vmxml.sync()

# how to del and add a device
    memballoon_model = params.get("memballoon_model", "")
    if memballoon_model:
        vm.destroy()
        vmxml.del_device('memballoon', by_tag=True)
        memballoon_xml = vmxml.get_device_class('memballoon')()
        memballoon_xml.model = memballoon_model
        vmxml.add_device(memballoon_xml)
        logging.info(memballoon_xml)
        vmxml.sync()
        vm.start()

# how to set cputune xml element
        cputune = vm_xml.VMCPUTuneXML()
        cputune.vcpupins = [{'vcpu': str(vcpu), 'cpuset': cpu_list}]
        vmxml = vm_xml.VMXML.new_from_inactive_dumpxml(vm.name)
        vmxml.cputune = cputune
        vmxml.sync()

