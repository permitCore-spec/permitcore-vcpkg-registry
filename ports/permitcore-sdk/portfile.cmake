vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO permitCore-spec/permitcore-sdk-cpp
    REF "v${VERSION}"
    SHA512 1000a0865eb29fdd808d098cc3c8c53d58b87588f9944574071036e11d4df47fe2eaff5b705010c8ec7460e9fa95574e033b34dcb829348525d6654662708a14
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
