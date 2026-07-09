@echo off
title Ethernet Speed Booster - Windows
color 0A

echo =====================================
echo     Ethernet Speed Booster Tool
echo =====================================
echo.

echo [1] Resetting Windows Network Stack...
netsh winsock reset
netsh int ip reset

echo.
echo [2] Optimizing TCP Settings...
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global rss=enabled
netsh int tcp set global dca=enabled
netsh int tcp set global ecncapability=disabled

echo.
echo [3] Flushing DNS Cache...
ipconfig /flushdns

echo.
echo [4] Renewing IP Address...
ipconfig /release
ipconfig /renew

echo.
echo [5] Setting Faster DNS (Cloudflare)...
netsh interface ip set dns name="Ethernet" static 1.1.1.1
netsh interface ip add dns name="Ethernet" 1.0.0.1 index=2

echo.
echo [6] Removing Network Temporary Files...
del /q /f "%temp%\*" >nul 2>&1
del /q /f "C:\Windows\Temp\*" >nul 2>&1

echo.
echo [7] Clearing ARP Cache...
arp -d *

echo.
echo [8] Disabling Windows Download Throttling...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f

echo.
echo [9] Optimizing Power Management...
powercfg -setactive SCHEME_MIN

echo.
echo =====================================
echo DONE!
echo Restart your PC for best results.
echo =====================================

pause