echo "TZGML & Republic Of Lunar's NVIM | Installer"
echo "This script will run after 3 second. (Ctrl+C EXIT)"
sleep 3
echo "1) Clean & mkdir"
sudo mv -i ~/.config/nvim ~/.config/nvim.bak
sudo mkdir ~/.config/nvim
echo "2) Download init.lua"
sudo curl https://raw.githubusercontent.com/lunarlands/NeoVim/main/init.lua >> ~/.config/nvim/init.lua
echo "3) Enjoy!"
nvim