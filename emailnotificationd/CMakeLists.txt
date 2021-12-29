set(SRC 
    main.cpp
    notificationapp.cpp
    notificationapp.h
)

add_executable(emailnotificationd ${SRC})

find_package(PkgConfig REQUIRED)
pkg_check_modules(MLITE5 mlite5 REQUIRED IMPORTED_TARGET)
pkg_check_modules(QMFCLIENT QmfClient REQUIRED IMPORTED_TARGET)

target_link_libraries(emailnotificationd
	Qt5::Gui
	PkgConfig::MLITE5
	PkgConfig::QMFCLIENT
	Glacier::App)

install(TARGETS emailnotificationd RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})

install(FILES emailnotificationd.desktop
        DESTINATION ${CMAKE_INSTALL_SYSCONFDIR}/xdg/autostart/)
