# =============================================================================
# Pacmant
# =============================================================================
# pacmant is a basic script to install packages that aren't in the pacman
# mirrors but have otherwise been vetted and are trusted.
#
# pacmant builds packages from a PKGBUILD descriptions (like with the AUR)
#
# =============================================================================

export PACMANT_PACKAGES="$PWD/pkg"
sudo cp ./usr/bin/pacmant /usr/bin/pacmant; sudo chmod 755 /usr/bin/pacmant

# =============================================================================
# Terminal
# =============================================================================
# alacritty.toml configuration for oldschool 8x16 terminal font
#
# =============================================================================

pacmant oldschool-pc-fonts
sudo cp ./home/user/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

# =============================================================================
# Python
# =============================================================================
# Baseline venv configuration
#
# =============================================================================

python -m venv ~/.venv
source ~/.venv/bin/activate
pip install huckle
pip install build
pip install twine
pip install pytest
pip install gunicorn
if [ ! -f ~/Documents/workspace ]; then
    mkdir ~/Documents/workspace
fi
if [ ! -f ~/Documents/workspace/hcli ]; then
    mkdir ~/Documents/workspace/hcli
fi
if [ ! -f ~/Documents/workspace/hcli/huckle ]; then
    git clone https://github.com/cometaj2/huckle.git ~/Documents/workspace/hcli/huckle
fi
if [ ! -f ~/Documents/workspace/hcli/hcli_core ]; then
    git clone https://github.com/cometaj2/hcli_core.git ~/Documents/workspace/hcli/hcli_core
fi
if [ ! -f ~/Documents/workspace/hcli/hcli_hag ]; then
    git clone https://github.com/cometaj2/hcli_hag.git ~/Documents/workspace/hcli/hcli_hag
fi

# =============================================================================
# Vim
# =============================================================================
# Vim vundle installation for plugin management
#
# =============================================================================

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./home/user/.vimrc ~

# =============================================================================
# Terminal
# =============================================================================
# Baseline terminal configuration for development
#
# We update .bashrc to load the .bash_profile
#
# =============================================================================

cp ./home/user/.bash_profile ~
if [ ! -f ~/.gitconfig ]; then
    cp ./home/user/.gitconfig ~
fi

rm ~/.bashrc
touch ~/.bashrc
LINE_TO_ADD='source ~/.bash_profile'
BASHRC_FILE="$HOME/.bashrc"
if ! grep -qF "$LINE_TO_ADD" "$BASHRC_FILE"; then
    echo "$LINE_TO_ADD" >> "$BASHRC_FILE"
    echo "Line added to $BASHRC_FILE."
else
    echo "Line already exists in $BASHRC_FILE."
fi

source ~/.bash_profile

# =============================================================================
# WiFi
# =============================================================================
# Broadcom based WiFi on Macs
#
# A reboot may be required after removing modules and setting up wl
#
# =============================================================================

NETWORK=$(lspci -d 14e4::)
case "$NETWORK" in 
    *'Broadcom Inc.'*)
        echo ""
        echo "Found:"
        echo "$NETWORK"
        echo "Cleaning up after arch baseline..."
        echo ""

        sudo rmmod b43 2>/dev/null
        sudo rmmod bcma 2>/dev/null
        yes | sudo pacman -S --needed broadcom-wl
        sudo modprobe wl
        echo "hint: iwctl device list"
        echo "hint: iwctl station wlan0 connect <network>"
        echo ""
        ;;
esac

# =============================================================================
# Apps
# =============================================================================
# Removal of ozone-platform wayland flags which cause glitches in tiles; for both chromium and brave.
#
# mbp fan configuration is setup to help manage mac fan speed
#
# bindings.conf configuration is setup to cleanup key bindings and to allow remap
#
# =============================================================================

yay -Qs lazygit | grep local | awk '{print $1 " " $3}' | xargs yay -Rnc --noconfirm 2>/dev/null
yay -Qs neovim | grep local | awk '{print $1 " " $3}' | xargs yay -Rnc --noconfirm 2>/dev/null
yay -Qs lazydocker | grep local | awk '{print $1 " " $3}' | xargs yay -Rnc --noconfirm 2>/dev/null
yay -Qs 1password | grep local | awk '{print $1 " " $3}' | xargs yay -Rnc --noconfirm 2>/dev/null
yes | sudo pacman -S --needed vim
yes | sudo pacman -S --needed tar
yes | sudo pacman -S --needed pacman-contrib
yes | yay -S --needed brave-bin
pacmant keeper-password-manager

pacmant mbpfan
sudo cp ./etc/mbpfan.conf /etc/mbpfan.conf
sudo systemctl enable mbpfan
sudo systemctl start mbpfan

sudo cp ./home/user/.config/hypr/bindings.conf ~/.config/hypr/bindings.conf
sudo pacman -S usbutils
KEYBOARD=$(lsusb | grep Keyboard)
case "$KEYBOARD" in
    *'Primax Electronics, Ltd HP PR1101U / Primax PMX-KPR1101U Keyboard'*)
        echo "Swapping alt and windows key"
        STR="""input{\n
        kb_options = altwin:swap_alt_win\n
        }"""
        echo -e $STR >> ~/.config/hypr/bindings.conf
        ;;
    *)
        ;;
esac

sudo cp ./usr/bin/suc /usr/bin/suc; sudo chmod 755 /usr/bin/suc
sudo cp ./usr/bin/sup /usr/bin/sup; sudo chmod 755 /usr/bin/sup

