vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO permitCore-spec/permitcore-sdk-cpp
    REF "v${VERSION}"
    SHA512 2cfde08a548cf0b30774ebf1062b2efaaa3afbb5bc399e7c26ba2edcf2b15f096a31756795dfdbaeb9cac1bc1e57a83fe5c882ca555bb9eb11d504c16471d6fb
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
