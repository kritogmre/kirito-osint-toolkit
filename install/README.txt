╔══════════════════════════════════════════════════════════════════════════════╗
║                   KIRITO OSINT TOOLKIT  —  GUIDE COMPLET A-Z               ║
╚══════════════════════════════════════════════════════════════════════════════╝

  by kiritogmre  |  https://guns.lol/kiritogmre
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

A. PRÉREQUIS
─────────────────────────────────────────────────────────────────────────────
  • Windows 10/11 avec WSL2 activé
  • Ubuntu installé dans WSL
  • Docker Desktop (optionnel, pour SpiderFoot en container)

  Activer WSL :
    PowerShell (admin) → wsl --install
    Redémarrer → ouvrir Ubuntu

B. INSTALLATION RAPIDE
─────────────────────────────────────────────────────────────────────────────
  Double-clique sur INSTALL.bat → choisir [1]
  OU dans WSL : bash install_wsl.sh

C. STRUCTURE DU PROJET
─────────────────────────────────────────────────────────────────────────────
  INSTALL.bat          → Menu principal (installer / vérifier / réparer)
  check_tools.bat      → Vérification rapide depuis Windows
  install_wsl.sh       → Script d'installation pour WSL
  README.txt           → Ce fichier
  01_Username/         → Sherlock, Maigret
  02_Email/            → Holehe, GHunt
  03_Domain_Web/       → theHarvester, Photon
  04_Metadata/         → ExifTool
  05_Framework/        → Recon-ng, SpiderFoot
  06_Social_Media/     → Instaloader
  07_Phone_IP/         → PhoneInfoga, WHOIS, NMAP

D. OUTILS — RÉFÉRENCE RAPIDE
─────────────────────────────────────────────────────────────────────────────

  ┌─ SHERLOCK ─────────────────────────────────────────────────────────────┐
  │ But : trouver un pseudo sur 400+ sites                                 │
  │ sherlock nomutilisateur                                                │
  │ sherlock nom1 nom2 --print-found --output resultats.txt               │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ MAIGRET ──────────────────────────────────────────────────────────────┐
  │ But : recherche pseudo sur 3000+ sites + rapport HTML visuel           │
  │ maigret nomutilisateur                                                 │
  │ maigret nomutilisateur --html --top-sites 1000                        │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ HOLEHE ───────────────────────────────────────────────────────────────┐
  │ But : vérifier si un email est utilisé sur 120+ services               │
  │ holehe email@exemple.com                                               │
  │ holehe email@exemple.com --only-used                                   │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ GHUNT ────────────────────────────────────────────────────────────────┐
  │ But : OSINT sur compte Google/Gmail (photo, services, activité)        │
  │ ghunt login           ← faire d'abord avec un faux compte Google       │
  │ ghunt email target@gmail.com                                           │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ INSTALOADER ──────────────────────────────────────────────────────────┐
  │ But : analyser profils Instagram (posts, métadonnées, followers)       │
  │ instaloader nomutilisateur                                             │
  │ instaloader --no-pictures nomutilisateur                               │
  │ instaloader --login TON_COMPTE --followers cible                       │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ EXIFTOOL ─────────────────────────────────────────────────────────────┐
  │ But : extraire métadonnées cachées (GPS, auteur, appareil photo...)    │
  │ exiftool photo.jpg                          ← tout voir                │
  │ exiftool -gps:all photo.jpg                 ← coordonnées GPS          │
  │ exiftool -all= photo.jpg                    ← supprimer métadonnées    │
  │ exiftool -json fichier.pdf                  ← export JSON              │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ THEHARVESTER ─────────────────────────────────────────────────────────┐
  │ But : collecter emails, sous-domaines, IPs d'un domaine               │
  │ python3 ~/theHarvester/theHarvester.py -d exemple.com -b google       │
  │ python3 ~/theHarvester/theHarvester.py -d exemple.com -b all          │
  │ python3 ~/theHarvester/theHarvester.py -d exemple.com -b all -f out   │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ PHOTON ───────────────────────────────────────────────────────────────┐
  │ But : crawler web OSINT (emails, URLs, clés API, fichiers exposés)     │
  │ python3 ~/Photon/photon.py -u https://exemple.com                     │
  │ python3 ~/Photon/photon.py -u https://exemple.com -l 2 -o ./out       │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ RECON-NG ─────────────────────────────────────────────────────────────┐
  │ But : framework OSINT modulaire (comme Metasploit pour la reco)        │
  │ python3 ~/recon-ng/recon-ng                                            │
  │   workspaces create CIBLE                                              │
  │   marketplace install all                                              │
  │   modules load recon/domains-hosts/hackertarget                       │
  │   options set SOURCE exemple.com                                       │
  │   run → show hosts                                                     │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ SPIDERFOOT ───────────────────────────────────────────────────────────┐
  │ But : framework OSINT complet avec interface web                       │
  │ python3 ~/spiderfoot/sf.py -l 127.0.0.1:5001                          │
  │ → ouvrir http://localhost:5001 dans le navigateur                      │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ PHONEINFOGA ──────────────────────────────────────────────────────────┐
  │ But : OSINT sur numéro de téléphone (pays, opérateur, type)           │
  │ phoneinfoga scan -n +33601020304                                       │
  │ phoneinfoga serve -p 8080  → http://localhost:8080                    │
  └─────────────────────────────────────────────────────────────────────────┘

  ┌─ NMAP / WHOIS ─────────────────────────────────────────────────────────┐
  │ nmap -sV exemple.com          ← scan ports + services                  │
  │ whois exemple.com             ← infos domaine / IP                     │
  │ curl ipinfo.io/8.8.8.8        ← géolocalisation IP rapide             │
  └─────────────────────────────────────────────────────────────────────────┘

