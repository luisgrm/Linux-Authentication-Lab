# Phase 1: Prepare Windows 11 Host for Hyper-V
_Note: This file replaces the original VirtualBox setup. See `00a-migration-rationale.md` for migration details._

## Step 1: Turn ON Hyper-V and Required Features

To run the Ubuntu Admin VM using Hyper-V, we first enable the Hyper-V feature on the Windows 11 host.

### 1. Open "Windows Features"

- Press `Windows + S` and search for “Windows Features”.
- Click **“Turn Windows features on or off”**.
- Check the following boxes:
  - **Hyper-V**
  - **Virtual Machine Platform**
  - **Windows Hypervisor Platform**
 
![Screenshot 1: Enable Hyper-V features](../screenshots/01-hyperv-enable.png)

---

### 2. Reboot After Enabling Features

Once selected, click **OK**. Windows will apply the changes and ask you to reboot.

![Screenshot 2: Restart prompt](../screenshots/02-hyperv-reboot.png)

After rebooting, Hyper-V will be available via the Start Menu → "Hyper-V Manager".

---

# Phase 2: Set Up the Ubuntu Admin VM

## Step 1: Open Hyper-V Manager

- Press `Windows + S` and search for "Hyper-V Manager".
- Open the application and verify it launches successfully.
- Confirm your PC name appears on the left panel under Hyper-V Manager.

![Screenshot 3: Hyper-V Manager Open With Host Visible](../screenshots/03-hyperv-opened.png)

## Step 2 (Before VM Creation): Create an External Virtual Switch

To give the Ubuntu Admin VM full internet access and LAN communication, we have to create an **External Virtual Switch** in Hyper-V.

### 1. Open the Virtual Switch Manager

- In **Hyper-V Manager**, select your computer name (left panel)
- Click **“Virtual Switch Manager…”** from the right panel
- Select **External** and click **Create Virtual Switch**
 
![Screenshot 4a: Select External Switch Type](../screenshots/04a-hyperv-switch-type.png)

---

### 2. Configure the Switch

- Name it: `External Switch (Internet Access)`
- For **Connection type**, choose the real adapter that gives your host internet access.  
  
  - In my case: `Qualcomm FastConnect 7800 Wi-Fi 7 High Band Simultaneous (HBS) Network Adapter`

- Do **not** select:
  - VirtualBox adapters
  - Numbered duplicates (#2, #3, etc.)
- Leave **Allow management OS to share this network adapter** checked (recommended)

Click **OK** to apply and close the window.

![Screenshot 4b: External Switch Configuration ](../screenshots/04b-hyperv-switch-config.png)

## Step 3: Create the Ubuntu Admin VM

Now that Hyper-V is enabled and the external switch is configured, we'll create the Ubuntu Admin VM using the Hyper-V Manager interface.

---

### 1. Download Ubuntu Desktop ISO

Download the latest **LTS Ubuntu Desktop** ISO from the official Ubuntu website:

- Download the latest [Ubuntu Desktop LTS ISO](https://ubuntu.com/download/desktop) from the official website. 
- Version used in this lab: Ubuntu 24.04.2 LTS
- File: `ubuntu-24.04.2-desktop-amd64.iso`
- Size: ~5.9GB
- Save it somewhere easy to access, like a **Custom** folder.

![Screenshot 5: ISO Downloaded in File Manager](../screenshots/05-hyperv-ubuntu-iso.png)

**Note**: This ISO is large (~5GB) and includes GNOME and all major desktop components. You may choose the Minimal ISO instead if you prefer a lighter base and are comfortable installing required packages manually.

---

### 2. Create a New VM

- In **Hyper-V Manager**, click **New > Virtual Machine** (in the right panel)
- Click **Next** through the *Before You Begin* screen

![Screenshot 6: Hyper-V New VM Wizard](../screenshots/06-hyperv-new-vm-start.png)

---

### 3. Specify Name and Location

- **Name**: `ubuntu-admin-vm`
- You may optionally check **Store the virtual machine in a different location** if you want to save the VM files to a specific drive (e.g. SSD for faster performance or external disk for portability).

![Screenshot 7: VM Name and Location](../screenshots/07-hyperv-vm-name-location.png)

---

### 4. Specify Generation

- Choose: **Generation 2**
- This enables UEFI and better compatibility with newer OSes like Ubuntu.

> ⚠️ Once the VM is created, its generation **cannot be changed**. If you accidentally choose Generation 1, you must delete and recreate the VM.

![Screenshot 8: Select VM Generation](../screenshots/08-hyperv-generation.png)

---

### 5. Assign Memory

- Startup memory: **8192 MB** (8 GB)
- You may increase this to **12288 MB (12 GB)** or **16384 MB (16 GB)** if your system has sufficient RAM.
- Uncheck **Use Dynamic Memory for this virtual machine** for more stable performance in nested environments.

![Screenshot 9: Memory Assignment](../screenshots/09-hyperv-memory.png)

---

### 6. Configure Networking

- Connect the VM to the **External Virtual Switch** you created earlier (`External Switch (Internet Access)`).

![Screenshot 10: Virtual Switch Selection](../screenshots/10-hyperv-network-switch.png)

---

### 7. Create Virtual Hard Disk

- Select **Create a virtual hard disk** (default)
- Name: `ubuntu-admin-vm.vhdx`
- Size: `80 GB` or more (recommended minimum: 60 GB)
- Leave location as default or choose a custom folder

![Screenshot 11: Disk Setup](../screenshots/11-hyperv-disk.png)

---

### 8. Select Installation Media

- Choose **Install an operating system from a bootable CD/DVD ROM**
- Select **Image file (.iso)**
- Browse and select the Ubuntu Desktop ISO you downloaded

![Screenshot 12: ISO Selection](../screenshots/12-hyperv-iso-selected.png)

---

### 9. Finish Setup

- Review the summary and click **Finish**
- The VM will be created and ready to power on

![Screenshot 13: Final Review Screen](../screenshots/13-hyperv-vm-summary.png)

> ✅ The Ubuntu Admin VM has now been successfully created in Hyper-V.  
> In the next step, we’ll power it on and complete the Ubuntu Desktop installation.