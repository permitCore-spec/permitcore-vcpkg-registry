# PermitCore vcpkg registry

A custom vcpkg registry for the PermitCore C++ SDK. Source lives at
[permitCore-spec/permitcore-sdk-cpp](https://github.com/permitCore-spec/permitcore-sdk-cpp)
(mirrored from the main [PermitCore](https://github.com/permitCore-spec/PermitCore) monorepo,
`SDKs/cpp/`).

## Usage

Add this registry to your project's `vcpkg-configuration.json`:

```json
{
  "registries": [
    {
      "kind": "git",
      "repository": "https://github.com/permitCore-spec/permitcore-vcpkg-registry",
      "baseline": "114fce933895d40a5b380c03b6b0c3256bf0a86d",
      "packages": ["permitcore-sdk"]
    }
  ]
}
```

Then:

```sh
vcpkg add port permitcore-sdk
vcpkg install
```

Or without a manifest, directly:

```sh
vcpkg install permitcore-sdk
```

```cmake
find_package(permitcore-sdk CONFIG REQUIRED)
target_link_libraries(main PRIVATE permitcore::permitcore)
```

## Releasing a new version

1. Tag a new version on [permitcore-sdk-cpp](https://github.com/permitCore-spec/permitcore-sdk-cpp)
   (`vN.N.N`), synced from `SDKs/cpp/` in the main monorepo via `git subtree split`.
2. Update `ports/permitcore-sdk/vcpkg.json`'s `version` field.
3. Compute the new tarball's SHA512:
   `curl -sL https://github.com/permitCore-spec/permitcore-sdk-cpp/archive/vN.N.N.tar.gz | sha512sum`
4. Update `SHA512` in `ports/permitcore-sdk/portfile.cmake`.
5. Add a new entry to `versions/p-/permitcore-sdk.json` (new version + `git-tree` — the tree hash
   of `ports/permitcore-sdk` at the commit that makes this change:
   `git rev-parse HEAD:ports/permitcore-sdk` after committing).
6. Update `versions/baseline.json`'s `baseline` to the new version.
7. Commit and push.
