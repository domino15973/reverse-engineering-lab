#!/bin/bash

set -e

echo "[1] System update..."
sudo apt update && sudo apt upgrade -y

echo "[2] Install Java..."
sudo apt install -y openjdk-17-jdk

echo "[3] Install unzip/zip..."
sudo apt install -y unzip zip

echo "[4] Install ADB tools..."
sudo apt install -y android-tools-adb android-tools-fastboot

echo "[5] Install AAPT (Android build-tools)..."
mkdir -p ~/Android
cd ~/Android
if [[ ! -f "build-tools_r34-linux.zip" ]]; then
    wget https://dl.google.com/android/repository/build-tools_r34-linux.zip
fi
unzip -o build-tools_r34-linux.zip -d build-tools

echo 'export PATH=$HOME/Android/build-tools/android-14:$PATH' >> ~/.bashrc
source ~/.bashrc

sudo ln -sf $HOME/Android/build-tools/android-14/aapt /usr/local/bin/aapt
sudo ln -sf $HOME/Android/build-tools/android-14/aapt2 /usr/local/bin/aapt2

echo "[6] Install APKTool..."
cd ~/Android
if [[ ! -f apktool.jar ]]; then
    wget https://github.com/iBotPeaches/Apktool/releases/download/v2.9.3/apktool_2.9.3.jar -O apktool.jar
fi
wget -O apktool https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
chmod +x apktool
sudo mv apktool /usr/local/bin/
sudo mv apktool.jar /usr/local/bin/

echo "[7] Install JADX..."
cd ~

if [[ ! -f "jadx-1.5.1.zip" ]]; then
    wget https://github.com/skylot/jadx/releases/download/v1.5.1/jadx-1.5.1.zip
fi

sudo mkdir -p /opt/jadx

rm -rf ~/jadx-temp
mkdir ~/jadx-temp
unzip -o jadx-1.5.1.zip -d ~/jadx-temp

sudo rm -rf /opt/jadx/* 
sudo cp -r ~/jadx-temp/* /opt/jadx/

sudo ln -sf /opt/jadx/bin/jadx /usr/local/bin/jadx
sudo ln -sf /opt/jadx/bin/jadx-gui /usr/local/bin/jadx-gui

rm -rf ~/jadx-temp


echo "[8] Install Frida..."
sudo apt install -y python3 python3-pip python3-venv pipx

pipx ensurepath

pipx install frida-tools

python3 -m venv ~/.frida-env
~/.frida-env/bin/pip install frida

if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
fi

echo "[9] Extra utilities..."
sudo apt install -y binutils coreutils net-tools python3-pycryptodome

echo "[10] Install SQLite3..."
sudo apt install -y sqlite3

echo "-----------------------------------------"
echo " All reverse-engineering tools installed."
echo "-----------------------------------------"

