# Migration Rationale: VirtualBox to Hyper-V

As of May 2025, this project has transitioned from using VirtualBox to Hyper-V for virtualization. The original setup, based entirely on nested virtualization inside a VirtualBox-hosted Ubuntu Admin VM, encountered significant performance and reliability issues, particularly with Fedora installations and GUI responsiveness.

This migration addresses those issues and aligns the lab environment with professional-grade infrastructure practices more commonly used in enterprise and DevOps contexts.

## Why Hyper-V?

- **Performance**: Hyper-V runs natively on Windows 11, offering faster, more stable virtualization.
- **Nested Virtualization**: Works more reliably for Fedora, Ubuntu, and Windows clients inside an Ubuntu Admin VM.
- **Professional Relevance**: Hyper-V is widely used in enterprise environments, making this setup a better way to practice for real-world IT jobs.
- **Stability**: Avoids hangs, black screens, and kernel module issues encountered with VirtualBox + nested KVM.

## Branching Strategy

- `main`: Now tracks the current and future development using **Hyper-V**.
- `virtualbox-legacy`: Preserves all prior work using **VirtualBox**, including screenshots, instructions, and configuration.

## What’s Changing?

- A new Ubuntu Admin VM will be created using Hyper-V.
- Setup guides and screenshots will be rewritten to reflect this environment.

## What’s Not Changing?

- The overall architecture remains the same: one Admin VM (Ubuntu) hosting 3 nested VMs (Fedora IPA server, Ubuntu client, Windows client) using KVM/QEMU.
- The project goal — demonstrating centralized Linux authentication with FreeIPA — remains the same.
- The documentation style, professionalism, and structure remain consistent.

> This document was added as part of the Hyper-V migration effort. See `00-overview.md` for the full lab map.