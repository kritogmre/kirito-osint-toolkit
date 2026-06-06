#!/bin/sh
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

G='\033[0;32m'; R='\033[0;31m'; Y='\033[1;33m'
C='\033[0;36m'; M='\033[0;35m'; B='\033[1m'; N='\033[0m'

TOTAL=12
OK=0; FAIL=0

draw_global_bar() {
    done=$((OK + FAIL))
    pct=$((done * 100 / TOTAL))
    gf=$((OK * 28 / TOTAL))
    rf=$((FAIL * 28 / TOTAL))
    i=0; bar=""
    while [ $i -lt $gf ];          do bar="${bar}#"; i=$((i+1)); done
    while [ $i -lt $((gf+rf)) ];   do bar="${bar}!"; i=$((i+1)); done
    while [ $i -lt 28 ];           do bar="${bar}-"; i=$((i+1)); done
    printf '\033[s\033[999;1H\033[2K'
    printf "  ${B}${C}[ GLOBAL ]${N} ${G}[%s]${N} ${C}%3d%%${N}  ${G}%d OK${N}  ${R}%d ECHEC${N}  ${M}%d/%d${N}" \
        "$bar" "$pct" "$OK" "$FAIL" "$done" "$TOTAL"
    printf '\033[u'
}

check_and_fix() {
    name="$1"; check="$2"; install="$3"

    if eval "$check" > /dev/null 2>&1; then
        OK=$((OK+1))
        printf "  ${G}[OK]${N}  %-22s\n" "$name"
        draw_global_bar
    else
        eval "$install" > /tmp/osint_fix.log 2>&1 &
        pid=$!; spin_i=0
        while kill -0 "$pid" 2>/dev/null; do
            spin_i=$(( (spin_i+1) % 4 ))
            case $spin_i in 0) f="-";; 1) f='\\';; 2) f="|";; *) f="/";; esac
            printf '\r  \033[1;33m[~~]\033[0m  %-22s \033[0;36m[%s]\033[0m installing...' "$name" "$f"
            sleep 0.12
        done
        wait $pid
        if eval "$check" > /dev/null 2>&1; then
            OK=$((OK+1))
            printf "\r  ${G}[OK]${N}  %-22s ${G}installe !${N}               \n" "$name"
        else
            FAIL=$((FAIL+1))
            printf "\r  ${R}[!!]${N}  %-22s ${R}echec${N} - /tmp/osint_fix.log\n" "$name"
        fi
        draw_global_bar
    fi
}

printf '\n'
printf "${B}${C}"
printf '  ╔══════════════════════════════════════════════════╗\n'
printf '  ║       OSINT Tools  --  Verification & Fix        ║\n'
printf '  ╚══════════════════════════════════════════════════╝\n'
printf "${N}\n"
draw_global_bar

printf "\n${B}  ── Username ──${N}\n"
check_and_fix "sherlock"     "command -v sherlock"                    "pipx install sherlock-project"
check_and_fix "maigret"      "command -v maigret"                     "pipx install maigret"

printf "\n${B}  ── Email ──${N}\n"
check_and_fix "holehe"       "command -v holehe"                      "pipx install holehe"
check_and_fix "ghunt"        "command -v ghunt"                       "pip3 install ghunt --break-system-packages 2>/dev/null || pipx install ghunt"

printf "\n${B}  ── Social Media ──${N}\n"
check_and_fix "instaloader"  "command -v instaloader"                 "pipx install instaloader"

printf "\n${B}  ── Metadata ──${N}\n"
check_and_fix "exiftool"     "command -v exiftool"                    "sudo apt-get install -y libimage-exiftool-perl"

printf "\n${B}  ── Domain / Web ──${N}\n"
check_and_fix "theHarvester" \
    "command -v theHarvester || test -f $HOME/theHarvester/theHarvester.py" \
    "[ -d $HOME/theHarvester ] || git clone https://github.com/laramies/theHarvester.git $HOME/theHarvester; pip3 install -e $HOME/theHarvester --break-system-packages"
check_and_fix "photon"       "pip3 show photon > /dev/null 2>&1"      "pip3 install photon --break-system-packages"

printf "\n${B}  ── Frameworks ──${N}\n"
check_and_fix "recon-ng"  "test -f $HOME/recon-ng/recon-ng" \
    "git clone https://github.com/lanmaster53/recon-ng.git $HOME/recon-ng 2>/dev/null; pip3 install -r $HOME/recon-ng/REQUIREMENTS --break-system-packages"
check_and_fix "SpiderFoot" "test -f $HOME/spiderfoot/sf.py" \
    "git clone https://github.com/smicallef/spiderfoot.git $HOME/spiderfoot 2>/dev/null; sed -i 's/lxml>=4.9.2,<5/lxml>=5/' $HOME/spiderfoot/requirements.txt; pip3 install -r $HOME/spiderfoot/requirements.txt --break-system-packages"

printf "\n${B}  ── Phone / IP ──${N}\n"
check_and_fix "whois"        "command -v whois"                       "sudo apt-get install -y whois"
check_and_fix "nmap"         "command -v nmap"                        "sudo apt-get install -y nmap"

printf "\n${B}${C}"
printf '  ══════════════════════════════════════════════════\n'
printf "${N}"
printf "  ${G}${B}%d OK${N}  ${R}${B}%d ECHEC${N}  sur ${B}%d${N} outils\n\n" "$OK" "$FAIL" "$TOTAL"
