@echo off
SETLOCAL

:: ==================================================
:: 設定預設路徑與參數
:: ==================================================
set "DEFAULT_VCPKG_PATH=third_party\vcpkg"
set "DEFAULT_BUILD_TYPE=Debug"

if "%~1" == "" (
    set "BUILD_TYPE=%DEFAULT_BUILD_TYPE%"
) else (
    set "BUILD_TYPE=%~1"
)

if "%~2" == "" (
    set "VCPKG_ROOT=%DEFAULT_VCPKG_PATH%"
) else (
    set "VCPKG_ROOT=%~2"
)


echo [INFO] VCPKG_ROOT is set to: %VCPKG_ROOT%
echo [INFO] Build Type is set to: %BUILD_TYPE%

:: 設定環境變數與 PATH
set "PATH=%VCPKG_ROOT%;%PATH%"

:: 建立 build 資料夾
if not exist build mkdir build

:: 進入 build 資料夾并執行 CMake
echo [INFO] Running CMake...

:: 透過 -DCMAKE_BUILD_TYPE 帶入 Debug 或 Release 參數
cmake --preset=default
cmake --build build --config %BUILD_TYPE%

ENDLOCAL
echo [INFO] Done.
pause