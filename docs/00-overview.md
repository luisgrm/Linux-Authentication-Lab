# Linux Authentication Lab with Nested Virtualization

## Purpose

This lab demonstrates the set up and configuration of a professional-grade Linux authentication environment using nested virtualization. 
It simulates enterprise-level Linux authentication using FreeIPA, Ubuntu clients, and KVM on an Ubuntu Desktop virtual machine.

## Career Goal

This project is designed as part of a hands-on portfolio to showcase system administration, troubleshooting, and support capabilities aligned with positions such as the **Linux Desktop & Devices Support Engineer** at Canonical.

## Technology Stack

- **Host OS:** Windows 11 Education with Virtual Box
- **Admin VM (Outer VM):** Ubuntu 24.04.02 LTS Desktop with KVM/QEMU, libvirt, virt-manager
- **Nested VMs**
    - `ipa-server`: Fedora Server 39 with FreeIPA (LDAP, DNS, Kerberos)
    - `ubuntu-client1`, `ubuntu-client2`: Ubuntu Desktop clients
    - `win-client`: Optional Windows 10/11 domain join testing

## Structure

This documentation is divided into the following stages:

- `01-ubuntu-kvm-setup.md`: Creating and preparing the outer Ubuntu VM
- `02-create-nested-vms.md`: Defining and installing KVM nested guests
- `03-freeipa-server-setup.md`: FreeIPA installation and DNS/Kerberos setup
- `04-join-ubuntu-client.md`: Joining Ubuntu to the IPA domain
- `05-domain-login-and-sudo.md`: Verifying domain login and sudo configuration
- `06-summary.md`: Final results, troubleshooting notes, and learnings

## Notes

All scripts are stored in `scripts/`, named for their tasks. Scripts follow a consistent documentation header and safe bash practices

Git is configured inside the Ubuntu admin VM to keep versioning, commit history, and SSH keys tied to the development environment.