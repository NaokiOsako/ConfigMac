#!/bin/sh

apt-get install fontforge

wget http://levien.com/type/myfonts/Inconsolata.otf
mkdir ~/.fonts
cp -v Inconsolata.otf ~/.fonts

echo "\n\nMigu 1M also need in .fonts\n\n"

cd /tmp
git clone git://github.com/yascentur/Ricty.git

cd /tmp/Ricty
sh ricty_generator.sh auto

cp -v *.ttf ~/.fonts


