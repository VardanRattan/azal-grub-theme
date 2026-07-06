# azal

A custom, poetic, and refined GRUB bootloader theme. 

Based on the [themeGrub.CyberEXS](https://github.com/HenriqueLopes42/themeGrub.CyberEXS) theme by [Henrique Lopes](https://github.com/HenriqueLopes42).

---

## 🌟 Features
* **Custom Branded Visuals**: Features a stunning, custom cyberpunk artwork background (1920x1080) featuring the **"azal 永遠"** digital branding.
* **Crimson Red Theme**: Designed with custom red selection borders and matching crimson red text indicators to align with the wallpaper.
* **Custom Typography**: Features high-legibility Terminus fonts for terminal views and Ubuntu Regular for boot options.
* **Rich Icon Set**: Includes an extensive directory of 80+ clean, modern icons for various Linux distributions, Windows, macOS, and utilities.

---

## 🛠️ Installation & Configuration

### Option 1: Automated Installation (Recommended)

Clone the repository and run the interactive installer script. The script automatically handles copying the files, backing up your GRUB configuration, and setting all parameters (GFXMODE, GFXPAYLOAD, OS Prober / Windows detection, default OS memory):

```bash
git clone https://github.com/HenriqueLopes42/themeGrub.CyberEXS.git azal-grub-theme
cd azal-grub-theme
sudo ./install.sh
```

Follow the menu prompts to:
1. **Install/Update** the `azal` theme.
2. **Uninstall** the theme and safely revert configurations.

---

### Option 2: Manual Installation & Configuration

If you prefer manual configuration step-by-step:

#### 1. Clone the theme
```bash
git clone https://github.com/HenriqueLopes42/themeGrub.CyberEXS.git azal-grub-theme
cd azal-grub-theme
```

#### 2. Create the themes directory and copy files
```bash
sudo mkdir -p /boot/grub/themes/azal
sudo cp -r * /boot/grub/themes/azal/
```

#### 3. Enable the Theme
Set the theme path in `/etc/default/grub`:
```bash
echo 'GRUB_THEME="/boot/grub/themes/azal/theme.txt"' | sudo tee -a /etc/default/grub
```

#### 4. Enable Windows & Dual Boot Detection
Allow GRUB to probe for other operating systems (like Windows):
```bash
echo 'GRUB_DISABLE_OS_PROBER=false' | sudo tee -a /etc/default/grub
```
*Note: Make sure `os-prober` is installed. On Arch/EndeavourOS:*
```bash
sudo pacman -S os-prober
```

#### 5. Remember the Last Selected/Booted OS
```bash
echo 'GRUB_DEFAULT=saved' | sudo tee -a /etc/default/grub
echo 'GRUB_SAVEDEFAULT=true' | sudo tee -a /etc/default/grub
```

#### 6. Configure Resolution and GFX Payload
Set the resolution to match the wallpaper (1920x1080) and preserve resolution for the kernel:
```bash
sudo sed -i 's/^GRUB_GFXMODE=.*/GRUB_GFXMODE="1920x1080,auto"/' /etc/default/grub
echo 'GRUB_GFXPAYLOAD_LINUX=keep' | sudo tee -a /etc/default/grub
```

#### 7. Regenerate GRUB Config
Apply the configuration changes:
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 📜 Credits & License
* This theme is a fork and customization of the original [themeGrub.CyberEXS](https://github.com/HenriqueLopes42/themeGrub.CyberEXS) theme.
* All credit for the base layout, box graphics, and style goes to the original author, **Henrique Lopes**.
* Original repository: [HenriqueLopes42/themeGrub.CyberEXS](https://github.com/HenriqueLopes42/themeGrub.CyberEXS)
