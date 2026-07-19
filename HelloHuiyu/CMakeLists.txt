project(HelloHuiyu)

add_executable(${PROJECT_NAME})

find_package(fmt CONFIG REQUIRED)

target_sources(${PROJECT_NAME}
  PRIVATE
    hellohuiyu.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)