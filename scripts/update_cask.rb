#!/usr/bin/env ruby

require 'octokit'
require 'yaml'
require 'net/http'
require 'digest'

GITHUB_REPO = "divmain/minion"
CASK_FILE = "Casks/minion.rb"

def latest_release
  client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  client.latest_release(GITHUB_REPO)
end

def download_asset(url)
  uri = URI(url)
  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "token #{ENV['GITHUB_TOKEN']}"
    http.request(request)
  end
end

def calculate_sha256(asset_data)
  Digest::SHA256.hexdigest(asset_data)
end

def update_cask(version, sha256)
  content = File.read(CASK_FILE)
  
  # Update version and sha256
  content.gsub!(/version ".*?"/, "version \"#{version}\"")
  content.gsub!(/sha256 ".*?"/, "sha256 \"#{sha256}\"")
  
  # Update URL for current release
  content.gsub!(/url ".*?"/, "url \"https://github.com/divmain/minion/releases/download/v#{version}/minion-#{version}-aarch64-apple-darwin.tar.gz\"")
  
  File.write(CASK_FILE, content)
  puts "Updated cask to version #{version} with SHA256 #{sha256}"
end

def main
  release = latest_release
  version = release.tag_name.gsub(/^v/, '')
  
  # Find the aarch64 asset (we'll use this as the primary)
  arm64_asset = release.assets.find { |a| a.name.include?('aarch64') || a.name.include?('arm64') }
  
  if arm64_asset.nil?
    puts "Could not find aarch64 asset in release #{version}"
    exit 1
  end
  
  # Download and calculate SHA256
  puts "Downloading #{arm64_asset.name}"
  asset_data = download_asset(arm64_asset.url)
  sha256 = calculate_sha256(asset_data)
  
  # Update cask file
  update_cask(version, sha256)
end

main