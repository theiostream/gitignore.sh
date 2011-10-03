#!/bin/bash

echo "[gitignore = setup.sh] Making directory..."
mkdir -p ~/Library/gitignore

echo "[gitignore = setup.sh] Setting permissions..."
chmod 4755 ~/Library/gitignore
chmod 4755 ./gitignore.sh

echo "[gitignore - setup.sh] Moving files..."
cp -v ./gitignore.sh /usr/bin

cd ~/Library/

echo "[gitignore - setup.sh] Cloning Repo..."
git clone git://github.com/github/gitignore.git

echo "[gitignore - setup.sh] Doing tiny adjustements to fit needs..."
mv -v ./gitignore/Global/* ./gitignore
rm -rf ./Global

echo "[gitignore - setup.sh] Done."
