@echo off

REM Check if RPC service is running
sc query RpcSs | find "RUNNING"
if not %errorlevel%==0 (
    echo Starting RPC service...
    net start RpcSs
    if %errorlevel%==0 (
        echo RPC service started successfully.
    ) else (
        echo Failed to start RPC service. Please check your service configuration.
        pause
        exit /b 1
    )
) else (
    echo RPC service is already running.
)

REM Ensure firewall rules are in place
echo Configuring firewall rules...
netsh advfirewall firewall add rule name="RPC" protocol=TCP dir=in localport=135 action=allow
netsh advfirewall firewall add rule name="RPC" protocol=TCP dir=out localport=135 action=allow
netsh advfirewall firewall add rule name="RPC Dynamic Ports" protocol=TCP dir=in action=allow
netsh advfirewall firewall add rule name="RPC Dynamic Ports" protocol=TCP dir=out action=allow

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
