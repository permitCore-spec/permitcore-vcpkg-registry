vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO permitCore-spec/permitcore-sdk-cpp
    REF "v${VERSION}"
    SHA512 b05f3f159ed646e233cb9db3160063dda7db7cae2523673628741ec07cb9ac5bdc2134ce6e8647cd0bca986356b89fd30887d15b8951c39a7a157ce824ece099
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
