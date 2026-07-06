# azal GRUB theme

A clean, dark, ink-wash inspired theme for GRUB. I built this because I wanted a boot screen that feels calm and stays out of the way. 

## What's included
- **Dark, matte background**: A custom 1080p wallpaper that isn't blinding at night.
- **Soft accents**: Highlights use a muted indigo with aged-paper text. No harsh pure whites or neon colors.
- **Good fonts**: Uses Terminus for the terminal and Ubuntu Regular for the boot menu. It just works.
- **Lots of icons**: Over 80 icons covering pretty much any distro (and Windows).

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

This theme is a fork and heavy modification of [themeGrub.CyberEXS](https://github.com/HenriqueLopes42/themeGrub.CyberEXS) by Henrique Lopes. I retained the structure and the extensive icon pack from the original project while entirely overhauling the visual design, colors, and background to fit my personal setup.

