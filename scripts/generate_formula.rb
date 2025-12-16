#!/usr/bin/env ruby

# Helper script for generating initial formula if needed
# Usage: ruby scripts/generate_formula.rb <version> <sha256> [homepage]

require 'yaml'

# Add any additional helpers for formula generation if needed
def generate_binary_formula(version, sha256, homepage)
  template = <<~RUBY
    cask "minion" do
      version "#{version}"
      sha256 "#{sha256}"

      desc "Speech-to-text utility with global keyboard shortcuts for macOS"
      homepage "#{homepage}"
      
      url "https://github.com/divmain/minion/releases/download/v#{version}/minion-#{version}-aarch64-apple-darwin.tar.gz"
        
      depends_on macos: ">= :monterey"
      depends_on arch: [:arm64]
      
      binary "minion"

      uninstall delete: "\#{HOMEBREW_PREFIX}/bin/minion"

      caveats <<~EOS
        \#{tokens} requires macOS permissions for:
        - Accessibility (for global keyboard shortcuts)
        - Screen Recording (for audio capture)
        
        These permissions will be automatically requested on first launch.
        You can manage these permissions in System Settings > Privacy & Security.
        
        Minion also requires an ML model (~200MB) which will be downloaded on first run.
      EOS

      livecheck do
        url :homepage
        strategy :github_latest
      end
    end
  RUBY
  
  template
end

# Command line interface
if __FILE__ == $0
  if ARGV.length < 2
    puts "Usage: #{$0} <version> <sha256> [homepage]"
    exit 1
  end
  
  version = ARGV[0]
  sha256 = ARGV[1]
  homepage = ARGV[2] || "https://your-website.com/minion"
  
  puts generate_binary_formula(version, sha256, homepage)
end