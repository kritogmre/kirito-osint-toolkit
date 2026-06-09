@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  GHUNT  --  Google Account OSINT         ^|
echo  ^|  Infos depuis un compte Google / Gmail   ^|
echo  +------------------------------------------+
echo.
echo  [1] Recherche par adresse Gmail
echo  [2] Recherche par Google ID (Gaia ID)
echo  [3] Analyse d une URL Google Drive
echo  [4] Connexion / Setup (premiere utilisation)
echo.
set /p MODE=  Choix [1-4] :
echo.
if "%MODE%"=="1" goto EMAIL
if "%MODE%"=="2" goto GAIA
if "%MODE%"=="3" goto DRIVE
if "%MODE%"=="4" goto LOGIN
goto EMAIL

:EMAIL
set /p TARGET=  Adresse Gmail :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && ghunt email '%TARGET%'"
goto END

:GAIA
set /p TARGET=  Google ID (Gaia ID) :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && ghunt gaia '%TARGET%'"
goto END

:DRIVE
set /p TARGET=  URL Google Drive :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && ghunt drive '%TARGET%'"
goto END

:LOGIN
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && ghunt login"
goto END

:END
echo.
pause
