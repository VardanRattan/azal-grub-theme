#!/usr/bin/env bash
#
# azal GRUB Theme Installer / Uninstaller
# Custom, poetic, and refined GRUB bootloader theme installer.
#

set -e

THEME_NAME="azal"
THEME_DIR="/boot/grub/themes/${THEME_NAME}"
GRUB_DEFAULT="/etc/default/grub"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Print banner
print_banner() {
    echo -e "${RED}"
    echo '    ___   _____  ___    __   '
    echo '   /   | /__  / /   |  / /   '
    echo '  / /| |   / / / /| | / /    '
    echo ' / ___ |  / /_/ ___ |/ /___  '
    echo '/_/  |_| /___/_/  |_/_____/  '
    echo -e "       Custom GRUB Theme Installer${NC}\n"
}

# Root permission check
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Error: This script must be run as root (or with sudo).${NC}"
        echo -e "Please run: ${YELLOW}sudo $0${NC}"
        exit 1
    fi
}

# Backup GRUB config file
backup_grub_config() {
    local backup_file="${GRUB_DEFAULT}.bak.$(date +%Y%m%d_%H%M%S)"
    echo -e "${BLUE}[*] Creating backup of ${GRUB_DEFAULT}...${NC}"
    cp "${GRUB_DEFAULT}" "$backup_file"
    echo -e "${GREEN}[+] Backup created successfully at ${backup_file}${NC}"
}

# Update or insert variables in /etc/default/grub
update_config_var() {
    local key="$1"
    local val="$2"
    local file="$3"
    
    if grep -q "^[[:space:]]*${key}=" "$file"; then
        sed -i "s|^[[:space:]]*${key}=.*|${key}=\"${val}\"|" "$file"
    elif grep -q "^[[:space:]]*#[[:space:]]*${key}=" "$file"; then
        sed -i "s|^[[:space:]]*#[[:space:]]*${key}=.*|${key}=\"${val}\"|" "$file"
    else
        echo "${key}=\"${val}\"" >> "$file"
    fi
}

# Comment out variables in /etc/default/grub to disable them
comment_config_var() {
    local key="$1"
    local file="$2"
    
    if grep -q "^[[:space:]]*${key}=" "$file"; then
        sed -i "s|^[[:space:]]*${key}=|#${key}=|" "$file"
        echo -e "${BLUE}[*] Commented out ${key} in ${file}${NC}"
    fi
}

# Run grub updater tool depending on distribution
update_grub_system() {
    echo -e "\n${BLUE}[*] Updating GRUB system config...${NC}"
    
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
            echo -e "${YELLOW}[!] Warning: Found grub-mkconfig but could not locate grub.cfg automatically.${NC}"
            echo -e "Please run manually: ${CYAN}sudo grub-mkconfig -o /path/to/grub.cfg${NC}"
        fi
    elif command -v grub2-mkconfig &>/dev/null; then
        if [ -f "/boot/grub2/grub.cfg" ]; then
            grub2-mkconfig -o /boot/grub2/grub.cfg
        elif [ -f "/boot/efi/EFI/fedora/grub.cfg" ]; then
            grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        else
            echo -e "${YELLOW}[!] Warning: Found grub2-mkconfig but could not locate grub.cfg automatically.${NC}"
            echo -e "Please run manually: ${CYAN}sudo grub2-mkconfig -o /path/to/grub.cfg${NC}"
        fi
    else
        echo -e "${RED}[-] Error: No GRUB update utility found (update-grub/grub-mkconfig).${NC}"
        echo -e "Please run your system's GRUB configuration update command manually."
        return 1
    fi
    echo -e "${GREEN}[+] GRUB system configuration updated successfully!${NC}"
}

