#!/bin/bash
clear

C_CYAN='\033[1;36m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_WHITE='\033[1;37m'
C_GRAY='\033[0;90m'
C_RESET='\033[0m'

printf "${C_CYAN}"
cat << "ART"
   _   _ ____    _     _                  ____                              
  | \ | / ___|  | |   (_)_ __  _   ___  __/ ___|  ___ _ ____   _____ _ __ 
  |  \| \___ \  | |   | | '_ \| | | \ \/ /\___ \ / _ \ '__\ \ / / _ \ '__|
  | |\  |___) | | |___| | | | | |_| |>  <  ___) |  __/ |   \ V /  __/ |   
  |_| \_|____/  |_____|_|_| |_|\__,_/_/\_\|____/ \___|_|    \_/ \___|_|   
ART

printf "${C_RESET}\n"
printf "  ${C_YELLOW}%-22s${C_RESET} : %s\n" "Platform" "NS Linux Server 1.0 (Cloud & Core Edition)"
printf "  ${C_WHITE}%-22s${C_RESET} : \033[1;35mNARAWIT SURAPHAN\033[0m\n" "Engineered By"
printf "  ${C_GRAY}----------------------------------------------------------------------${C_RESET}\n"
printf "  ${C_GREEN}%-22s${C_RESET} : %s\n" "Hostname" "$(hostname)"
printf "  ${C_GREEN}%-22s${C_RESET} : %s (%s)\n" "Kernel" "$(uname -r)" "$(uname -m)"
printf "  ${C_GREEN}%-22s${C_RESET} : %s\n" "Uptime" "$(uptime -p 2>/dev/null || uptime | awk '{print $3,$4}')"
printf "  ${C_GREEN}%-22s${C_RESET} : %s\n" "Memory" "$(free -m | awk '/Mem:/ {printf "%d MB / %d MB (%.1f%%)", $3, $2, ($3/$2)*100}')"
printf "  ${C_GREEN}%-22s${C_RESET} : %s\n" "Disk (/)" "$(df -h / | awk 'NR==2 {print $3 " used / " $2 " (" $5 ")"}')"
printf "  ${C_GREEN}%-22s${C_RESET} : \033[1;34m%s\033[0m\n" "IPv4 Address" "$(ip -4 addr show scope global | awk '/inet/ {print $2}' | cut -d/ -f1 | head -n 1)"
printf "  ${C_GRAY}----------------------------------------------------------------------${C_RESET}\n"
printf "  Palette : \033[41m   \033[42m   \033[43m   \033[44m   \033[45m   \033[46m   \033[47m   \033[0m\n\n"

#!/bin/bash
set -e

C_CYAN='\033[1;36m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_RESET='\033[0m'

REPO_RAW="https://raw.githubusercontent.com/narawitsuraphan/ns-linux-server/main"

echo -e "${C_CYAN}====================================================${C_RESET}"
echo -e "       ${C_YELLOW}NS Linux Server - OTA System Updater${C_RESET}"
echo -e "         Maintained by NARAWIT SURAPHAN"
echo -e "${C_CYAN}====================================================${C_RESET}"

# 1. ซิงก์เวลาของเครื่องก่อนเสมอ
echo -e "\n${C_GREEN}[1/5] Synchronizing system clock...${C_RESET}"
date -s "$(curl -sI https://google.com 2>/dev/null | grep -i '^date:' | cut -d' ' -f2-)" >/dev/null 2>&1 || true
hwclock --systohc 2>/dev/null || true
echo "Clock synchronized."

# 2. ตรวจสอบและอัปเดตสคริปต์ ns-update ตัวเองจาก GitHub
echo -e "\n${C_GREEN}[2/5] Checking for updater script updates...${C_RESET}"
curl -fsSL "${REPO_RAW}/ns-update" -o /usr/local/bin/ns-update.tmp 2>/dev/null && {
    mv /usr/local/bin/ns-update.tmp /usr/local/bin/ns-update
    chmod +x /usr/local/bin/ns-update
    echo "Updater engine is up-to-date."
} || echo "Using local updater engine."

# 3. ดึง Welcome Banner ล่าสุด
echo -e "\n${C_GREEN}[3/5] Syncing latest Welcome Banner from Cloud...${C_RESET}"
curl -fsSL "${REPO_RAW}/ns-welcome.sh" -o /etc/profile.d/ns-welcome.sh
chmod +x /etc/profile.d/ns-welcome.sh
echo "Banner updated successfully."

# ======================================================================
# >>> [นำโค้ดโมระบบเวอร์ชันใหม่มาวางตรงนี้] <<<
# ======================================================================
echo -e "\n${C_GREEN}[*] Applying NS Linux 2.0 System Patches...${C_RESET}"

# 1. สั่งติดตั้งเครื่องมือใหม่ที่ต้องการเพิ่มในระบบ
apt update
apt install -y nginx curl htop fastfetch

# 2. ปลดล็อกไฟล์เดิมเพื่ออัปเดตเวอร์ชัน OS
chattr -i /etc/os-release /etc/issue 2>/dev/null || true

# 3. อัปเดตข้อมูล OS Release ใหม่
cat << 'EOF' > /etc/os-release
NAME="NS Linux Server"
PRETTY_NAME="NS Linux Server 2.0 (Enhanced Edition)"
VERSION="2.0"
VERSION_ID="2.0"
HOME_URL="https://ns-cloud.2bd.net"
EOF

# 4. ล็อกไฟล์กลับคืนเพื่อป้องกันระบบอื่นเขียนทับ
chattr +i /etc/os-release /etc/issue 2>/dev/null || true
# ======================================================================

# 4. อัปเดตรายการแพ็กเกจ
echo -e "\n${C_GREEN}[4/5] Updating system packages...${C_RESET}"
DEBIAN_FRONTEND=noninteractive apt upgrade -y

# 5. เคลียร์พื้นที่แคช
echo -e "\n${C_GREEN}[5/5] Cleaning system cache...${C_RESET}"
apt autoremove -y
apt clean

echo -e "\n${C_CYAN}====================================================${C_RESET}"
echo -e "${C_GREEN}[✓] This NS Linux Server is completely up-to-date!${C_RESET}"
echo -e "${C_CYAN}====================================================${C_RESET}\n"
