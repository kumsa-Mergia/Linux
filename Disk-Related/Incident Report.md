#  Root Filesystem Full & LVM Extension Failure

## 📌 Problem Description
The server **Infinity-microservice-DB** encountered a critical issue where the root filesystem (`/`) became completely full.

- **Logical Volume**: `/dev/mapper/rhel-root`
- **Size**: 19G  
- **Usage**: 100% full  

### ❗ Error Encountered
```bash
lvextend -L +100G /dev/mapper/rhel-root
Couldn't create temporary archive name.
````

### ⚠️ Root Cause

LVM requires free space in `/etc/lvm/archive` to store metadata backups during operations.
Since the root filesystem (`/`) was full, LVM could not create the archive file, causing the extension to fail.

---

## 🔍 Investigation

### Disk Usage Analysis

```bash
du -sh /*
```

* `/DATA1` → 65G
* `/DATA2` → 78G
* Both are separate mount points (not impacting `/`).

### Log & Cache Review

* `/var/log` → minimal usage (MB range)
* No abnormal growth detected

### Cleanup Attempts

```bash
rm -rf /var/crash/*
dnf clean all
journalctl --vacuum-time=1d
```

➡️ Result: No significant space recovered

### Open Deleted Files Check

```bash
lsof | grep deleted
```

* Found processes holding deleted files:

  * `rsyslogd`
  * `rtkit-daemon`
  * `avahi-daemon`

➡️ Restarting services did not free sufficient space.

### Conclusion

* Root filesystem critically undersized
* Extension required but blocked due to lack of space for LVM metadata archive

---

## 🛠 Resolution

### 1️⃣ Extend LV (Bypass Archive Creation)

```bash
lvextend -L +100G /dev/mapper/rhel-root --config 'backup { archive = 0 }'
```

### 2️⃣ Grow Filesystem

```bash
xfs_growfs /
```

### 3️⃣ Verification

#### Filesystem Check

```bash
df -hT /
```

* Total: **119G**
* Used: **20G**
* Free: **~100G (17%)**

#### Logical Volume Check

```bash
lvdisplay
```

* Size: ~118.6 GiB

#### Filesystem Growth Confirmation

```bash
xfs_growfs /
```

* Output confirmed successful expansion

---

## ✅ Outcome

* Root filesystem expanded from **19G → 119G**
* ~100G free space restored
* System stability recovered
* LVM operations functional again without workaround

---

## ⚠️ Recommendations

### 📏 Capacity Planning

* Maintain root LV size of **≥100G** for production RHEL systems

### 📊 Monitoring (Prometheus)

```promql
node_filesystem_avail_bytes{mountpoint="/"} 
  / node_filesystem_size_bytes{mountpoint="/"} * 100
```

### 💾 LVM Metadata Backup

```bash
vgcfgbackup -f /DATA1/vg-backup-rhel-root.conf rhel
```

### 🧹 Routine Maintenance

* Monitor:

  * `/var/cache`
  * `/var/tmp`
  * `/var/log`
* Regularly clean package caches and old logs

---

## 📎 Summary

This incident was caused by a full root filesystem preventing LVM metadata archive creation.
A temporary workaround allowed the logical volume to be extended, restoring system functionality.

Proactive monitoring, proper sizing, and regular maintenance will prevent recurrence.

---

```

---