# Installation Logic
install_theme() {
    echo -e "${CYAN}[1/3] Copying theme files to system...${NC}"
    
    # Ensure grub themes directory exists
    mkdir -p "/boot/grub/themes"
    
    # Remove older version if exists to prevent mixing files
    if [ -d "$THEME_DIR" ]; then
        echo -e "${YELLOW}[*] Removing existing theme folder at ${THEME_DIR}...${NC}"
        rm -rf "$THEME_DIR"
    fi
    
    # Copy files
    mkdir -p "$THEME_DIR"
    cp -a "${SCRIPT_DIR}"/*.png \
          "${SCRIPT_DIR}"/*.pf2 \
          "${SCRIPT_DIR}"/*.txt \
          "${SCRIPT_DIR}/icons" \
          "$THEME_DIR/"
          
    echo -e "${GREEN}[+] Theme files copied to ${THEME_DIR}${NC}"
    
    echo -e "\n${CYAN}[2/3] Configuring GRUB settings in ${GRUB_DEFAULT}...${NC}"
    backup_grub_config
    
    # Update GRUB_THEME path
    update_config_var "GRUB_THEME" "${THEME_DIR}/theme.txt" "$GRUB_DEFAULT"
    echo -e "${GREEN}[+] Set GRUB_THEME to ${THEME_DIR}/theme.txt${NC}"
    
    # Adjust GFXMODE to match wallpaper resolution (1920x1080)
    update_config_var "GRUB_GFXMODE" "1920x1080,auto" "$GRUB_DEFAULT"
    echo -e "${GREEN}[+] Set GRUB_GFXMODE to 1920x1080,auto${NC}"

    # Set GFXPAYLOAD to keep to ensure resolution is preserved
    update_config_var "GRUB_GFXPAYLOAD_LINUX" "keep" "$GRUB_DEFAULT"
    echo -e "${GREEN}[+] Set GRUB_GFXPAYLOAD_LINUX to keep${NC}"

    # Enable Windows and other OS detection
    update_config_var "GRUB_DISABLE_OS_PROBER" "false" "$GRUB_DEFAULT"
    echo -e "${GREEN}[+] Set GRUB_DISABLE_OS_PROBER to false${NC}"

    # Remember the last booted OS selection
    update_config_var "GRUB_DEFAULT" "saved" "$GRUB_DEFAULT"
    update_config_var "GRUB_SAVEDEFAULT" "true" "$GRUB_DEFAULT"
    echo -e "${GREEN}[+] Configured GRUB to remember last selected OS (default=saved, savedefault=true)${NC}"

    # Check for os-prober installation
    if ! command -v os-prober &>/dev/null; then
        echo -e "${YELLOW}[!] Warning: os-prober is not installed. Dual boot detection may not work.${NC}"
        if command -v pacman &>/dev/null; then
            read -p "Would you like to install os-prober using pacman? [y/N]: " install_osp
            if [[ "$install_osp" =~ ^[Yy]$ ]]; then
                pacman -S --noconfirm os-prober
            fi
        elif command -v apt-get &>/dev/null; then
            read -p "Would you like to install os-prober using apt? [y/N]: " install_osp
            if [[ "$install_osp" =~ ^[Yy]$ ]]; then
                apt-get update && apt-get install -y os-prober
            fi
        elif command -v dnf &>/dev/null; then
            read -p "Would you like to install os-prober using dnf? [y/N]: " install_osp
            if [[ "$install_osp" =~ ^[Yy]$ ]]; then
                dnf install -y os-prober
            fi
        fi
    else
        echo -e "${GREEN}[+] os-prober is already installed.${NC}"
    fi
    
    # Update GRUB
    update_grub_system
    
    echo -e "\n${GREEN}==================================================${NC}"
    echo -e "${GREEN}🎉 installation complete! azal theme is now active.${NC}"
    echo -e "${GREEN}==================================================${NC}"
}

# Uninstall Logic
uninstall_theme() {
    echo -e "${CYAN}[1/2] Disabling theme configuration...${NC}"
    backup_grub_config
    
    comment_config_var "GRUB_THEME" "$GRUB_DEFAULT"
    echo -e "${GREEN}[+] Commented out GRUB_THEME configuration.${NC}"
    
    # Optionally reset GFXMODE if desired, but we'll leave it as auto
    update_config_var "GRUB_GFXMODE" "auto" "$GRUB_DEFAULT"
    echo -e "${GREEN}[+] Reset GRUB_GFXMODE to auto${NC}"
    
    # Update GRUB
    update_grub_system
    
    echo -e "\n${CYAN}[2/2] Removing theme files...${NC}"
    if [ -d "$THEME_DIR" ]; then
        rm -rf "$THEME_DIR"
        echo -e "${GREEN}[+] Removed ${THEME_DIR}${NC}"
    else
        echo -e "${YELLOW}[*] Theme files directory not found. Skipping deletion.${NC}"
    fi
    
    echo -e "\n${GREEN}==================================================${NC}"
    echo -e "${GREEN}🎉 Uninstallation complete! GRUB reset to default.${NC}"
    echo -e "${GREEN}==================================================${NC}"
}

# Main Execution Flow
main() {
    print_banner
    check_root
    
    echo -e "What would you like to do?"
    echo -e "  ${RED}1)${NC} Install/Update the ${RED}azal${NC} GRUB Theme"
    echo -e "  ${RED}2)${NC} Uninstall the ${RED}azal${NC} GRUB Theme"
    echo -e "  ${RED}3)${NC} Exit"
    echo
    read -p "Select option [1-3]: " opt
    
    case $opt in
        1)
            install_theme
            ;;
        2)
            uninstall_theme
            ;;
        3)
            echo -e "${CYAN}Exiting. No changes made.${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option selected. Exiting.${NC}"
            exit 1
            ;;
    esac
}

main "$@"
