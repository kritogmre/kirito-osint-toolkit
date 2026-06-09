@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  INSTALOADER  --  Instagram OSINT        ^|
echo  ^|  Posts, metadonnees, followers...        ^|
echo  +------------------------------------------+
echo.
echo  [1] Metadonnees uniquement (sans photos)
echo  [2] Telecharger tout (photos incluses)
echo  [3] Voir les followers (compte connecte requis)
echo  [4] Voir les abonnements (compte connecte requis)
echo  [5] Telecharger les stories (compte connecte requis)
echo.
set /p MODE=  Choix [1-5] :
echo.
if "%MODE%"=="1" goto META
if "%MODE%"=="2" goto FULL
if "%MODE%"=="3" goto FOLLOWERS
if "%MODE%"=="4" goto FOLLOWEES
if "%MODE%"=="5" goto STORIES
goto META

:META
set /p TARGET=  Compte Instagram cible :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && instaloader --no-pictures '%TARGET%'"
goto END

:FULL
set /p TARGET=  Compte Instagram cible :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && instaloader '%TARGET%'"
goto END

:FOLLOWERS
set /p LOGIN=  Ton compte Instagram :
set /p TARGET=  Compte cible :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && instaloader --login '%LOGIN%' --followers '%TARGET%'"
goto END

:FOLLOWEES
set /p LOGIN=  Ton compte Instagram :
set /p TARGET=  Compte cible :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && instaloader --login '%LOGIN%' --followees '%TARGET%'"
goto END

:STORIES
set /p LOGIN=  Ton compte Instagram :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && instaloader --login '%LOGIN%' :stories"
goto END

:END
echo.
pause
