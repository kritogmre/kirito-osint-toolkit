# Kirito OSINT Toolkit

> Collection d'outils OSINT locaux pour Windows (via WSL) — open source, by [kiritogmre](https://guns.lol/kiritogmre)

## Installation rapide

1. Télécharge la [dernière release](../../releases/latest)
2. Extrais le ZIP
3. Double-clique sur `install/INSTALL.bat`
4. Le script installe automatiquement : WSL, Ubuntu, Python, pip, pipx et tous les outils

## Outils inclus

| Catégorie | Outil | Description |
|---|---|---|
| Username | [Sherlock](https://github.com/sherlock-project/sherlock) | Recherche pseudo sur 400+ sites |
| Username | [Maigret](https://github.com/soxoj/maigret) | Recherche pseudo sur 3000+ sites + rapport HTML |
| Email | [Holehe](https://github.com/megadose/holehe) | Vérifie si un email est utilisé sur 120+ services |
| Email | [GHunt](https://github.com/mxrch/GHunt) | OSINT sur compte Google/Gmail |
| Social | [Instaloader](https://github.com/instaloader/instaloader) | OSINT Instagram |
| Metadata | [ExifTool](https://exiftool.org/) | Extraction métadonnées (GPS, auteur, appareil...) |
| Domain | [theHarvester](https://github.com/laramies/theHarvester) | Emails, sous-domaines, IPs d'un domaine |
| Web | [Photon](https://github.com/s0md3v/Photon) | Crawler OSINT (emails, clés API, fichiers...) |
| Framework | [Recon-ng](https://github.com/lanmaster53/recon-ng) | Framework modulaire (style Metasploit) |
| Framework | [SpiderFoot](https://github.com/smicallef/spiderfoot) | Framework OSINT avec interface web |
| Phone | [PhoneInfoga](https://github.com/sundowndev/phoneinfoga) | OSINT numéros de téléphone |
| IP/Domain | nmap + whois | Scan ports, infos WHOIS |

## Utilisation

Tous les outils tournent dans WSL (Ubuntu). Ouvre un terminal WSL et utilise les commandes directement.

```bash
# Exemple — recherche pseudo
sherlock kiritogmre --print-found

# Exemple — email
holehe exemple@gmail.com --only-used

# Exemple — métadonnées photo
exiftool photo.jpg | grep -i gps

# Exemple — domaine
python3 ~/theHarvester/theHarvester.py -d exemple.com -b google
```

## Structure

```
OSINT-Tools/
├── install/
│   ├── INSTALL.bat       ← installeur principal (double-clique)
│   ├── check_tools.bat   ← vérification rapide
│   ├── check_tools.sh    ← script WSL (vérif + auto-fix)
│   ├── menu.sh           ← menu stylé
│   └── install_wsl.sh    ← installation manuelle WSL
├── 01_Username/          ← docs Sherlock, Maigret
├── 02_Email/             ← docs Holehe, GHunt
├── 03_Domain_Web/        ← docs theHarvester, Photon
├── 04_Metadata/          ← docs ExifTool
├── 05_Framework/         ← docs Recon-ng, SpiderFoot
├── 06_Social_Media/      ← docs Instaloader
├── 07_Phone_IP/          ← docs PhoneInfoga, NMAP
├── README.md
├── LICENSE
└── .gitignore
```

## Avertissement légal

Ces outils sont destinés à un usage légal uniquement :
- Recherche sur soi-même
- CTF / challenges de sécurité
- Pentest avec autorisation explicite
- Recherche en cybersécurité

**Toute utilisation non autorisée sur des tiers est illégale.**

---

by [kiritogmre](https://guns.lol/kiritogmre) — MIT License
