set(SRC 
    main.cpp
)

add_executable(glacier-mail ${SRC})

target_link_libraries(glacier-mail
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Qt5::WebEngine
	Glacier::App)

install(TARGETS glacier-mail RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-mail)
