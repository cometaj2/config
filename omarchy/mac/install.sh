# Python baseline venv configuration
python -m venv ~/.venv
source ~/.venv/bin/activate
pip install huckle

# Vim vundle installation for plugin management
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/vundle.vim.git ~/.vim/bundle/Vundle.vim

# Baseline terminal configuration
cp ../../.bash_profile ~
cp ../../.vimrc ~
cp ../../.gitconfig ~

source ~/.bash_profile

# Removal of ozone-platform wayland flag, which causes glitches and replace chromium for brave.
#HYPRLAND_BINDINGS="~/.config/hypr/bindings.conf

yes | yay -R chromium
yes | yay -S brave-bin
yes | yay -S keeper-password-manager

# mbp fan configuration to help manage mac fan speed
yes | yay -S mbpfan
sudo cp ./etc/mbpfan.conf /etc/mbpfan.conf
sudo systemctl enable mbpfan
sudo systemctl start mbpfan

# Steam Don't Starve Together xwayland advanced configuration add the following configuration to DST's launch
# SDL_VIDEODRIVER=x11
