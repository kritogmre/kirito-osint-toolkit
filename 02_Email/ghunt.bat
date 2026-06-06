@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  GHUNT  --  Google Account OSINT         ^|
echo  ^|  Infos depuis une adresse Gmail          ^|
echo  +------------------------------------------+
echo.
echo  NOTE : lancer "ghunt login" la 1ere fois
echo.
set /p TARGET=  Adresse Gmail :
if "%TARGET%"=="" goto END
echo.
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && ghunt email '%TARGET%'"
echo.
:END
pause
