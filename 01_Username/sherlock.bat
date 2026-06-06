@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  SHERLOCK  --  Username Search           ^|
echo  ^|  Recherche un pseudo sur 400+ sites      ^|
echo  +------------------------------------------+
echo.
set /p TARGET=  Pseudo a rechercher :
if "%TARGET%"=="" goto END
echo.
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && sherlock '%TARGET%' --print-found"
echo.
:END
pause
