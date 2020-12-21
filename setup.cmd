@echo off
setlocal enabledelayedexpansion

call :get_key "Visual Studio Code"
call :get_path %ret%
call :write_defpath %ret% "V" "C"
goto :eof

:code
set data="Visual Studio Code"
for /f "delims=" %%a in ('reg query %root% /s /f %data%') do set code="%%a" & goto :codep
:codep
set data="InstallLocation"
for /f "skip=2 tokens=3*" %%a in ('reg query %code% /f %data%') do set codep="%%a %%b" & goto :subl

:subl
set data="Sublime Text"
for /f "delims=" %%a in ('reg query %root% /s /f %data%') do set subl="%%a" & goto :sublp
:sublp
set data="InstallLocation"
for /f "skip=2 tokens=3*" %%a in ('reg query %subl% /f %data%') do set codep="%%a %%b" & goto :subl


:get_key
set root="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
for /f "delims=" %%a in ('reg query %root% /s /f %1') do set ret="%%a" & goto :eof

:get_path
set data="InstallLocation"
for /f "skip=2 tokens=3*" %%a in ('reg query %1 /f %data%') do set ret="%%a %%b" & goto :eof

:write_key
echo [%~1]
goto :eof

:write_def
echo @="%~1"
goto :eof

:write_defpath
if "%2"=="" goto :write_defpath1
goto :write_defpathn

:write_defpathn
<nul set /p =@="
for %%a in (%*) do <nul set /p =\"%%~a\" 
echo "
goto :eof

:write_defpath1
call :str_esc %1
call :write_def %ret%
goto :eof

:str_esc
set a=%~1
set a=%a:\=\\%
set a=%a:"=\"%
set ret="%a%"
goto :eof

:str_unq
set ret=%~1
goto :eof


[HKEY_CLASSES_ROOT\Directory\Background\shell\code]
@="VSCode Here"
"Icon"="C:\\Program Files\\Microsoft VS Code\\Code.exe"

[HKEY_CLASSES_ROOT\Directory\Background\shell\code\command]
@="\"C:\\Program Files\\Microsoft VS Code\\Code.exe\" \"%v\""

[HKEY_CLASSES_ROOT\Directory\shell\code]
@="VSCode Here"
"Icon"="C:\\Program Files\\Microsoft VS Code\\Code.exe"

[HKEY_CLASSES_ROOT\Directory\shell\code\command]
@="\"C:\\Program Files\\Microsoft VS Code\\Code.exe\" \"%v\""


