# Contributing to homebrew-minion

This repository contains the Homebrew tap definition for Minion.

## How Updates Work

This tap is automatically updated when new versions of Minion are released:

1. A new Git tag is pushed to the main `minion` repository
2. GitHub Actions builds the release for multiple architectures
3. The release workflow triggers an update to this tap repository
4. A GitHub Actions workflow in this repository updates the cask definition

## Manual Updates

If automatic updates fail, manual updates can be performed:

1. Get the latest version and checksum from the [Minion releases page](https://github.com/divmain/minion/releases)
2. Update the version and sha256 in `Casks/minion.rb`
3. Test the installation:
   ```bash
   brew uninstall minion
   brew install --build-from-source divmain/homebrew-minion/minion
   ```

## Adding New Versions

The `scripts/update_cask.rb` script handles automatic updates. To run it manually:

```bash
GITHUB_TOKEN=your_token ruby scripts/update_cask.rb
```

## Testing Changes

Always test changes before submitting PRs:

```bash
# Test local changes
brew uninstall my-app 2>/dev/null || true
brew install --build-from-source ./Casks/minion.rb
brew test ./Casks/minion.rb
```

## Issues

Issues should be reported in the main [Minion repository](https://github.com/divmain/minion/issues).

## Architecture Considerations

### Cross-Platform Support

The cask currently supports:
- Apple Silicon (ARM64)

Homebrew automatically selects the appropriate binary for the current architecture.

### Binary Distribution

- Binaries are built from Rust source in the main repository
- Release assets are uploaded to GitHub releases
- This tap repository contains only the cask definition, no binaries
- Automated updates ensure compatibility with the latest versions