###########################################################################
# This file is part of LImA, a Library for Image Acquisition
#
#  Copyright (C) : 2009-2017
#  European Synchrotron Radiation Facility
#  CS40220 38043 Grenoble Cedex 9 
#  FRANCE
# 
#  Contact: lima@esrf.fr
# 
#  This is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
# 
#  This software is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
# 
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, see <http://www.gnu.org/licenses/>.
############################################################################

#HAVE TO BE UNDER WINDOWS
if(WIN32)
	set(NAME "photonicscience")

	set(${NAME}_srcs src/PhotonicScienceInterface.cpp src/PhotonicScienceCamera.cpp)

	add_library(lima${NAME} SHARED ${${NAME}_srcs})

	target_include_directories(lima${NAME} PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
	target_include_directories(lima${NAME} PUBLIC "C:/XIS/SDK32")
	
	target_compile_definitions(lima${NAME} PRIVATE LIBPHOTONICSCIENCE_EXPORTS)
	
	#not in the vcproj
	#find_library(PHOTONICSCIENCE_LIB_XISL XISL "C:/XIS/SDK32")
	#if("${PHOTONICSCIENCE_LIB_XISL}" STREQUAL "PHOTONICSCIENCE_LIB_XISL-NOTFOUND")
	#  message(FATAL_ERROR "photonicscience : XISL lib not found, you can search it in cmake-gui or try to install it if it isn't here.")
	#endif()

	target_link_libraries(lima${NAME} limacore)
	#target_link_libraries(limaphotonicscience ${PHOTONICSCIENCE_LIB_XISL})

	include(CameraVERSION)
	set_target_properties(lima${NAME} PROPERTIES PREFIX "lib")
    install(TARGETS lima${NAME} DESTINATION lib)

	if(LIMA_ENABLE_PYTHON)
		include(CameraRunSIP)
		install(FILES python/__init__.py DESTINATION "${PYTHON_SITE_PACKAGES_DIR}/Lima/PhotonicScience")
	endif()
else()
	message(FATAL_ERROR "This camera has to be compiled on Windows")
endif()
