@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  NMAP / WHOIS  --  IP ^& Domain OSINT    ^|
echo  ^|  Ports, services, infos domaine...      ^|
echo  +------------------------------------------+
echo.
set /p TARGET=  Cible (IP ou domaine) :
if "%TARGET%"=="" goto END
echo.
echo  [1] WHOIS (infos domaine/IP)
echo  [2] NMAP scan rapide (ports courants)
echo  [3] NMAP complet (services + OS)
echo  [4] Geolocalisation IP
echo.
set /p MODE=  Choix [1/2/3/4] :
echo.
if "%MODE%"=="1" wsl -d Ubuntu sh -c "whois '%TARGET%'"
if "%MODE%"=="2" wsl -d Ubuntu sh -c "nmap -F '%TARGET%'"
if "%MODE%"=="3" wsl -d Ubuntu sh -c "sudo nmap -sV -O '%TARGET%'"
if "%MODE%"=="4" wsl -d Ubuntu sh -c "curl -s ipinfo.io/'%TARGET%'"
echo.
:END
pause
