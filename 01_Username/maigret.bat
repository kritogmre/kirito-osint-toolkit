@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  MAIGRET  --  Username OSINT avance      ^|
echo  ^|  Recherche sur 3000+ sites + rapport HTML^|
echo  +------------------------------------------+
echo.
set /p TARGET=  Pseudo a rechercher :
if "%TARGET%"=="" goto END
echo.
echo  [1] Recherche rapide (500 sites)
echo  [2] Recherche complete + rapport HTML
echo.
set /p MODE=  Choix [1/2] :
echo.
if "%MODE%"=="2" (
    wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && maigret '%TARGET%' --html --top-sites 2000"
    echo.
    echo  Rapport genere dans : reports/%TARGET%.html
) else (
    wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && maigret '%TARGET%' --top-sites 500"
)
echo.
:END
pause
