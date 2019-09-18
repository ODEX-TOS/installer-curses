
cd
rm -rf .config
git clone https://github.com/ODEX-TOS/dotfiles .config
sed -i 's;/home/zeus;'$HOME';g' $HOME/.config/i3/config
sed -i 's;/home/zeus;'$HOME';g' $HOME/.config/sway/config
#setup firefox
mkdir -p $HOME/.mozilla/firefox/tos.default
cp $HOME/.config/tos/profiles.ini $HOME/.mozilla/firefox/profiles.ini
cp -r $HOME/.config/tos/tos-firefox/* $HOME/.mozilla/firefox/tos.default

yay -Syu --noconfirm zsh
sudo chsh $USER -s /bin/zsh
rm -rf $HOME/.oh-my.zsh
curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o install.sh
export RUNZSH=no
export ZSH=$HOME/.oh-my-zsh
sh install.sh
rm install.sh
rm $HOME/.zshrc $HOME/.vimrc $HOME/.profile

ln .config/.zshrc $HOME/.zshrc
ln .config/.profile $HOME/.profile
ln .config/.vimrc $HOME/.vimrc
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
ln .config/.Xresources $HOME/.Xresources
mkdir -p $HOME/.icons/default
ln .config/index.theme $HOME/.icons/default/index.theme
git clone https://github.com/ODEX-TOS/zsh-load $HOME/.oh-my-zsh/load
cd
rmdir Pictures
git clone https://github.com/ODEX-TOS/Pictures Pictures

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/denysdovhan/spaceship-prompt.git ~/.oh-my-zsh/custom/themes/spaceship-prompt
ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme

curl https://github.com/ODEX-TOS/tools/blob/master/_tos -o  ~/.oh-my-zsh/custom/plugins/zsh-completions

printf "xrdb ~/.Xresources\nexec i3" >> ~/.xinitrc

mkdir -p ~/.vim/colors
curl https://bitbucket.org/sjl/badwolf/raw/tip/colors/badwolf.vim > ~/.vim/colors/badwolf.vim
#installing vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#Cloning plugin
git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
sudo sh -c 'curl https://raw.githubusercontent.com/ODEX-TOS/tos-live/master/toslive/version-edit.txt > /etc/version'


sudo systemctl enable bluetooth
sudo systemctl enable sshd
