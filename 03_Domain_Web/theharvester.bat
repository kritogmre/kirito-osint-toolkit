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
echo  [1] Google uniquement (rapide)
echo  [2] Toutes les sources (complet)
echo  [3] Sources specifiques (bing, linkedin...)
echo  [4] Exporter en HTML
echo.
set /p MODE=  Choix [1-4] :
echo.
if "%MODE%"=="1" goto GOOGLE
if "%MODE%"=="2" goto ALL
if "%MODE%"=="3" goto CUSTOM
if "%MODE%"=="4" goto EXPORT
goto GOOGLE

:GOOGLE
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/theHarvester/theHarvester.py -d '%DOMAIN%' -b google"
goto END

:ALL
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/theHarvester/theHarvester.py -d '%DOMAIN%' -b all"
goto END

:CUSTOM
echo  Sources : google, bing, linkedin, twitter, dnsdumpster, crtsh, virustotal...
set /p SOURCES=  Sources (separees par virgules) :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/theHarvester/theHarvester.py -d '%DOMAIN%' -b '%SOURCES%'"
goto END

:EXPORT
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/theHarvester/theHarvester.py -d '%DOMAIN%' -b all -f ~/harvest_%DOMAIN%"
echo.
echo  Rapport exporte dans ~/harvest_%DOMAIN%.html
goto END

:END
echo.
pause
