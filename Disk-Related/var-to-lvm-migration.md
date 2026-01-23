# Move `/var` to LVM on a Separate Disk (VM)

## Overview
This document describes how to migrate `/var` from the root filesystem to a **dedicated LVM logical volume**, using a disk that was **originally created outside LVM** and then converted into LVM.

This setup helps prevent `/var` (logs, cache, spool, etc.) from filling up the root filesystem and provides better flexibility for disk management.

---

## Environment Assumptions
- Running inside a **virtual machine**
- A new disk is attached (example: `/dev/sdc`)
- Disk was **not previously part of LVM**
- Filesystem type: `ext4`
- Volume Group: `vg0`
- Logical Volume: `lv_var`
- Logical Volume size: `99G`

> ⚠️ Device names may differ (`/dev/sdb`, `/dev/sdc`). Always verify before executing commands.

---

## Step 1: Identify Available Disks

```bash
fdisk -l
````

Confirm the new disk is present and unused.

---

## Step 2: Partition the Disk

```bash
fdisk /dev/sdc
```

Actions inside `fdisk`:

* Create a new primary partition
* Set partition type to **Linux LVM (8e)**
* Write changes

Resulting partition example:

```
/dev/sdc1
```

---

## Step 3: Create LVM Structures

### Create Volume Group

```bash
vgcreate vg0 /dev/sdc1
```

### Create Logical Volume for `/var`

```bash
lvcreate -L 99G -n lv_var vg0
```

### Verify LVM

```bash
lvscan
```

---

## Step 4: Create Filesystem

```bash
mkfs.ext4 /dev/vg0/lv_var
```

---

## Step 5: Temporary Mount

```bash
mkdir /mnt/newvar
mount /dev/vg0/lv_var /mnt/newvar
df -h /mnt/newvar
```

---

## Step 6: Stop Services Using `/var`

To avoid data inconsistency during the copy:

```bash
systemctl stop systemd-journald
systemctl stop rsyslog
systemctl stop cron
```

---

## Step 7: Copy `/var` Data

Use `rsync` to preserve ownership, permissions, ACLs, xattrs, and numeric IDs.

```bash
rsync -aAXHv --numeric-ids /var/ /mnt/newvar/
```

Verify disk usage:

```bash
df -h
```

---

## Step 8: Replace `/var`

### Unmount Old `/var`

```bash
umount -l /var
```

### Backup Existing `/var`

```bash
mv /var /var.old
```

### Create New Mount Point

```bash
mkdir /var
```

### Mount the LVM Volume

```bash
mount /dev/vg0/lv_var /var
df -h
```

---

## Step 9: Configure Persistent Mount

### Get UUID

```bash
blkid /dev/vg0/lv_var
```

### Update `/etc/fstab`

```bash
nano /etc/fstab
```

Add the following entry:

```fstab
/dev/mapper/vg0-lv_var  /var  ext4  defaults  0  2
```

---

## Step 10: Restart Services

```bash
systemctl start systemd-journald
systemctl start rsyslog
systemctl start cron
```

---

## Step 11: Reboot and Verify

```bash
reboot
```

After reboot:

```bash
df -h | grep /var
cd /var
```

Expected output:

```
/dev/mapper/vg0-lv_var on /var type ext4
```

---

## Step 12: Cleanup

After confirming everything works correctly:

```bash
rm -rf /var.old
```

---

## Result

* `/var` is now hosted on **LVM**
* Logical Volume: `vg0/lv_var`
* Persistent across reboots
* Root filesystem protected from `/var` growth

---

## Notes

* This process is suitable for **RHEL, CentOS, Rocky, Alma, Oracle Linux**
* Always test in non-production environments first
* Keep console access available during migration

---
