@echo off
:menu
cls
echo Remote Management Program
echo ========================
echo 1. View Remote System Info
echo 2. Remote Process List
echo 3. Remote Services Status
echo 4. Remote Command Prompt
echo 5. Exit
echo.

set /p choice="Enter your choice (1-5): "
set /p computer="Enter remote computer name or IP: "

if "%choice%"=="1" (
    systeminfo /s %computer%
    pause
    goto menu
)
if "%choice%"=="2" (
    tasklist /s %computer%
    pause
    goto menu
)
if "%choice%"=="3" (
    sc \\%computer% query
    pause
    goto menu
)
if "%choice%"=="4" (
    psexec \\%computer% cmd
    pause
    goto menu
)
if "%choice%"=="5" (
    exit
) else (
    echo Invalid choice
    timeout /t 2
    goto menu
)