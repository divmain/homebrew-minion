cask "minion" do
  version "TEMPLATE_VERSION"
  sha256 "TEMPLATE_SHA256"

  desc "Speech-to-text utility with global keyboard shortcuts for macOS"
  homepage "https://github.com/divmain/minion"
  
  # URL will be dynamically updated by automation
  url "https://github.com/divmain/minion/releases/download/v#{version}/minion-#{version}-aarch64-apple-darwin.tar.gz"
    
  depends_on macos: ">= :monterey"
  depends_on arch: [:arm64, :x86_64]
  
  # Install binary to /opt/homebrew/bin
  binary "minion"

  uninstall delete: "#{HOMEBREW_PREFIX}/bin/minion"

  caveats <<~EOS
    #{tokens} requires macOS permissions for:
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