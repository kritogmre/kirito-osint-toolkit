@echo off
chcp 65001 > nul
cls
echo.
echo  Verification et correction automatique des outils OSINT...
echo.
type "%~dp0check_tools.sh" | wsl -d Ubuntu sh -c "tr -d '\r' > /tmp/_check.sh && sh /tmp/_check.sh"
echo.
pause
