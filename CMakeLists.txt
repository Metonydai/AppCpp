cmake_minimum_required(VERSION 3.23)
project(AppCpp)

set(CMAKE_CXX_STANDARD 17)

include(FetchContent)

# 1. 嘗試尋找系統或 apt 已經安裝的 OpenCV
find_package(OpenCV 4.0 QUIET)

# 2. 如果系統找不到，則透過 FetchContent 從 GitHub 下載
if(NOT OpenCV_FOUND)
    message(STATUS "OpenCV not found locally. Fetching from GitHub...")
        
    set(WITH_GTK ON CACHE INTERNAL "")
    set(WITH_GTK_2_X OFF CACHE INTERNAL "")

    # 強烈建議：關閉不需要的龐大模組與測試，否則在 Linux 上會編譯非常久
    set(BUILD_TESTS OFF CACHE INTERNAL "")
    set(BUILD_PERF_TESTS OFF CACHE INTERNAL "")
    set(BUILD_EXAMPLES OFF CACHE INTERNAL "")
    set(BUILD_opencv_apps OFF CACHE INTERNAL "")
    set(BUILD_opencv_java OFF CACHE INTERNAL "")
    set(BUILD_opencv_python3 OFF CACHE INTERNAL "")
    
    # 宣告 OpenCV 的下載來源與版本（這裡以 4.10.0 的 zip 壓縮包為例，比 git clone 快）
    FetchContent_Declare(
        opencv
        DOWNLOAD_EXTRACT_TIMESTAMP OFF
        URL https://github.com/opencv/opencv/archive/refs/tags/4.10.0.zip
    )

    # 自動下載、解壓，並納入 CMake 管理
    FetchContent_MakeAvailable(opencv)
    set(OpenCV_INCLUDE_DIRS
        "${opencv_SOURCE_DIR}/include"
        "${PROJECT_BINARY_DIR}"
        "${opencv_SOURCE_DIR}/modules/calib3d/include"
        "${opencv_SOURCE_DIR}/modules/core/include"
        "${opencv_SOURCE_DIR}/modules/dnn/include"
        "${opencv_SOURCE_DIR}/modules/features2d/include"
        "${opencv_SOURCE_DIR}/modules/flann/include"
        "${opencv_SOURCE_DIR}/modules/gapi/include"
        "${opencv_SOURCE_DIR}/modules/highgui/include"
        "${opencv_SOURCE_DIR}/modules/imgcodecs/include"
        "${opencv_SOURCE_DIR}/modules/imgproc/include"
        "${opencv_SOURCE_DIR}/modules/java/include"
        "${opencv_SOURCE_DIR}/modules/java/include"
        "${opencv_SOURCE_DIR}/modules/js/include"
        "${opencv_SOURCE_DIR}/modules/ml/include"
        "${opencv_SOURCE_DIR}/modules/obj/include"
        "${opencv_SOURCE_DIR}/modules/objdetect/include"
        "${opencv_SOURCE_DIR}/modules/photo/include"
        "${opencv_SOURCE_DIR}/modules/python/include"
        "${opencv_SOURCE_DIR}/modules/stitching/include"
        "${opencv_SOURCE_DIR}/modules/ts/include"
        "${opencv_SOURCE_DIR}/modules/video/include"
        "${opencv_SOURCE_DIR}/modules/videoio/include"
        "${opencv_SOURCE_DIR}/modules/world/include"
    )
    # 建立一個與 find_package 邏輯一致的自訂群組變數
    # 挑選你專案真正會用到的模組即可（例如：core, imgproc, highgui）
    set(MY_OPENCV_LIBS opencv_core opencv_imgproc)
else()
    message(STATUS "Found local OpenCV: ${OpenCV_DIR}")
endif()

# 1. 嘗試尋找系統或 apt 已經安裝的 fmt
find_package(fmt 10.0 CONFIG QUIET)

if(NOT fmt_FOUND)
    message(STATUS "fmt lib not found locally. Fetching from GitHub...")

    set(FMT_HEADER_ONLY ON CACHE INTERNAL "")
    set(FMT_DOC OFF CACHE INTERNAL "")
    set(FMT_TEST OFF CACHE INTERNAL "")
    set(FMT_INSTALL OFF CACHE INTERNAL "")

    FetchContent_Declare(
        fmt
        DOWNLOAD_EXTRACT_TIMESTAMP OFF
        URL https://github.com/fmtlib/fmt/archive/refs/tags/10.2.1.zip
    )

    FetchContent_MakeAvailable(fmt)
    
    if(TARGET fmt AND NOT TARGET fmt::fmt)
        add_library(fmt::fmt ALIAS fmt)
    endif()
else()
    message(STATUS "Found local fmt: ${fmt_DIR}")
endif()

add_subdirectory(HelloHuiyu)
add_subdirectory(QnnEyegaze)