:: echo off / title
@echo off
title System Cleaner ^| By waxnet

:: ask for admin
(Net session > nul 2>&1)||(PowerShell start """%~0""" -verb RunAs & Exit /B)

:: start
title System Cleaner ^| By waxnet

echo Welcome to System Cleaner!

:: important
timeout /t 2 > nul
echo.
echo Please don't close the cleaner during the cleaning process!

:: stage 1
timeout /t 4 > nul
echo.
title System Cleaner ^| By waxnet ^| Stage 1
echo Stage 1 starting...

timeout /t 1 > nul
echo  - Creating cleaning process data file...
cd /D "%~dp0"
del data.txt > nul 2>&1
(
	echo System Cleaner Data
	echo.
	echo -- Free space before cleanup
	fsutil volume diskfree c:
	echo -- End
) > data.txt

echo Stage 1 completed!

:: stage 2
timeout /t 2 > nul
echo.
title System Cleaner ^| By waxnet ^| Stage 2
echo Stage 2 starting...

timeout /t 1 > nul
echo  - Creating system restore point...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "System Cleaner", 100, 7 > nul 2>&1

echo Stage 2 completed!

:: stage 3
timeout /t 2 > nul
echo.
title System Cleaner ^| By waxnet ^| Stage 3
echo Stage 3 starting...

timeout /t 1 > nul
echo  - Executing disk cleanup...
cleanmgr /sagerun
cleanmgr /verylowdisk /c

timeout /t 1 > nul
echo  - Deleting temporary files...
del %temp%\*.*  									/s /q > nul 2>&1
del c:\windows\prefetch\*.* 						/s /q > nul 2>&1
del c:\windows\softwaredistribution\download\*.*    /s /q > nul 2>&1
del %appdata%\microsoft\windows\recent\*.lnk  		/s /q > nul 2>&1

timeout /t 1 > nul
echo  - Flushing Microsoft Store cache...
WSreset.exe

timeout /t 1 > nul
echo  - Flushing DNS Resolver cache...
ipconfig /flushdns > nul 2>&1

echo Stage 3 completed!

:: stage 4
timeout /t 2 > nul
echo.
title System Cleaner ^| By waxnet ^| Stage 4
echo Stage 4 starting...

timeout /t 1 > nul
echo  - Saving cleaning process data...
(
	echo.
	echo -- Free space after cleanup
	fsutil volume diskfree c:
	echo -- End
	echo.
	echo -- Restore point information
	echo Name: Automatic Restore Point
	echo -- End
	echo.
	echo -- Credits
	echo Author: waxnet
	echo Discord: https://discord.gg/keTpWFAKx6
	echo GitHub: https://github.com/waxnet
	echo -- End
) >> data.txt

timeout /t 1 > nul
echo  - Opening data file...
start data.txt

echo Stage 4 completed!

:: end
timeout /t 2 > nul
echo.
title System Cleaner ^| By waxnet
echo Cleaning process successfully completed!
echo Press any key to exit...

pause > nul
