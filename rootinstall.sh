sed -i 's/^GRUB_DISTRIBUTOR="Arch"/GRUB_DISTRIBUTOR="TOS"/' /etc/default/grub
rm -rf /etc/issue /etc/os-release
echo "TOS Linux" > /etc/issue
printf 'NAME="Tos Linux"
PRETTY_NAME="Tos Linux"
ID=tos
BUILD_ID=rolling
ANSI_COLOR="0;36"
HOME_URL="https://tos.pbfp.xyz/"
LOGO=toslinux' > /etc/os-release

printf "[tos]\nSigLevel = Optional TrustAll\nServer = https://repo.pbfp.xyz\n" >> /etc/pacman.conf

systemctl enable NetworkManager
systemctl enable dhcpcd

