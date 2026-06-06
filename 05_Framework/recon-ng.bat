@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  RECON-NG  --  Framework OSINT           ^|
echo  ^|  Ouvre le shell interactif recon-ng      ^|
echo  +------------------------------------------+
echo.
echo  Commandes utiles dans recon-ng :
echo    workspaces create NOM
echo    marketplace install all
echo    modules load recon/domains-hosts/hackertarget
echo    options set SOURCE exemple.com
echo    run
echo    show hosts
echo.
echo  Lancement...
echo.
wsl -d Ubuntu -- sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/recon-ng/recon-ng"
echo.
pause
