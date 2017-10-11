SET(Boost_Debug_Suffix "gd-")
IF(IS_WINDOWS)
        SET(BOOST_ARCH_TYPES "Debug" "Release")
ELSE()
        SET(BOOST_ARCH_TYPES "Release")
ENDIF()

foreach(ARCH ${BOOST_ARCH_TYPES})
	SET(Boost_MISSING_DLL FALSE)
	foreach(BOOST_SUB_LIB ${BOOST_Components_List}) 
		SET(BOOST_FILE "${Boost_LIBRARY_DIR}/${LIB_PREFIX}boost_${BOOST_SUB_LIB}${BOOST_SUFFIX_1}${Boost_${ARCH}_Suffix}${BOOST_SUFFIX_2}.${DLL_EXT}")
		IF(EXISTS ${BOOST_FILE})
			add_custom_command(TARGET ${EXECUTABLE_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_if_different "${BOOST_FILE}" $<TARGET_FILE_DIR:${EXECUTABLE_NAME}>)
		ELSEIF(NOT Boost_MISSING_DLL)
			MESSAGE(WARNING "Unable to find DLL at ${BOOST_FILE} - has Boost ${ARCH} been built?")
			SET(Boost_MISSING_DLL TRUE)
		ENDIF()
	endforeach(BOOST_SUB_LIB)
endforeach(ARCH) 
