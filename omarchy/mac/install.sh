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
cp ../../.vimrc ~

# =============================================================================
# Terminal
# =============================================================================
# Baseline terminal configuration for development
#
# We update .bashrc to load the .bash_profile
#
# =============================================================================

cp ../../.bash_profile ~
cp ../../.gitconfig ~

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
# =============================================================================

sudo rmmod b43
sudo rmmod bcma
yes | yay -S broadcom-wl
sudo modprobe wl
echo "hint: iwctl device list"
echo "hint: iwctl station wlan0 connect <network>"

# =============================================================================
# Apps
# =============================================================================
# Removal of ozone-platform wayland flag, which causes glitches and replace chromium for brave.
# HYPRLAND_BINDINGS="~/.config/hypr/bindings.conf
#
# mbp fan configuration is setup to help manage mac fan speed
#
# bindings.conf configuration is setup to cleanup key bindings and to allow remap
#
# =============================================================================

yes | yay -R chromium
yes | yay -R lazygit
yes | yay -R neovim
yes | yay -R lazydocker-bin
yes | yay -R lazydocker-bin-debug
yes | yay -S brave-bin
yes | yay -S keeper-password-manager
yes | yay -S bottles

yes | yay -S mbpfan
sudo cp ./etc/mbpfan.conf /etc/mbpfan.conf
sudo systemctl enable mbpfan
sudo systemctl start mbpfan

sudo cp ./home/user/.config/hypr/bindings.conf ~/.config/hypr/bindings.conf

# =============================================================================
# GPU switching
# =============================================================================
# GPU switching app for MacBook Pro with hybrid graphics (e.g. MacBook Pro 9,1 2012 with integrated intel/NVIDIAi graphics).
#
# =============================================================================

# -i switches the integrated card on and the dedicated card off (better battery life)
# -d switches the dedicated card on and the integrated card off (better performance). This fails.
# Requires a reboot after running the desired command for it to take effect.
yes | yay -S gpu-switch
#sudo gpu-switch -i
#sudo gpu-switch -d

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

