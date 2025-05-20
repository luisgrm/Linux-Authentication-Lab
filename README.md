# Linux Authentication Lab (Nested KVM on Hyper-V)

This project documents a professional-grade authentication lab using nested virtualization. It features an Ubuntu Admin VM hosted on **Hyper-V**, running **Kernel-based Virtual Machines (KVM)** and **virt-manager** to simulate a real-world enterprise Linux environment with centralized identity management.

The goal is to simulate real-world enterprise Linux support scenarios in preparation for technical support roles like **Canonical’s Linux Desktop & Devices Support Engineer**.

---

## Lab Architecture
```
Windows 11 (host)
|── Hyper-V
│   |── Ubuntu Admin VM (Desktop)
│       |── Fedora IPA Server (KVM)
│       |── Ubuntu Client(s) (KVM)
│       |── Windows Client (KVM, optional)
```

All nested VMs are managed using **virt-manager**, with networking configured for internet access and local resolution.

---

## Documentation

The project is divided into logical, standalone phases:

| Phase | File | Description |
|-------|------|-------------|
| 0 | [`00-overview.md`](docs/00-overview.md) | Project goals, lab structure, and system requirements |
| 0a | [`00a-migration-rationale.md`](docs/00a-migration-rationale.md) | Why we migrated from VirtualBox to Hyper-V |
| 1 | [`01-ubuntu-admin-vm-hyperv.md`](docs/01-ubuntu-admin-vm-hyperv.md) | Setting up the Ubuntu Admin VM on Hyper-V |
| 2 | [`02-create-nested-vms.md`](docs/02-create-nested-vms.md) | Creating Fedora, Ubuntu, and Windows nested VMs |
| 3 | *(coming soon)* | Configuring FreeIPA and domain clients |

---

## Scripts

Reusable scripts are stored in the `scripts/` directory with consistent headers and safe defaults.

Each script is fully documented in the corresponding phase step and used to automate repeatable setup tasks.

---

## Skills Demonstrated

- Hyper-V VM provisioning and switch networking
- Ubuntu Desktop configuration for KVM virtualization
- FreeIPA domain controller setup (Kerberos, LDAP, DNS) *(coming soon)*
- Joining Linux and Windows clients to a central domain *(coming soon)*
- Scripting and automation for repeatable deployments
- Markdown-based professional documentation and version control

---

## Status

This lab is actively in progress and continuously updated. All documentation and screenshots are 100% original and built from real testing.

---

## License

This project is for educational and portfolio purposes. No license currently applied.