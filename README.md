# Claude Code Plugins

A personal marketplace of Claude Code plugins.

## Available Plugins

### Installation

Add this marketplace to Claude Code:

```bash
/plugin marketplace add adeonir/claude-code-extras
```

### Available Plugins

| Plugin                                     | Description                                                                                               | Version |
| ------------------------------------------ | --------------------------------------------------------------------------------------------------------- | ------- |
| [spec-driven](./plugins/spec-driven)       | Specification-driven development with brownfield support, requirements traceability, and archive workflow | 2.5.2   |
| [debug-tools](./plugins/debug-tools)       | Iterative debugging workflow with confidence scoring and runtime analysis                                 | 1.3.1   |
| [design-builder](./plugins/design-builder) | Extract copy and design from references to build React frontend or Figma designs                          | 4.0.1   |
| [git-helpers](./plugins/git-helpers)       | Git workflow commands with confidence-scored code review                                                  | 1.2.2   |

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
