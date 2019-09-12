
cd
sudo pacman -Syu --noconfirm git
git clone https://aur.archlinux.org/yay.git
cd yay
yes | makepkg -si
cd
rm -rf yay
