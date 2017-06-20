############################################################################
# This file is part of LImA, a Library for Image Acquisition
#
# Copyright (C) : 2009-2017
# European Synchrotron Radiation Facility
# BP 220, Grenoble 38043
# FRANCE
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.
############################################################################
#CMakeLists.txt for Photonicscience camera

#HAVE TO BE UNDER WINDOWS
IF(WIN32)

	SET(photonic_srcs src/PhotonicScienceInterface.cpp src/PhotonicScienceCamera.cpp)

	FILE(STRINGS "VERSION" photonic_ver)
	ADD_LIBRARY(limaphotonicscience SHARED ${photonic_srcs})

	TARGET_INCLUDE_DIRECTORIES(limaphotonicscience PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
	#TARGET_INCLUDE_DIRECTORIES(limaphotonicscience PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/sdk/ImageStar4022_v2.5")
	TARGET_INCLUDE_DIRECTORIES(limaphotonicscience PUBLIC "C:/XIS/SDK32")
	
	TARGET_COMPILE_DEFINITIONS(limaphotonicscience PRIVATE LIBPHOTONICSCIENCE_EXPORTS)
	
	FIND_LIBRARY(PHOTONICSCIENCE_LIB_XISL XISL "C:/XIS/SDK32")
	IF("${PHOTONICSCIENCE_LIB_XISL}" STREQUAL "PHOTONICSCIENCE_LIB_XISL-NOTFOUND")
	  MESSAGE(FATAL_ERROR "photonicscience : XISL lib not found, you can search it in cmake-gui or try to install it if it isn't here.")
	ENDIF()
	#FIND_LIBRARY(PHOTONICSCIENCE_LIB_IMGSTAR imagestar4022control "${CMAKE_CURRENT_SOURCE_DIR}/sdk/ImageStar4022_v2.5")

	TARGET_LINK_LIBRARIES(limaphotonicscience limacore)
	TARGET_LINK_LIBRARIES(limaphotonicscience ${PHOTONICSCIENCE_LIB_XISL})
	#TARGET_LINK_LIBRARIES(limaphotonicscience ${PHOTONICSCIENCE_LIB_IMGSTAR}) 

	SET_TARGET_PROPERTIES(limaphotonicscience PROPERTIES VERSION ${photonic_ver} SOVERSION "1")
    SET_TARGET_PROPERTIES(limaphotonicscience PROPERTIES PREFIX "lib")
    INSTALL(TARGETS limaphotonicscience DESTINATION lib)

	IF(COMPILE_SIP)
		SET(NAME "photonicscience")
		include(CameraRunSIP)
		INSTALL(FILES python/__init__.py DESTINATION "${PYTHON_SITE_PACKAGES_DIR}/Lima/PhotonicScience")
	ENDIF()
ELSE()
	MESSAGE(FATAL_ERROR "This camera has to be compiled on Windows")
ENDIF()
