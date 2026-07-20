@echo off
SETLOCAL

:: ==================================================
:: 設定預設路徑與參數
:: ==================================================
set "DEFAULT_BUILD_TYPE=Debug"

if "%~1" == "" (
    set "BUILD_TYPE=%DEFAULT_BUILD_TYPE%"
) else (
    set "BUILD_TYPE=%~1"
)

echo [INFO] Build Type is set to: %BUILD_TYPE%

:: 建立 build 資料夾
if not exist build mkdir build

:: 進入 build 資料夾并執行 CMake
echo [INFO] Running CMake...

:: 透過 -DCMAKE_BUILD_TYPE 帶入 Debug 或 Release 參數
cmake -B build -S .
cmake --build build --config %BUILD_TYPE% -j$(nproc)

ENDLOCAL
echo [INFO] Done.
pause