# =============================================================================
# Python
# =============================================================================
# Baseline venv configuration
#
# =============================================================================

python -m venv ~/.venv
source ~/.venv/bin/activate
pip install huckle

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
cp ./home/user/.gitconfig ~

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

sudo rmmod b43 2>/dev/null
sudo rmmod bcma 2>/dev/null
yes | yay -S --needed broadcom-wl
sudo modprobe wl
echo "hint: iwctl device list"
echo "hint: iwctl station wlan0 connect <network>"

# =============================================================================
# Apps
# =============================================================================
# Removal of ozone-platform wayland flags which cause glitches in tiles; for both chromium and brave.
#
# mbp fan configuration is setup to help manage mac fan speed
#
# bindings.conf configuration is setup to cleanup key bindings and to allow remap
# alacritty.toml configuration for oldschool 8x16 terminal font
#
# =============================================================================

yes | yay -Rns chromium 2>/dev/null
yes | yay -Rns lazygit 2>/dev/null
yes | yay -Rns neovim 2>/dev/null
yes | yay -Rns lazydocker-bin 2>/dev/null
yes | yay -Rns lazydocker-bin-debug 2>/dev/null
yes | yay -Rns 1password 2>/dev/null
yes | yay -S --needed vim
yes | yay -S --needed brave-bin
yes | yay -S --needed keeper-password-manager
yes | yay -S --needed bottles
yes | yay -S --needed oldschool-pc-fonts
yes | yay -S --needed balena-etcher

yes | yay -S --needed mbpfan
sudo cp ./etc/mbpfan.conf /etc/mbpfan.conf
sudo systemctl enable mbpfan
sudo systemctl start mbpfan

sudo cp ./home/user/.config/hypr/bindings.conf ~/.config/hypr/bindings.conf
sudo cp ./home/user/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
sudo cp ./home/user/.config/brave-flags.conf ~/.config/brave-flags.conf
sudo cp ./home/user/.config/chromium-flags.conf ~/.config/chromium-flags.conf

# =============================================================================
# Graphics Configuration
# =============================================================================
# GPU switching app for MacBook Pro with hybrid graphics (e.g. MacBook Pro 9,1 2012 with integrated intel/NVIDIA graphics).
#
# -i switches the integrated card on and the dedicated card off (better battery life)
# -d switches the dedicated card on and the integrated card off (better performance). This fails.
# Requires a reboot after running the desired command for it to take effect.
#
# iMac 2015 with AMD Radeon HD7850 Vulkan Configuration https://bbs.archlinux.org/viewtopic.php?id=299630
# mesa and vulkan-radeon supports it. amdvlk will cause conflict if installed.
#
#
# =============================================================================

yes | yay -S --needed gpu-switch
#sudo gpu-switch -i
#sudo gpu-switch -d

GRAPHICS=$(lspci -d ::03xx)
case "$GRAPHICS" in 
    *'[AMD/ATI] Pitcairn PRO [Radeon HD 7850 / R7 265 / R9 270 1024SP]'*)
        echo "Found: $GRAPHICS"
        echo "Cleaning up after steam..."
        yes | yay -Rns lib32-amdvlk 2>/dev/null
        yes | yay -Rns amdvlk 2>/dev/null
        yes | yay -S --needed lib32-vulkan-radeon
        yes | yay -S --needed vulkan-radeon
        yes | yay -S --needed mesa-utils
        yes | yay -S --needed vulkan-tools
        echo "hint: vulkaninfo"
        echo "hint: vkcube"
        echo "hint: glxgears"

        sudo cp ./etc/modprobe.d/amdgpu.conf /etc/modprobe.d/amdgpu.conf
        sudo cp ./etc/modprobe.d/radeon.conf /etc/modprobe.d/radeon.conf

        sudo mkinitcpio -P
        echo "hint: reboot!"
        ;;
    *)
        echo "Ignoring: $GRAPHICS"
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

