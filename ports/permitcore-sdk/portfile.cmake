vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO permitCore-spec/permitcore-sdk-cpp
    REF "v${VERSION}"
    SHA512 fd9ddd03470366a83da77cc9aba8da0084fdde5890e53175bc069bbbdbfd08ef581f94637511ee9ab85b04348332f522f1112f52a8581e0483747f995056aa8d
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME permitcore-sdk CONFIG_PATH lib/cmake/permitcore-sdk)

vcpkg_copy_pdbs()

# Headers are architecture/config-independent; vcpkg only wants one copy under
# ${CURRENT_PACKAGES_DIR}/include, not a duplicate under debug/include.
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
