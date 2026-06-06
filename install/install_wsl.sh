#!/bin/bash
# ============================================================
#  OSINT Tools — Script d'installation WSL (Ubuntu/Debian)
# ============================================================

echo "========================================"
echo "   Installation des outils OSINT"
echo "========================================"

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y python3 python3-pip pipx git curl wget exiftool

pipx ensurepath
source ~/.bashrc

echo ""
echo "[1/8] Sherlock (username)"
pipx install sherlock-project

echo ""
echo "[2/8] Maigret (username avancé)"
pipx install maigret

echo ""
echo "[3/8] Holehe (email)"
pipx install holehe

echo ""
echo "[4/8] theHarvester (domaines/emails)"
pipx install theHarvester

echo ""
echo "[5/8] Photon (crawler web)"
pip3 install photon --break-system-packages 2>/dev/null || pipx install photon

echo ""
echo "[6/8] Recon-ng (framework)"
pipx install recon-ng

echo ""
echo "[7/8] Instaloader (Instagram)"
pipx install instaloader

echo ""
echo "[8/8] SpiderFoot (framework web UI)"
cd ~ && git clone https://github.com/smicallef/spiderfoot.git 2>/dev/null || true
cd ~/spiderfoot && pip3 install -r requirements.txt --break-system-packages 2>/dev/null

echo ""
echo "========================================"
echo "   Installation terminée !"
echo "   Lance 'source ~/.bashrc' si besoin"
echo "========================================"
