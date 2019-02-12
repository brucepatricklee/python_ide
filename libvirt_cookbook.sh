
1, Libvirt basement
-------------------

local URI
    driver[+transport]:///[path][extral-param]
        driver qemu,xen,xbox,lxc
        non-privilege instant - qemu:///session - only login user
        privilege instant - qemu:///system need root login - manage all the resources in node
    
remote URI
    driver[+transport]://[user@][host][:port]/[path][extral-param]
        transport ssh, tcp, libssh2

man virsh
virsh 
virt-install - build and install new VM
virt-clone - clone and existing VM
virt-image - creating VM from XML
virt-convert - convert VM from one format to another


