# Basekick Labs Homebrew Tap

Homebrew formulae for [Basekick Labs](https://basekick.net) software.

## Arc

High-performance columnar analytical database (DuckDB / Parquet / Arrow).

```bash
brew install basekick-labs/tap/arc
# or:
brew tap basekick-labs/tap
brew install arc
```

Then start the server:

```bash
arc            # listens on http://localhost:8000
arc --help
```

- **Docs:** https://docs.basekick.net/arc
- **Source:** https://github.com/basekick-labs/arc
- **License:** AGPL-3.0

### Platforms

The formula installs the prebuilt, cosign-signed macOS binary from the Arc
GitHub release (Apple Silicon and Intel). DuckDB is statically linked, so there
are no runtime dependencies. Linux users should use the `.deb` / `.rpm` /
container / Helm artifacts from the [Arc releases](https://github.com/basekick-labs/arc/releases).

## Updating a formula

Formulae are updated automatically by the Arc release workflow (which bumps the
version and the per-arch `sha256` values after each release). To update by hand:

```bash
VERSION=26.06.3
for arch in arm64 amd64; do
  echo "darwin-$arch: $(curl -sL https://github.com/Basekick-Labs/arc/releases/download/v$VERSION/arc-darwin-$arch | shasum -a 256 | awk '{print $1}')"
done
```
