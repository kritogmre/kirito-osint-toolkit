@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  MAIGRET  --  Username OSINT avance      ^|
echo  ^|  Recherche sur 3000+ sites + rapport     ^|
echo  +------------------------------------------+
echo.
set /p TARGET=  Pseudo a rechercher :
if "%TARGET%"=="" goto END
echo.
echo  [1] Recherche rapide (500 sites)
echo  [2] Recherche complete + rapport HTML
echo  [3] Rapport PDF
echo  [4] Recherche sur un site specifique
echo  [5] Plusieurs pseudos a la fois
echo.
set /p MODE=  Choix [1-5] :
echo.
if "%MODE%"=="1" goto QUICK
if "%MODE%"=="2" goto HTML
if "%MODE%"=="3" goto PDF
if "%MODE%"=="4" goto SITE
if "%MODE%"=="5" goto MULTI
goto QUICK

:QUICK
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && maigret '%TARGET%' --top-sites 500"
goto END

:HTML
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && maigret '%TARGET%' --html --top-sites 2000"
echo.
echo  Rapport HTML genere dans : reports/
goto END

:PDF
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && maigret '%TARGET%' --pdf"
echo.
echo  Rapport PDF genere dans : reports/
goto END

:SITE
set /p SITE=  Nom du site (ex: twitter) :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && maigret '%TARGET%' -s '%SITE%'"
goto END

:MULTI
set /p TARGETS=  Autres pseudos (separes par espaces) :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && maigret '%TARGET%' %TARGETS%"
goto END

:END
echo.
pause
