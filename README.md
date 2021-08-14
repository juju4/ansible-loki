[![Actions Status - Master](https://github.com/juju4/ansible-loki/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-loki/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-loki/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-loki/actions?query=branch%3Adevel)

[![Appveyor - Master](https://ci.appveyor.com/api/projects/status/27div2ln0s7kli7h/branch/master?svg=true)](https://ci.appveyor.com/project/juju4/ansible-loki/branch/master)
[![Appveyor - Devel](https://ci.appveyor.com/api/projects/status/27div2ln0s7kli7h/branch/devel?svg=true)](https://ci.appveyor.com/project/juju4/ansible-loki/branch/devel)

# Loki ansible role

A simple ansible role to execute loki, a Simple IOC and Incident Response Scanner.
* https://github.com/Neo23x0/Loki
* https://www.bsk-consulting.de/loki-free-ioc-scanner/

## Requirements & Dependencies

### Ansible
It was tested on the following versions: 1.9 to 2.11

### Operating systems

Tested Ubuntu 18.04, 20.04 and Centos 7 and 8.

## Example Playbook

Just include this role in your list.
For example

```
- host: myhost
  roles:
    - juju4.loki
```

you probably want to review variables


## Variables

```
prefix: "{{ ansible_fqdn }}"
dst_mount: "/tmp/cases"
dst_path: "{{ dst_mount }}/{{ prefix }}-incidentreport"

## do we want to install new packages? might be required if building kernel module for example
## allow ansible to download stuff which does not exist, eventually build it?
## more impacting the evidence but sometimes have no choice...
do_download: true
do_build: true
do_install: true

bin_path: "/tmp/ir-bin"

loki_scan_path: "/"

bin_path_win: "c:\\temp\\ir-bin"
dst_path_win: "c:\\temp"
#loki_scan_path_win: "c:\\"
loki_scan_path_win: "c:\\windows"

loki: true
#loki_args: "--dontwait --intense --onlyrelevant --noindicator"
loki_args: "--dontwait --intense --noindicator"
```

* bin_path: can be a network path or removable media. If local and
  download/build/install is enabled, the role will add everything necessary.
  Of course, from a forensic perspective, better if everything is setup either
  before locally (but can be altered) or a network read-only share
* dst_path: where to store the output. again, came be local or remote.


## Continuous integration
Work in progress!!!

you can test this role with test kitchen.
In the role folder, run
(Not working)
```
$ gem install winrm-fs
$ kitchen verify
```
(manual working)
```
$ kitchen create ansible-ubuntu-1404
$ kitchen create windows-windows-2012r2
?$ cp .kitchen/kitchen-vagrant/kitchen-ansible_repo-tomcat-centos-70/.vagrant/machines/default/virtualbox/private_key spec/tomcat_private_key.pem
?$ cp .kitchen/kitchen-vagrant/kitchen-loki-ansible-ubuntu-1404/.vagrant/machines/default/virtualbox/private_key spec/

$ kitchen login ansible-ubuntu-1404
    $ sudo apt-get -y install krb5-config python-pip
    $ sudo pip install xmltodict
    $ sudo pip install "pywinrm>=0.1.1"
## manually configure windows host for ansible (ConfigureRemotingForAnsible.ps1) as packer is still not doing it.
## BUG/FIXME! VMs cant reach other be it by ping (firewall opened) or winrm
$ kitchen converge ansible-ubuntu-1404
$ kitchen verify ansible-ubuntu-1404
```
or
```
$ pip install molecule docker
$ molecule test
$ MOLECULE_DISTRO=ubuntu:20.04 molecule test --destroy=never
```

## Known bugs

* windows image is not free to redistribute
Follow http://kitchen.ci/blog/test-kitchen-windows-test-flight-with-vagrant/
* windows support in kitchen-ansible seems missing
https://github.com/neillturner/kitchen-ansible/issues/131
* Ongoing work for [Python3 support](https://github.com/Neo23x0/Loki/pull/123)

## Troubleshooting & Known issues

* time
depending on box, Loki can take a while. Role enforce 1h limit (valid only on unix), just in case.

## License

BSD 2-clause
