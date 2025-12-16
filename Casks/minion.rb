cask "minion" do
  version "0.1.3"
  sha256 "1b03a9ec4813143ce84f4cd2baddd7e2a4fb32bd0ea3d8ec77d8536b1cf346b5"

  desc "Speech-to-text utility with global keyboard shortcuts for macOS"
  homepage "https://github.com/divmain/minion"
  
  # URL will be dynamically updated by automation
  url "https://github.com/divmain/homebrew-minion/releases/download/v0.1.3/minion-aarch64-apple-darwin.tar.gz"
    
  depends_on macos: ">= :monterey"
  depends_on arch: [:arm64, :x86_64]
  
  # Install binary to /opt/homebrew/bin
  binary "minion"

  uninstall delete: "#{HOMEBREW_PREFIX}/bin/minion"

  caveats <<~EOS
    Minion requires macOS permissions for:
    - Accessibility (for global keyboard shortcuts)
    - Screen Recording (for audio capture)
    
    These permissions will be automatically requested on first launch.
    You can manage these permissions in System Settings > Privacy & Security.
    
    Minion also requires an ML model (~200MB) which will be downloaded on first run.
  EOS

  # Auto-update check using GitHub releases
  livecheck do
    url :homepage
    strategy :github_latest
  end
end