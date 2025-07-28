@echo off
setlocal EnableDelayedExpansion

:: Thu muc chua log
set LOGFILE="C:\Program Files (x86)\PRTG Network Monitor\Notifications\EXE\Matrix_Alert.log"

:: Gan tham so tu dong lenh vao bien
set "param1=%~1"
set "param2=%~2"
set "param3=%~3"
set "param4=%~4"
set "param5=%~5"
set "param6=%~6"
set "param7=%~7"
set "param8=%~8"
set "param9=%~9"

:: shift de truy cap tu tham so thu 10 tro di
shift
shift
shift
shift
shift
shift
shift
shift
shift

set "param10=%~1"
set "param11=%~2"
set "param12=%~3"
set "param13=%~4"
set "param14=%~5"
set "param15=%~6"
set "param16=%~7"

:: Ghi log
echo [%date% %time%] --- Bat script called with parameters: >> %LOGFILE%
for /L %%i in (1,1,16) do (
    set paramName=param%%i
    echo   !%paramName%! >> %LOGFILE%
)

:: Gui PowerShell script
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "C:\Program Files (x86)\PRTG Network Monitor\Notifications\EXE\Script_Matrix_Prtg.ps1" ^
"!param1!" "!param2!" "!param3!" "!param4!" "!param5!" "!param6!" "!param7!" "!param8!" "!param9!" "!param10!" "!param11!" "!param12!" "!param13!" "!param14!" "!param15!" "!param16!"

:: Kiem tra ket qua
if %errorlevel% equ 0 (
    echo [%date% %time%] Gui canh bao thanh cong. >> %LOGFILE%
    exit /b 0
) else (
    echo [%date% %time%] LOI: Gui canh bao that bai. Ma loi: %errorlevel% >> %LOGFILE%
    exit /b 1
)
