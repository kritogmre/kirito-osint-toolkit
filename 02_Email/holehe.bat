@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  HOLEHE  --  Email OSINT                 ^|
echo  ^|  Verifie si l email est sur 120+ sites   ^|
echo  +------------------------------------------+
echo.
set /p TARGET=  Adresse email :
if "%TARGET%"=="" goto END
echo.
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && holehe '%TARGET%' --only-used"
echo.
:END
pause
