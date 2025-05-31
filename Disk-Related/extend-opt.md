## 🧩 LVM Volume Extension Cheat Sheet (Add 20GB to `/opt`)

### 🔧 1. Partition the New Disk (`/dev/sdc`)

```bash
fdisk /dev/sdc
```

Inside `fdisk`:

* `n` → new partition
* `p` → primary
* Accept defaults → `Enter`
* `w` → write and quit

➡️ Creates `/dev/sdc1`

---

### 💠 2. Create Physical Volume (PV)

```bash
pvcreate /dev/sdc1
```

---

### 🧱 3. Extend the Volume Group (VG)

```bash
vgextend rootvg /dev/sdc1
```

---

### ➕ 4. Extend the Logical Volume (`/opt`)

```bash
lvextend -L +20G /dev/mapper/rootvg-optlv
```

---

### 📦 5. Resize the Filesystem

#### If `/opt` uses `xfs` (most likely):

```bash
xfs_growfs /opt
```

#### If `/opt` uses `ext4` (less common):

```bash
resize2fs /dev/mapper/rootvg-optlv
```

---

### ✅ 6. Confirm the Extension

```bash
df -h /opt
```

You should now see **\~30GB** total for `/opt`.

---

### 🛠️ Optional: Check Filesystem Type

```bash
df -T /opt
```

---

![Screenshot](https://drive.google.com/uc?id=1K97FOIMfJ-Put6TyrzApYQwSOd7GJ-9x)
