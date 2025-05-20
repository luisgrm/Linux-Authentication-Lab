# Phase 3: Create Nested VMs using KVM

Now that our Ubuntu Admin VM is fully configured with KVM and libvirt, we can begin creating the nested virtual machines that will form our authentication lab.

These nested VMs will include:

- `ipa-server`: A Fedora Server running FreeIPA with DNS and Kerberos
- `ubuntu-client1`: A Linux workstation joined to the IPA domain
- `ubuntu-client2`: (Optional) A second Linux client for multi-client testing
- `win-client`: (Optional) A Windows 10/11 domain client

---

## Step 1: Create the ipa-server VM

This virtual machine will host the FreeIPA server, which provides centralized authentication, DNS, and Kerberos services for our lab.

---

### 1.1: Download Fedora Server 42 ISO

Download the official Fedora Server ISO from the Fedora Project:

- Download the latest [Fedora Server ISO](https://fedoraproject.org/en/server/download)
- Version used in this lab: Fedora Server 42 (x86_64)
- File: `Fedora-Server-dvd-x86_64-42-1.5.iso`
- Size: ~2.1GB

> Tip: Use the Ubuntu Admin VM's browser to download the ISO directly into `~/Downloads` or a custom `~/ISOs` directory

---