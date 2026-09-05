vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO permitCore-spec/permitcore-sdk-cpp
    REF "v${VERSION}"
    SHA512 e22d15abee30069bc66f0e75045f030c4e156185fbe0b348eca55245bc8463cad09109e9fe204162969fe45bfcff5ccc96ccd78c23ca5f842c7ad9baaea02a67
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
