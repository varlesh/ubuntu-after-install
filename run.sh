echo "Remove packages"
sudo apt purge apport* firefox* gnome-mines gnome-sudoku aisleriot gnome-mahjongg gnome-music rhythmbox totem* vim-tiny vim-common
sudo apt autoremove

echo "Upgrade system"
sudo apt update
sudo apt dist-upgrade

echo "Download and install Google Chrome"
cd /tmp
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f

echo "Download and install Telegram"
cd /tmp
wget -c https://updates.tdesktop.com/tlinux/tsetup.1.1.7.tar.xz
tar -xf tsetup*
mkdir -p ~/.local/share/TelegramDesktop/
cp -R Telegram ~/.local/share/TelegramDesktop/
timeout 10s ~/.local/share/TelegramDesktop/Telegram/Telegram

echo "Download and install WebTorrent Desktop"
cd /tmp
wget -c https://github.com/webtorrent/webtorrent-desktop/releases/download/v0.18.0/webtorrent-desktop_0.18.0-1_amd64.deb
sudo dpkg -i webtorrent-*.deb
sudo apt install -f

echo "Add repos"
sudo add-apt-repository ppa:papirus/papirus
sudo add-apt-repository ppa:gnumdk/lollypop
sudo add-apt-repository ppa:andreas-angerer89/sni-qt-patched
sudo add-apt-repository ppa:webupd8team/indicator-kdeconnect
sudo apt update

echo "Install packages"
sudo apt install gnome-tweak-tool ubuntu-restricted-extras p7zip-full synaptic apt-xapian-index gdebi gnome-mpv caffeine lollypop geary inkscape gimp imagemagick papirus-icon-theme arc-theme hardcode-tray sni-qt dnsmasq indicator-kdeconnect npm nodejs-legacy git curl

echo "Install npm and SVGO"
sudo npm install -g npm svgo

echo "Install Gnome extensions"
# "https://extensions.gnome.org/extension-info/?pk=759&shell_version=3.24
cd /tmp
mkdir -p ~/.local/share/gnome-shell/extensions

wget -O TopIcons@phocean.net.zip "https://extensions.gnome.org/download-extension/TopIcons@phocean.net.shell-extension.zip?version_tag=6608"
unzip TopIcons@phocean.net.zip -d ~/.local/share/gnome-shell/extensions/TopIcons@phocean.net

wget -O nohotcorner@azuri.free.fr.zip "https://extensions.gnome.org/download-extension/nohotcorner@azuri.free.fr.shell-extension.zip?version_tag=6820"
unzip nohotcorner@azuri.free.fr.zip -d ~/.local/share/gnome-shell/extensions/nohotcorner@azuri.free.fr

wget -O disable-screenshield@lgpasquale.com.zip "https://extensions.gnome.org/download-extension/disable-screenshield@lgpasquale.com.shell-extension.zip?version_tag=6351"
unzip disable-screenshield@lgpasquale.com.zip -d ~/.local/share/gnome-shell/extensions/disable-screenshield@lgpasquale.com

wget -O sound-output-device-chooser@kgshank.net.zip "https://extensions.gnome.org/download-extension/sound-output-device-chooser@kgshank.net.shell-extension.zip?version_tag=6352"
unzip sound-output-device-chooser@kgshank.net.zip -d ~/.local/share/gnome-shell/extensions/sound-output-device-chooser@kgshank.net

wget -O bettervolume@tudmotu.com.zip "https://extensions.gnome.org/download-extension/bettervolume@tudmotu.com.shell-extension.zip?version_tag=6791"
unzip bettervolume@tudmotu.com.zip -d ~/.local/share/gnome-shell/extensions/bettervolume@tudmotu.com

wget -O dash-to-panel@jderose9.github.com.zip "https://extensions.gnome.org/download-extension/dash-to-panel@jderose9.github.com.shell-extension.zip?version_tag=6703"
unzip dash-to-panel@jderose9.github.com.zip -d ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com

wget -O arc-menu@linxgem33.com.zip "https://extensions.gnome.org/download-extension/arc-menu@linxgem33.com.shell-extension.zip?version_tag=6928"
unzip arc-menu@linxgem33.com.zip -d ~/.local/share/gnome-shell/extensions/arc-menu@linxgem33.com

wget -O openweather-extension@jenslody.de.zip "https://extensions.gnome.org/download-extension/openweather-extension@jenslody.de.shell-extension.zip?version_tag=6784"
unzip openweather-extension@jenslody.de.zip -d ~/.local/share/gnome-shell/extensions/openweather-extension@jenslody.de

wget -O panel-osd@berend.de.schouwer.gmail.com.zip "https://extensions.gnome.org/download-extension/panel-osd@berend.de.schouwer.gmail.com.shell-extension.zip?version_tag=6639"
unzip panel-osd@berend.de.schouwer.gmail.com.zip -d ~/.local/share/gnome-shell/extensions/panel-osd@berend.de.schouwer.gmail.com

echo "Configure Gnome"
sudo sed -i 's/white/#d3dae3/g' /usr/share/themes/Arc-Dark/gnome-shell/gnome-shell.css
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
gsettings set org.gnome.shell.extensions.user-theme name Arc-Dark
gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface enable-animations false

echo "Download OSX Theme and fix workspace indicator"
cd /tmp
git clone https://github.com/varlesh/ubuntu-after-install.git
sudo cp -R ubuntu-after-install/OSX /usr/share/themes
sudo cp ubuntu-after-install/workspace-indicator-fix/stylesheet.css /usr/share/gnome-shell/extensions/workspace-indicator@gnome-shell-extensions.gcampax.github.com/

echo "Fix hardcode tray icons"
hardcode-tray --update-git
hardcode-tray --theme Papirus-Dark --size 22 --conversion-tool Inkscape

echo "Fix hardcode apps icons"
cd /tmp
wget https://raw.githubusercontent.com/varlesh/hardcode-fixer/master/fix.sh
sudo bash fix.sh

echo "Fix StartupWMClass"
cd /tmp
wget https://raw.githubusercontent.com/bil-elmoussaoui/StartupWMClassFixer/master/fix
sudo bash fix
cd

notify-send "Ubuntu After Install" "Finished" -t 15
