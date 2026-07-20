#!/bin/bash

DEFAULT_BUILD_TYPE="Debug"

BUILD_TYPE="${1:-$DEFAULT_BUILD_TYPE}"

echo "[INFO] Build Type is set to: ${BUILD_TYPE}"

# 建立 build 資料夾（-p 確保資料夾存在時不報錯，並自動建立父資料夾）
mkdir -p build-arm64

# 進入 build 資料夾並執行 CMake
echo "[INFO] Running CMake..."
# 執行 CMake 設定階段 (使用你的 default preset)
# cmake --preset=default
cmake -B build-arm64 -DCMAKE_TOOLCHAIN_FILE=toolchain-arm64.cmake

# 執行編譯階段
cmake --build build-arm64 --config "${BUILD_TYPE}" -j$(nproc)

echo "[INFO] Done."