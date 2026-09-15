#!/bin/bash
# สคริปต์สำหรับโมระบบและแพตช์เครื่องผู้ใช้ปลายทาง
set -e

# ตั้งค่า default ไม่ให้ GRUB ถามดิสก์ซ้ำ
echo "grub-pc grub-pc/install_devices multiselect /dev/sda" | debconf-set-selections 2>/dev/null || true

# ตรวจสอบว่าเคยรันแพตช์ v1 หรือยัง (กันรันซ้ำซ้อน)
if [ ! -f /etc/ns-patch-v1.done ]; then
    echo ">> Applying System Patch v1.0..."
    
    # ตัวอย่าง: อัปเดตคลังแพ็กเกจและติดตั้งเครื่องมือจำเป็น
    apt update
    DEBIAN_FRONTEND=noninteractive apt install -y curl htop fastfetch
    
    # ทำเครื่องหมายว่าแพตช์นี้ลงเรียบร้อยแล้ว
    touch /etc/ns-patch-v1.done
    echo ">> System Patch v1.0 applied successfully."
fi

# อัปเดตแพ็กเกจปกติของ Debian
DEBIAN_FRONTEND=noninteractive apt upgrade -y
