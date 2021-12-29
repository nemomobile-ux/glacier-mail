set(SRC 
    main.cpp
)

qtquick_compiler_add_resources(RESOURCES qml/glacier-mail.qrc)

add_executable(glacier-mail ${SRC} ${RESOURCES})

target_link_libraries(glacier-mail
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Qt5::WebEngine
	Glacier::App)

install(TARGETS glacier-mail RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
