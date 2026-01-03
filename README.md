# Claude Code Plugins

A personal collection of plugins for Claude Code, organized as a plugin marketplace.

## Available Plugins

### Installation

Add this marketplace to Claude Code:

```bash
/plugin marketplace add adeonir/claude-code-extras
```

### Available Plugins

| Plugin | Description | Version |
|--------|-------------|---------|
| [spec-driven](./plugins/spec-driven) | Specification-driven development with feature IDs, validation, and archive workflow | 2.0.0 |
| [debug-tools](./plugins/debug-tools) | Iterative debugging workflow with confidence scoring and runtime analysis | 1.3.0 |
| [design-builder](./plugins/design-builder) | Extract copy and design to build frontend components | 3.0.0 |
| [git-helpers](./plugins/git-helpers) | Git workflow commands (commit, PR, code review) | 1.1.1 |

### Installing a Plugin

```bash
/plugin install design-builder
```

### Marketplace Commands

```bash
# Add marketplace
/plugin marketplace add adeonir/claude-code-extras

# List available plugins
/plugin marketplace list

# Install a plugin
/plugin install design-builder

# Update marketplace
/plugin marketplace update adeonir/claude-code-extras
```

## Contributing

1. Fork this repository
2. Add your plugin under `plugins/`
3. Submit a pull request

## License

MIT
