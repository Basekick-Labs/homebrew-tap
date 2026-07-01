# typed: false
# frozen_string_literal: true

# Homebrew formula for Arc — high-performance columnar analytical database.
#
# Binary formula: downloads the prebuilt, cosign-signed macOS binary from the
# GitHub release (built on macOS runners; DuckDB is statically linked, so the
# binary depends only on macOS system libraries — no `depends_on`).
#
# Install:  brew install basekick-labs/tap/arc
#
# UPDATING FOR A NEW RELEASE (usually automated by the release workflow):
#   1. bump `version`
#   2. replace both `sha256` values with the checksums of the release's
#      arc-darwin-arm64 / arc-darwin-amd64 assets:
#        curl -sL https://github.com/Basekick-Labs/arc/releases/download/vVERSION/arc-darwin-arm64 | shasum -a 256
class Arc < Formula
  desc "High-performance columnar analytical database (DuckDB/Parquet/Arrow)"
  homepage "https://github.com/basekick-labs/arc"
  version "26.06.3"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/Basekick-Labs/arc/releases/download/v#{version}/arc-darwin-arm64"
      sha256 "REPLACE_WITH_DARWIN_ARM64_SHA256"
    end
    on_intel do
      url "https://github.com/Basekick-Labs/arc/releases/download/v#{version}/arc-darwin-amd64"
      sha256 "REPLACE_WITH_DARWIN_AMD64_SHA256"
    end
  end

  def install
    # The release asset is the bare binary named per-arch; install it as `arc`.
    bin.install Dir["arc-darwin-*"].first => "arc"
  end

  def caveats
    <<~EOS
      Arc stores data locally by default under ./data/arc (relative to CWD).
      Start the server:  arc
      Then it listens on http://localhost:8000 (see `arc --help`).

      Docs: https://docs.basekick.net/arc
    EOS
  end

  test do
    # `arc` boots a server rather than offering a --version-only flag, so the
    # smoke test asserts the binary is present and Mach-O executable. A fuller
    # test (boot + /health) would require backgrounding the server.
    assert_predicate bin/"arc", :executable?
    assert_match "Mach-O", shell_output("file #{bin}/arc")
  end
end
