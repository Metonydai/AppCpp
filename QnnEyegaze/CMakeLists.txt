project(QnnEyegaze)

add_executable(${PROJECT_NAME})

file(GLOB SOURCE_FILES 
    "src/*.c"
    "src/*.cpp"
    "src/*.h"
    "src/*.hpp")

target_sources(${PROJECT_NAME}
  PRIVATE
    ${SOURCE_FILES}
)

target_include_directories(${PROJECT_NAME} PRIVATE 
    ${OpenCV_INCLUDE_DIRS}
)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt opencv_core opencv_imgproc opencv_highgui)