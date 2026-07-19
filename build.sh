#!/bin/bash

# ==================================================
# 設定 VCPKG 預設路徑（請改成你電腦上的實際路徑）
# ==================================================
DEFAULT_VCPKG_PATH="third_party/vcpkg"
DEFAULT_BUILD_TYPE="Debug"

# 如果有傳入參數 $1，就使用它，否則帶入預設值
BUILD_TYPE="${1:-$DEFAULT_BUILD_TYPE}"
# VCPKG_ROOT="${2:-$DEFAULT_VCPKG_PATH}"

# echo "[INFO] VCPKG_ROOT is set to: ${VCPKG_ROOT}"
echo "[INFO] Build Type is set to: ${BUILD_TYPE}"

# export VCPKG_ROOT
# export PATH="${VCPKG_ROOT}:${PATH}"

# 建立 build 資料夾（-p 確保資料夾存在時不報錯，並自動建立父資料夾）
mkdir -p build

# 進入 build 資料夾並執行 CMake
echo "[INFO] Running CMake..."
# 執行 CMake 設定階段 (使用你的 default preset)
# cmake --preset=default
cmake -B build -S .

# 執行編譯階段
cmake --build build --config "${BUILD_TYPE}"

echo "[INFO] Done."