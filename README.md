# azal GRUB Theme

A clean, custom red-and-black GRUB bootloader theme.

This is a fork of [themeGrub.CyberEXS](https://github.com/HenriqueLopes42/themeGrub.CyberEXS) by [Henrique Lopes](https://github.com/HenriqueLopes42), modified to fit my personal setup.

## Features
- **Custom Background**: 1920x1080 wallpaper featuring the word "azal" written in English, Punjabi (Gurmukhi), and Shahmukhi.
- **Red Accents**: Selection boxes and text highlights are changed to a deep red to match the background.
- **Fonts**: Uses Terminus for the terminal output and Ubuntu Regular for the boot menu.
- **Icons**: Includes over 80 icons covering most Linux distros, Windows, and utilities.

## Installation

### Automated script (Recommended)
You can use the provided script to automatically install the theme, back up your current GRUB config, and apply the correct settings (like setting the resolution to 1080p and enabling os-prober for dual boot).

```bash
git clone https://github.com/VardanRattan/azal-grub-theme.git
cd azal-grub-theme
sudo ./install.sh
```

### Manual setup
If you'd rather do it yourself:

1. Clone the repo:
   ```bash
   git clone https://github.com/VardanRattan/azal-grub-theme.git
   cd azal-grub-theme
   ```

2. Copy the theme files:
   ```bash
   sudo mkdir -p /boot/grub/themes/azal
   sudo cp -r *.png *.pf2 *.txt icons/ /boot/grub/themes/azal/
   ```

3. Update `/etc/default/grub` with these settings:
   ```bash
   GRUB_THEME="/boot/grub/themes/azal/theme.txt"
   GRUB_GFXMODE="1920x1080,auto"
   GRUB_GFXPAYLOAD_LINUX="keep"
   GRUB_DISABLE_OS_PROBER="false"
   GRUB_DEFAULT="saved"
   GRUB_SAVEDEFAULT="true"
   ```

4. Regenerate your GRUB config:
   ```bash
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```

## Credits
- Based heavily on [themeGrub.CyberEXS](https://github.com/HenriqueLopes42/themeGrub.CyberEXS) by Henrique Lopes.