# =============================================================================
# Graphics Configuration
# =============================================================================
# GPU switching app for MacBook Pro with hybrid graphics (e.g. MacBook Pro 9,1 2012 with integrated intel/NVIDIA graphics).
#
# -i switches the integrated card on and the dedicated card off (better battery life)
# -d switches the dedicated card on and the integrated card off (better performance). This fails.
# Requires a reboot after running the desired command for it to take effect.
#
# Some generic guidance for Intel Macs, https://dev.to/x1unix/archlinux-setup-guide-for-intel-macbook-pro-58b8
#
# iMac 2015 with [AMD/ATI] Pitcairn PRO [Radeon HD 7850 / R7 265 / R9 270 1024SP]
# Vulkan modprobe kernel configuration https://bbs.archlinux.org/viewtopic.php?id=299630
# mesa and vulkan-radeon supports it; amdvlk will cause conflict and should be uninstalled.
#
# Macbook Pro 2012 with:
# Kepler series NVIDIA Corporation GK107M [GeForce GT 650M Mac Edition] (rev a1)
#
# =============================================================================

# Graphics card activation display id and monitor information
yes | sudo pacman -S --needed inxi

GRAPHICS=$(lspci -d ::03xx)
case "$GRAPHICS" in 
    *'[AMD/ATI] Pitcairn PRO [Radeon HD 7850 / R7 265 / R9 270 1024SP]'*)
        echo ""
        echo "Found:"
        echo "$GRAPHICS"
        echo "Cleaning up after arch baseline..."
        echo ""

        sudo cp ./home/user/.config/brave-flags.conf ~/.config/brave-flags.conf
        sudo cp ./home/user/.config/chromium-flags.conf ~/.config/chromium-flags.conf
        yes | yay -Rns lib32-amdvlk 2>/dev/null
        yes | yay -Rns amdvlk 2>/dev/null
        yes | sudo pacman -S --needed lib32-vulkan-radeon
        yes | sudo pacman -S --needed vulkan-radeon
        yes | sudo pacman -S --needed mesa-utils
        yes | sudo pacman -S --needed vulkan-tools
        sudo cp ./etc/modprobe.d/amdgpu.conf /etc/modprobe.d/amdgpu.conf
        sudo cp ./etc/modprobe.d/radeon.conf /etc/modprobe.d/radeon.conf
        echo "hint: glxinfo"
        echo "hint: eglinfo"
        echo "hint: vulkaninfo"
        echo "hint: glxgears"
        echo "hint: eglgears_wayland"
        echo "hint: eglgears_x11"
        echo "hint: vkcube"
        echo ""

        inxi -Gxxxz
        echo ""

        sudo cp -r ./lib/firmware/* /lib/firmware/
        yes | sudo mkinitcpio -P
        echo "hint: reboot!"
        ;;
    *'Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09)'*|*'NVIDIA Corporation GK107M [GeForce GT 650M Mac Edition] (rev a1)'*)
        echo "Found:"
        echo "$GRAPHICS"
        echo "Cleaning up after arch baseline..."
        echo ""

        sudo cp ./home/user/.config/brave-flags.conf ~/.config/brave-flags.conf
        sudo cp ./home/user/.config/chromium-flags.conf ~/.config/chromium-flags.conf
        yay -Rdd --noconfirm nvidia-dkms 2>/dev/null
        yay -Rdd --noconfirm lib32-nvidia-utils 2>/dev/null
        yes | yay -S --needed nvidia-470xx-dkms
        yes | yay -S --needed lib32-nvidia-470xx-utils
        yes | sudo pacman -S --needed vulkan-tools
        yes | sudo pacman -S --needed mesa-utils
        sudo cp ./etc/modprobe.d/nvidia.conf /etc/modprobe.d/nvidia.conf
        sudo cp ./etc/modprobe.d/nvidia_drm.conf /etc/modprobe.d/nvidia_drm.conf
        echo "hint: glxinfo"
        echo "hint: eglinfo"
        echo "hint: vulkaninfo"
        echo "hint: glxgears"
        echo "hint: eglgears_wayland"
        echo "hint: eglgears_x11"
        echo "hint: vkcube"
        echo ""

        yes | yay -S --needed gpu-switch
        sudo gpu-switch -i  # works
        #sudo gpu-switch -d # doesn't work

        inxi -Gxxxz
        echo ""

        sudo cp -r ./lib/firmware/* /lib/firmware/
        yes | sudo mkinitcpio -P
        echo "hint: reboot!"
        ;;
    *)
        echo ""
        echo "Ignoring:"
        echo "$GRAPHICS"
        echo ""
        ;;
esac

# =============================================================================
# Steam
# =============================================================================
# If Steam seems to be running in the background but doesn't present a graphical interface, consider the following:
# For MacBook Pro 9,1 2012, with the integrated graphics card enabled, nvidia hyprland env parameters should be commented out and the machine rebooted.
#
# ~/.config/hypr/hyprland.conf
# # NVIDIA environment variables
# # env = NVD_BACKEND,direct
# # env = LIBVA_DRIVER_NAME,nvidia
# # env = __GLX_VENDOR_LIBRARY_NAME,nvidia
#
# Steam Don't Starve Together xwayland advanced configuration. Add the following configuration to DST's launch parameters
# SDL_VIDEODRIVER=x11 %command%
#
# =============================================================================

