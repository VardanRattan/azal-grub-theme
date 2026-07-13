#!/usr/bin/env bash
#
# Helper script to clean up GRUB entries to match the ideal list:
# 1. Arch Linux (from 40_custom)
# 2. Arch Linux (Fallback) (from 40_custom)
# 3. Windows 11 (from 40_custom)
# 4. UEFI Firmware Settings (from 40_custom)
#

set -e

# Color variables
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

# Root check
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: This script must be run as root (or with sudo).${NC}"
    echo -e "Please run: ${YELLOW}sudo $0${NC}"
    exit 1
fi

echo -e "${BLUE}[*] Backing up configuration files...${NC}"
cp /etc/default/grub "/etc/default/grub.bak.$(date +%Y%m%d_%H%M%S)"
cp /etc/grub.d/40_custom "/etc/grub.d/40_custom.bak.$(date +%Y%m%d_%H%M%S)"

echo -e "${BLUE}[*] Disabling OS Prober in /etc/default/grub...${NC}"
if grep -q "^[[:space:]]*GRUB_DISABLE_OS_PROBER=" /etc/default/grub; then
    sed -i 's|^[[:space:]]*GRUB_DISABLE_OS_PROBER=.*|GRUB_DISABLE_OS_PROBER="true"|' /etc/default/grub
else
    echo 'GRUB_DISABLE_OS_PROBER="true"' >> /etc/default/grub
fi

echo -e "${BLUE}[*] Disabling automatic 30_uefi-firmware script...${NC}"
chmod -x /etc/grub.d/30_uefi-firmware

echo -e "${BLUE}[*] Appending UEFI Firmware Settings shortcut to the end of 40_custom...${NC}"
if ! grep -q "uefi-firmware" /etc/grub.d/40_custom; then
    cat << 'EOF' >> /etc/grub.d/40_custom

if [ "${grub_platform}" = "efi" ]; then
	fwsetup --is-supported
	if [ "$?" = 0 ]; then
		menuentry 'UEFI Firmware Settings' $menuentry_id_option 'uefi-firmware' {
			fwsetup
		}
	fi
fi
EOF
    echo -e "${GREEN}[+] UEFI entry successfully appended to 40_custom.${NC}"
else
    echo -e "${YELLOW}[*] UEFI entry already exists in 40_custom. Skipping append.${NC}"
fi

echo -e "${BLUE}[*] Regenerating GRUB system config...${NC}"
if command -v update-grub &>/dev/null; then
    update-grub
elif command -v grub-mkconfig &>/dev/null; then
    if [ -f "/boot/efi/EFI/fedora/grub.cfg" ]; then
        grub-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    elif [ -f "/boot/grub/grub.cfg" ]; then
        grub-mkconfig -o /boot/grub/grub.cfg
    elif [ -f "/boot/grub2/grub.cfg" ]; then
        grub-mkconfig -o /boot/grub2/grub.cfg
    else
        echo -e "${RED}[-] Could not locate grub.cfg automatically. Please regenerate manually.${NC}"
    fi
else
    echo -e "${RED}[-] No GRUB update utility found. Please run your system's config update manually.${NC}"
fi

echo -e "${GREEN}[+] Success! GRUB entries cleaned up to match the ideal list.${NC}"
