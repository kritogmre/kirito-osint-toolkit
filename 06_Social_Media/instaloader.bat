@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  INSTALOADER  --  Instagram OSINT        ^|
echo  ^|  Posts, metadonnees, followers...        ^|
echo  +------------------------------------------+
echo.
set /p TARGET=  Compte Instagram cible :
if "%TARGET%"=="" goto END
echo.
echo  [1] Metadonnees uniquement (sans photos)
echo  [2] Telecharger tout (photos incluses)
echo.
set /p MODE=  Choix [1/2] :
echo.
if "%MODE%"=="2" (
    wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && instaloader '%TARGET%'"
) else (
    wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && instaloader --no-pictures '%TARGET%'"
)
echo.
:END
pause
