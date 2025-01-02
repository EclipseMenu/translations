cmake_minimum_required(VERSION 3.21)

function(setup_translations target)
    if (DEFINED TRANSLATIONS_PATH)
        message(STATUS "Using translations from: ${TRANSLATIONS_PATH}.")
        if (NOT DEFINED ENV{ECLIPSE_TRANSLATIONS_REPO_PATH})
            message(STATUS "To use local translations, set ECLIPSE_TRANSLATIONS_REPO_PATH environment variable.")
        endif()
    endif()

    # Refresh translations on every build
    add_custom_command(
        TARGET ${target} PRE_LINK
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${TRANSLATIONS_PATH}/translations
        ${CMAKE_SOURCE_DIR}/resources/translations
        COMMENT "Copying translations..."
    )

    # If using a local repo, set timestamp to a high value to disable translations updates
    if (DEFINED ENV{ECLIPSE_TRANSLATIONS_REPO_PATH})
        set(TRANSLATIONS_UNIX_TIMESTAMP 9999999999)
    else()
        string(TIMESTAMP TRANSLATIONS_UNIX_TIMESTAMP "%s" UTC)
    endif()

    target_compile_definitions(${target} PRIVATE ECLIPSE_TRANSLATION_TIMESTAMP=${TRANSLATIONS_UNIX_TIMESTAMP})
endfunction()