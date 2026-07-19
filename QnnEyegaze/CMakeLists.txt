project(QnnEyegaze)

add_executable(${PROJECT_NAME})

find_package(fmt CONFIG REQUIRED)
find_package(OpenCV CONFIG REQUIRED)

file(GLOB SOURCE_FILES 
    "src/*.c"
    "src/*.cpp"
    "src/*.h"
    "src/*.hpp")

target_sources(${PROJECT_NAME}
  PRIVATE
    ${SOURCE_FILES}
)

target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt ${OpenCV_LIBS})