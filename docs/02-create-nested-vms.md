# Phase 2: Create Nested VMs using KVM

In this phase, we will configure the Ubuntu Admin VM (`ubuntu-admin-vm`) to run nested virtual machines using KVM and libvirt. These nested VM's will be used to simulate a real authentication lab, including FreeIPA server and Linux clients.

We will being by updating the sytem, then install KVM and all necessary virtualization tools, and finally configure everything to prepare for the creation of the nested guest machines.

---

## Step 1: Update and Upgrade the System

Before installing any virtualization tools, we update and upgrade the Ubuntu Admin VM to ensure all system packages are current. This improves stability and avoids dependency issues when installing KVM components.

### Script: `scripts/update-system.sh`

- This script automates the process of updating the system’s package index and upgrading all available packages. It also adds structured output for better terminal readability.

![Screenshot 9a: update-system.sh script](../screenshots/09a-update-script.png)

#### Usage
```bash
chmod +x scripts/update-system.sh
./scripts/update-system.sh
```
- If the script runs sucessfully, you should see output similar to the screenshot below.

![Screenshot 9: Upgrade Sucessful Output](../screenshots/09-system-upgrade-complete.png)

### Restart Required

After the upgrade, Ubuntu may prompt for system restart. If this happens, click **Restart Now** to apply updates.

---

## Step 2: Install KVM and Virtualization Tools

We begin by installing the core virtualization packages inside the Ubuntu Admin VM. These tools enable you to create and manage KVM-based virtual machines using the `virt-manager` interface and `libvirt`.

### Tools to Install

- `qemu-kvm`: Core KVM package
- `libvirt-daemon-system`: System-level libvirt services
- `libvirt-clients`: CLI tools for managing libvirt
- `virt-manager`: GUI ti create/manage VMs
- `bridge-utils`: Optional networking bridge tools

### Script: `scripts/install-kvm-tools.sh`

This script installs all required virtualization tools in a single run, and adds the current user to the kvm and libvirt groups, to ensure proper permission handling when using `virt-manager`.

![Screenshot 10a: install-kvm-tools.sh script](../screenshots/10a-kvm-install-script.png)

#### Usage
```bash
chmod +x scripts/install-kvm-tools.sh
./scripts/install-kvm-tools.sh
```

- If the script runs sucessfully, you should see output similar to the screenshot below.

![Screenshot 10: install-kvm-tools complete](../screenshots/10-kvm-install-complete.png)

### Restart Required Once Again

After installing the KVM tools, you must reboot the system or log out/log in to apply group membership changes. If this step is skipped, `virt-manager` may fail to access virtualization features.

---

## Step 3: Verify KVM and Nested Virtualization

Before proceeding with VM creation, we verify that the virtualization stack is working correctly inside the Ubuntu Admin VM.

### Commands to Run

Please run the following commands in order:

```bash
lsmod | grep kvm
egrep -c '(vmx|svm)' /proc/cpuinfo
groups
virsh list --all
virt-manager
```

These commands confirm that:
- KVM modules are loaded
- Nested virtualization is available
- The user has proper group access
- libvirt is active and ready
- virt-manager can connect to the system

Please ensure that `virt-manager` launches without errors and shows a local QEMU/KVM connection in the GUI. This confirms that virtualization is fully functional inside your admin VM.

If you receive no output from `lsmod | grep kvm` or if `/proc/cpuinfo` returns `0` for `vmx` or `svm`, this is expected behavior in some VirtualBox-based nested environments. As long as `virt-manager` launches, and you can access the QEMU/KVM backend, you are good to proceed.

- See the screenshot below for a reference of the expected output and GUI status:

![Screenshot 11: Verification Output and GUI](../screenshots/11-kvm-verification.png)

---

## Step 4: Create the ipa-server VM in Virt-Manager

This virtual machine will host the FreeIPA server, which provides centralized authentication, DNS, and Kerberos services for our lab.

---

### Step 4.1: Download Fedora Server 39 ISO

Download the official Fedora Server ISO from the Fedora Project:

- URL: [https://getfedora.org/en/server/download/](https://getfedora.org/en/server/download/)
- Version used in this lab: Fedora Server 42 (x86_64)
- File: `Fedora-Server-dvd-x86_64-42-1.1.iso`
- Size: ~2.7GB

> Tip: Use the Ubuntu Admin VM's browser to download the ISO directly into `~/Downloads` or a custom `~/ISOs` directory

![Screenshot 12: Fedora Download Page](../screenshots/12-fedora-download.png)

---

### Step 4.2: Launch Virt-Manager and Create a New VM

1. Open `virt-manager` from the Ubuntu Admin VM.
2. Click **Create a New Virtual Machine**

![Screenshot 13: virt-manager New VM Creation Wizard](../screenshots/13-virt-new.png)

> **Note**: If you see a warning saying "KVM is not available", you can ignore it for now. This happens in some VirtualBox-based nested setups. As long as you're able to complete the VM creation steps and Fedora installs, this warning has no impact.

---

### Step 4.3: Select Installation Media

- Choose: **Local install media (ISO)**
- Click **Browse**, then navigate to the downloaded `Fedora-Server-dvd-x86_64-42-1.1.iso`
- OS Type: **Fedora**

> virt-manager will attempt to auto-detect the OS from the ISO. If it fails, you can manually select **Fedora** from the list.

![Screenshot 14: Installation Media Selection](../screenshots/14-virt-media.png)

---

### Step 4.4: Assign Memory and CPU

- Memory: **4096 MB** (4GB)
- CPUs: **2**

![Screenshot 15: Memory and CPU Config](../screenshots/15-virt-memory-cpu.png)

---

### Step 4.5: Create Disk Image

- Ensure **Enable storage for this virtual machine** is checked
- Create a disk image of **30 GB** (or more if needed)

This disk format will be default to QCOW2 behind the scenes.

![Screenshot 16: Disk Configuration](../screenshots/16-virt-disk.png)

---

### Step 4.6: Finalize VM Configuration

- Name: `ipa-server`
- Ensure the box is checked: **Customize configuration before install**
- Ensure the **Network selection** is set to `Virtual network 'default': NAT`
- Click **Finish**

![Screenshot 17: Final VM Summary Before Customization](../screenshots/17-virt-finalize.png)

---

### Step 4.7: Customize VM Settings Before Installation

The VM will open in configuration mode because we enabled **"Customize configuration before install"**.

- Under the **Overview** tab:
    - Change **Firmware** from `BIOS` to `UEFI`
    - Keep **Chipset** as `Q35`
    - Under **Video**, set the model to `QXL` (recommended for Spice Support)
    - Leave other settings as default

![Screenshot 18: Overview Tab Showing UEFI Firmware]()

Once done, click **Apply** (bottom-right) to save the configuration, then click **Begin Installation** (top-left)

---

### Step 4.8: Begin Fedora Installation

Once the configuration is saved, click **Begin Installation** to start the Fedora installer.

Go through the following setup steps:

- **Select Language**: English (or your preference)
- **Installation Destination**: Use automatic partitioning
- **Root Password**: Set a secure password
- **User Creation**: Create an admin user (e.g., `ipaadmin`) and give it administrator privileges
 
![Screenshot 19: Fedora installation in progress](../screenshots/19-virt-install-started.png)

> **Troubleshooting Note:**
> If the Fedora installer shows a black screen or hangs, try changing the VM’s video model from `Virtio` to `QXL` in the **Video** settings of `virt-manager`. Also ensure the Fedora ISO is correctly attached and set to boot first in the Boot Options menu.