#!/bin/sh
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

C='\033[0;36m'; M='\033[0;35m'; G='\033[0;32m'
R='\033[0;31m'; Y='\033[1;33m'; B='\033[1m'; N='\033[0m'

show_header() {
    printf "${C}${B}"
    printf "\n"
    printf "    .:ckdddddocccccccccc\n"
    printf "  .:ckdOOOOOOOdlcccccccccccllc\n"
    printf "  ;kdOOOOddOOOdkolccccccccccccccccc\n"
    printf "  .cOOOddOOOddkllccccccccccccccccccc\n"
    printf "   ;dOdOOOOklccccccccccccccccccccccc\n"
    printf "${N}\n"
    printf "${M}${B}"
    printf "  ██╗  ██╗██╗██████╗ ██╗████████╗ ██████╗ \n"
    printf "  ██║ ██╔╝██║██╔══██╗██║╚══██╔══╝██╔═══██╗\n"
    printf "  █████╔╝ ██║██████╔╝██║   ██║   ██║   ██║\n"
    printf "  ██╔═██╗ ██║██╔══██╗██║   ██║   ██║   ██║\n"
    printf "  ██║  ██╗██║██║  ██║██║   ██║   ╚██████╔╝\n"
    printf "  ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═╝   ╚═╝    ╚═════╝ \n"
    printf "${N}\n"
    printf "${C}${B}"
    printf "  +------------------------------------------+\n"
    printf "  |       OSINT TOOLKIT  --  v1.0            |\n"
    printf "  |       by kiritogmre                      |\n"
    printf "  +------------------------------------------+\n"
    printf "${N}\n"
}

show_menu() {
    printf "  ${B}${G}[ 1 ]${N}  Installer tous les outils\n"
    printf "  ${B}${C}[ 2 ]${N}  Verifier le statut\n"
    printf "  ${B}${Y}[ 3 ]${N}  Reparer les outils en echec\n"
    printf "  ${B}${R}[ 4 ]${N}  Quitter\n"
    printf "\n"
    printf "  ${C}${B}------------------------------------------${N}\n"
}

ACTION="$1"

case "$ACTION" in
    header)
        show_header
        show_menu
        ;;
    install)
        printf "\n  ${Y}${B}Installation complete en cours...${N}\n\n"
        sudo apt-get update -y > /tmp/install.log 2>&1
        sudo apt-get install -y libimage-exiftool-perl whois nmap >> /tmp/install.log 2>&1
        for pkg in sherlock-project maigret holehe ghunt instaloader; do
            printf "  ${C}[pipx]${N} installing %-20s ..." "$pkg"
            pipx install "$pkg" >> /tmp/install.log 2>&1
            printf " ${G}OK${N}\n"
        done
        pip3 install photon --break-system-packages >> /tmp/install.log 2>&1 && printf "  ${G}[pip]${N}  photon OK\n"
        [ -d ~/theHarvester ] || git clone https://github.com/laramies/theHarvester.git ~/theHarvester >> /tmp/install.log 2>&1
        pip3 install -e ~/theHarvester --break-system-packages >> /tmp/install.log 2>&1 && printf "  ${G}[pip]${N}  theHarvester OK\n"
        [ -d ~/recon-ng ] || git clone https://github.com/lanmaster53/recon-ng.git ~/recon-ng >> /tmp/install.log 2>&1
        pip3 install -r ~/recon-ng/REQUIREMENTS --break-system-packages >> /tmp/install.log 2>&1 && printf "  ${G}[pip]${N}  recon-ng OK\n"
        if [ ! -d ~/spiderfoot ]; then
            git clone https://github.com/smicallef/spiderfoot.git ~/spiderfoot >> /tmp/install.log 2>&1
            sed -i 's/lxml>=4.9.2,<5/lxml>=5/' ~/spiderfoot/requirements.txt
        fi
        pip3 install -r ~/spiderfoot/requirements.txt --break-system-packages >> /tmp/install.log 2>&1 && printf "  ${G}[pip]${N}  SpiderFoot OK\n"
        printf "\n  ${G}${B}Installation terminee !${N}\n\n"
        ;;
    bye)
        printf "\n  ${C}${B}A bientot, kiritogmre${N}\n\n"
        ;;
esac
