@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  PHONEINFOGA  --  Phone OSINT            ^|
echo  ^|  Pays, operateur, type de ligne...       ^|
echo  +------------------------------------------+
echo.
echo  Format : +33612345678 (avec indicatif pays)
echo.
set /p NUMBER=  Numero de telephone :
if "%NUMBER%"=="" goto END
echo.
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && phoneinfoga scan -n '%NUMBER%'"
echo.
:END
pause
