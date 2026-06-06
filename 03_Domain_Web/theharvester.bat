@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  theHARVESTER  --  Domain Recon          ^|
echo  ^|  Emails, sous-domaines, IPs d un domaine ^|
echo  +------------------------------------------+
echo.
set /p DOMAIN=  Domaine cible (ex: exemple.com) :
if "%DOMAIN%"=="" goto END
echo.
echo  [1] Recherche Google uniquement (rapide)
echo  [2] Toutes les sources (complet)
echo.
set /p MODE=  Choix [1/2] :
echo.
if "%MODE%"=="2" (
    wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/theHarvester/theHarvester.py -d '%DOMAIN%' -b all"
) else (
    wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/theHarvester/theHarvester.py -d '%DOMAIN%' -b google"
)
echo.
:END
pause
