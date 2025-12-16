cask "minion" do
  version "0.1.4"
  sha256 "98ea7a0d70e729ddc50220be08ae9713742c9fad339d567391cebff530303333"

  desc "Speech-to-text utility with global keyboard shortcuts for macOS"
  homepage "https://github.com/divmain/minion"
  
  # URL will be dynamically updated by automation
  url "https://github.com/divmain/homebrew-minion/releases/download/v0.1.4/minion-aarch64-apple-darwin.tar.gz"
    
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