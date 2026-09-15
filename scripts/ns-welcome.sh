#!/bin/bash
clear

# Color definitions
C_CYAN='\033[1;36m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_WHITE='\033[1;37m'
C_GRAY='\033[0;90m'
C_RESET='\033[0m'

# ASCII Art Logo
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
