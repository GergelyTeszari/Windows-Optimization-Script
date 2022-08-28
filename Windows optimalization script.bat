@echo off
title Windows optimalization script 1.0 by Jaser
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

set Balanced=381b4222-f694-41f0-9685-ff5bb260df2e

set HighPerf=8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

REM Game mode sw
call :MsgBox "Enable performance mode?"  "VBYesNo+VBQuestion" "Question"
if errorlevel 7 (
	echo Turning off game mode...
	@echo off
	Title Executing registry editor operation...
	cd %systemroot%\system32
	Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f
	Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f
	powercfg -s "%Balanced%"

) else if errorlevel 6 (
	echo Turning on game mode...
	@echo off
	Title Executing registry editor operation...
	cd %systemroot%\system32
	Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f
	Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f
	powercfg -s "%HighPerf%"
)

title Windows optimalization script 1.0 by Jaser
REM Autorun sw
call :MsgBox "Do you want this script to run automatically?"  "VBYesNo+VBQuestion" "Question"
if errorlevel 7 (
	msg * "Script won't be executed automatically."
	pause
) else if errorlevel 6 (
	msg * "Please download this file"
	start https://drive.google.com/file/d/1hhhrHGyTA2jITDtUczy9luB_I7uJUB94/view?usp=sharing
	set /p DUMMY=Hit ENTER to continue...
	msg * "Move the downloaded file here!"
	start %SystemRoot%\explorer.exe "%HOMEPATH%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
	pause
)

msg * "Have a nice day!"
exit /b

:MsgBox prompt type title
setlocal enableextensions
set "tempFile=%temp%\%~nx0.%random%%random%%random%vbs.tmp"
>"%tempFile%" echo(WScript.Quit msgBox("%~1",%~2,"%~3") & cscript //nologo //e:vbscript "%tempFile%"
set "exitCode=%errorlevel%" & del "%tempFile%" >nul 2>nul
endlocal & exit /b %exitCode%