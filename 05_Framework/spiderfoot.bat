@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  SPIDERFOOT  --  Framework Web UI        ^|
echo  ^|  Interface web sur http://localhost:5001 ^|
echo  +------------------------------------------+
echo.
echo  Demarrage de SpiderFoot...
echo  Ouvre http://localhost:5001 dans ton navigateur.
echo.
echo  (Ctrl+C pour arreter)
echo.
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/spiderfoot/sf.py -l 127.0.0.1:5001"
echo.
pause
