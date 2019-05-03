# Home dizininde `rm -rf *` yazılması durumuna çözümdür
# ~ YEmreAk
cd ~
mkdir Downloads Templates Shares Documents Musics Pictures Videos Desktop
echo '# This file is written by xdg-user-dirs-update' > ~/.config/user-dirs.dirs
echo '# If you want to change or add directories, just edit the line you are' >> ~/.config/user-dirs.dirs
echo '# interested in. All local changes will be retained on the next run.' >> ~/.config/user-dirs.dirs
echo '# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped' >> ~/.config/user-dirs.dirs
echo '# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an' >> ~/.config/user-dirs.dirs
echo '# absolute path. No other format is supported.' >> ~/.config/user-dirs.dirs
echo '# YEmreAk' >> ~/.config/user-dirs.dirs
echo 'XDG_DOWNLOAD_DIR="$HOME/Downloads"' >> ~/.config/user-dirs.dirs
echo 'XDG_TEMPLATES_DIR="$HOME/Templates"' >> ~/.config/user-dirs.dirs
echo 'XDG_PUBLICSHARE_DIR="$HOME/Shares"' >> ~/.config/user-dirs.dirs
echo 'XDG_DOCUMENTS_DIR="$HOME/Documents"' >> ~/.config/user-dirs.dirs
echo 'XDG_MUSIC_DIR="$HOME/Musics"' >> ~/.config/user-dirs.dirs
echo 'XDG_PICTURES_DIR="$HOME/Pictures"' >> ~/.config/user-dirs.dirs
echo 'XDG_VIDEOS_DIR="$HOME/Videos"' >> ~/.config/user-dirs.dirs
echo 'XDG_DESKTOP_DIR="$HOME/Desktop"' >> ~/.config/user-dirs.dirs
xdg-user-dirs-update