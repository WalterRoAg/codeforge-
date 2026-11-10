@echo off
echo Desbloqueando puerto 8080 para CodeForge...
netsh advfirewall firewall add rule name="CodeForge Backend 8080" dir=in action=allow protocol=TCP localport=8080
echo Listo! Puerto 8080 habilitado en el Firewall de Windows.
pause
