# PermitCore vcpkg registry

A custom vcpkg registry for the PermitCore C++ SDK. Source lives at
[permitCore-spec/permitcore-sdk-cpp](https://github.com/permitCore-spec/permitcore-sdk-cpp)
(mirrored from the main [PermitCore](https://github.com/permitCore-spec/PermitCore) monorepo,
`SDKs/cpp/`).

## Usage

Resolve the current registry commit with `git ls-remote
https://github.com/permitCore-spec/permitcore-vcpkg-registry HEAD`, then replace the baseline
placeholder in your project's `vcpkg-configuration.json`:

```json
{
  "registries": [
    {
      "kind": "git",
      "repository": "https://github.com/permitCore-spec/permitcore-vcpkg-registry",
      "baseline": "REPLACE_WITH_REGISTRY_HEAD_COMMIT",
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

The 1.2.0 port exposes Store subscription payment status and payment grace metadata.
Paid renewals keep the same key and advance paid-through; failed renewals use configurable
14-day payment grace. Signed offline access remains bounded by paid-through plus grace.
