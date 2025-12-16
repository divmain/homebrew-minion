# homebrew-minion

Homebrew tap for [Minion](https://github.com/divmain/minion) - a speech-to-text utility with global keyboard shortcuts for macOS.

## Installation

```bash
# Add the tap
brew tap divmain/minion

# Install Minion
brew install minion
```

## Usage

After installation, run:

```bash
# Start Minion
minion

# Or run with debug logging
minion --debug
```

### Required Permissions

Minion requires macOS permissions for:

1. **Accessibility** - for global keyboard shortcuts
2. **Screen Recording** - for audio capture

These permissions will be automatically requested on first launch. You can manage them in:

- **System Settings → Privacy & Security → Accessibility**
- **System Settings → Privacy & Security → Screen Recording**

### First Run Setup

On first launch, Minion will:
1. Request necessary permissions
2. Download the required ML model (~200MB)
3. Create configuration file in `~/.config/minion/`

## Updating

```bash
brew upgrade minion
```

## Configuration

Minion uses a TOML configuration file located at:
- `minion-config.toml` in the current working directory, or
- `~/.local/minion/config.toml`

See [Minion documentation](https://github.com/divmain/minion) for configuration options.

## Troubleshooting

### Permissions Issues

If Minion doesn't respond to keyboard shortcuts:

1. Open **System Settings → Privacy & Security**
2. Go to **Accessibility** and ensure Minion is enabled
3. Restart Minion

If audio recording doesn't work:

1. Open **System Settings → Privacy & Security**
2. Go to **Screen Recording** and ensure Minion is enabled
3. Restart Minion

### Model Download Issues

If the ML model fails to download:

```bash
# Force model re-download
minion --fetch-model
```

### Debug Mode

To troubleshoot issues:

```bash
# Run with verbose logging
minion --debug
```

## Development

See the [main Minion repository](https://github.com/divmain/minion) for source code, issues, and development documentation.

## License

This tap repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.

Minion itself has its own license - see the main repository for details.
