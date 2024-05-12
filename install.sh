echo "TZGML & Republic Of Lunar's NVIM | Installer"
echo -e "\e[35m1) Clean & mkdir\e[0m"
sudo mv -i ~/.config/nvim ~/.config/nvim.bak
echo -e "\e[35m2) Download init.lua\e[0m"
sudo git clone https://mirror.ghproxy.com/github.com/lunarlands/NeoVim.git ~/.config/nvim
echo -e "\e[35m3) Enjoy!\e[0m"
sudo nvim