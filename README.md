# Claude Code Plugins

A personal collection of plugins for Claude Code, organized as a plugin marketplace.

## Available Plugins

### Installation

Add this marketplace to Claude Code:

```bash
/plugin marketplace add adeonir/claude-code-plugins
```

### Available Plugins

| Plugin | Description | Version |
|--------|-------------|---------|
| [spec-driven](./plugins/spec-driven) | Specification-driven development workflow with persistent artifacts | 1.0.1 |
| [debug-tools](./plugins/debug-tools) | Debugging with code analysis and targeted log injection | 1.2.0 |
| [design-builder](./plugins/design-builder) | Extract copy and design to build components or generate prompts for AI tools | 2.0.1 |
| [git-helpers](./plugins/git-helpers) | Git workflow commands (commit, PR, code review) | 1.1.1 |

### Installing a Plugin

```bash
/plugin install design-builder
```

### Marketplace Commands

```bash
# Add marketplace
/plugin marketplace add adeonir/claude-code-plugins

# List available plugins
/plugin marketplace list

# Install a plugin
/plugin install design-builder

# Update marketplace
/plugin marketplace update adeonir/claude-code-plugins
```

## Contributing

1. Fork this repository
2. Add your plugin under `plugins/`
3. Submit a pull request

## License

MIT
