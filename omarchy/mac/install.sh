########## ########## ########## ########## ##########
########## Python

# Python baseline venv configuration
python -m venv ~/.venv
source ~/.venv/bin/activate
pip install huckle

########## ########## ########## ########## ##########
########## Vim

# Vim vundle installation for plugin management
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/vundle.vim.git ~/.vim/bundle/Vundle.vim

########## ########## ########## ########## ##########
########## Terminal

# Baseline terminal configuration
cp ../../.bash_profile ~
cp ../../.vimrc ~
cp ../../.gitconfig ~

# we update .bashrc to load the .bash_profile
LINE_TO_ADD='source ~/.bash_profile'
BASHRC_FILE="$HOME/.bashrc"
if ! grep -qF "$LINE_TO_ADD" "$BASHRC_FILE"; then
    echo "$LINE_TO_ADD" >> "$BASHRC_FILE"
    echo "Line added to $BASHRC_FILE."
else
    echo "Line already exists in $BASHRC_FILE."
fi

source ~/.bash_profile

########## ########## ########## ########## ##########
########## Apps

# Removal of ozone-platform wayland flag, which causes glitches and replace chromium for brave.
#HYPRLAND_BINDINGS="~/.config/hypr/bindings.conf

yes | yay -R chromium
yes | yay -R lazygit
yes | yay -R neovim
yes | yay -R lazydocker-bin
yes | yay -R lazydocker-bin-debug
yes | yay -S brave-bin
yes | yay -S keeper-password-manager

# mbp fan configuration to help manage mac fan speed
yes | yay -S mbpfan
sudo cp ./etc/mbpfan.conf /etc/mbpfan.conf
sudo systemctl enable mbpfan
sudo systemctl start mbpfan

########## ########## ########## ########## ##########
########## Steam

# Steam Don't Starve Together xwayland advanced configuration add the following configuration to DST's launch
# SDL_VIDEODRIVER=x11
