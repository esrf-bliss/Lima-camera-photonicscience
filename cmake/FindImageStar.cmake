find_library(IMAGESTAR_LIBRARY imagestar4022control.lib)
find_path(IMAGESTAR_INCLUDE_DIRS "imagestar4022control.h")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ImageStar DEFAULT_MSG
  IMAGESTAR_LIBRARY
  IMAGESTAR_INCLUDE_DIRS
)

if(IMAGESTAR_FOUND)
    if(NOT TARGET ImageStar::ImageStar)
        add_library(ImageStar::ImageStar SHARED IMPORTED)
    endif()
    if(BLOSC2_INCLUDE_DIRS)
        set_target_properties(ImageStar::ImageStar PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${IMAGESTAR_INCLUDE_DIRS}")
    endif()
    if(EXISTS "${IMAGESTAR_LIBRARY}")
        set_target_properties(ImageStar::ImageStar PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "C"
            IMPORTED_IMPLIB "${IMAGESTAR_LIBRARY}")
    endif()
endif()
