project(HelloHuiyu)

add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME}
  PRIVATE
    hellohuiyu.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)