E. WORKFLOWS OSINT TYPIQUES
─────────────────────────────────────────────────────────────────────────────

  → Investigation pseudo :
    1. sherlock [pseudo] --print-found
    2. maigret [pseudo] --html
    3. Ouvrir reports/[pseudo].html

  → Investigation email :
    1. holehe [email] --only-used
    2. ghunt email [email]
    3. theHarvester -d domaine.com -b google

  → Investigation domaine/entreprise :
    1. whois domaine.com
    2. theHarvester -d domaine.com -b all -f rapport
    3. python3 ~/Photon/photon.py -u https://domaine.com -l 2
    4. nmap -sV -F domaine.com

  → Investigation photo :
    1. exiftool photo.jpg
    2. exiftool -gps:all photo.jpg
    → Copier coordonnées GPS dans Google Maps

F. DÉPANNAGE
─────────────────────────────────────────────────────────────────────────────

  Commande introuvable après install :
    source ~/.bashrc   OU   export PATH="$HOME/.local/bin:$PATH"

  Voir l'erreur d'une installation ratée :
    cat /tmp/osint_fix.log

  Réinstaller un outil spécifique :
    pipx install --force [nom-outil]

  SpiderFoot : erreur lxml :
    sed -i 's/lxml>=4.9.2,<5/lxml>=5/' ~/spiderfoot/requirements.txt
    pip3 install -r ~/spiderfoot/requirements.txt --break-system-packages

  WSL introuvable depuis Windows :
    PowerShell (admin) → wsl --install → redémarrer

G. AVERTISSEMENT LÉGAL
─────────────────────────────────────────────────────────────────────────────
  Ces outils sont réservés à :
  → la recherche sur soi-même
  → les CTF et challenges de sécurité
  → les tests d'intrusion avec autorisation explicite
  → la recherche en cybersécurité

  Toute utilisation non autorisée sur des tiers est illégale.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  KIRITO OSINT TOOLKIT  |  https://guns.lol/kiritogmre
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
