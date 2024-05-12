echo "TZGML & Republic Of Lunar's NVIM | Installer"
echo "This script will run after 3 second. (Ctrl+C EXIT)"
sleep 3
echo "1) Clean & mkdir"
sudo mv -i ~/.config/nvim ~/.config/nvim.bak
echo "2) Download init.lua"
sudo git clone https://mirror.ghproxy.com/github.com/lunarlands/NeoVim.git ~/.config/nvim
echo "3) Enjoy!"
sudo nvim