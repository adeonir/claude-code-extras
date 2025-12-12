# debug-tools

Claude Code plugin for iterative debugging with hypothesis generation and runtime analysis.

## Overview

Inspired by Cursor Debug Mode, this plugin provides systematic debugging through:
- Hypothesis generation (3-5 ranked possibilities)
- Strategic log injection with `[DEBUG]` prefix
- Runtime analysis via Console Ninja and Chrome DevTools MCP
- Iterative refinement until bug is fixed
- Automatic cleanup of debug logs

## Architecture

```
debug-tools/
├── .claude-plugin/
│   └── plugin.json
├── .mcp.json                  # Console Ninja + Chrome DevTools + Serena
├── agents/
│   ├── bug-investigator.md    # Hypothesis generation and analysis
│   └── log-injector.md        # Strategic log placement
├── commands/
│   └── debug.md               # Main entry point
└── skills/
    └── debugging/
        └── SKILL.md           # Framework-specific patterns
```

## Workflow

```
/debug "bug description"
    |
    v
Bug Investigator generates hypotheses
    |
    v
Log Injector adds [DEBUG] logs
    |
    v
User reproduces bug
    |
    v
Bug Investigator analyzes logs
    |
    v
Proposes fix -> User approves -> Apply
    |
    v
User verifies -> If fixed, cleanup logs
```

## Command

| Command | Description |
|---------|-------------|
| `/debug "description"` | Start debugging session |

The rest of the flow is conversational - no additional commands needed.

## Agents

| Agent | Role |
|-------|------|
| `bug-investigator` | Generates hypotheses, analyzes logs, proposes fixes |
| `log-injector` | Adds strategic debug logs based on hypotheses |

## MCP Integration

Optional MCP servers for enhanced debugging:

| MCP | Purpose |
|-----|---------|
| Console Ninja | Runtime values, test status, code coverage |
| Chrome DevTools | Network inspection, browser console, DOM |
| Serena | Semantic code analysis via LSP |

### Prerequisites

- **Console Ninja**: Install VS Code extension, then:
  ```bash
  claude mcp add console-ninja -s project -- npx "-y" "-c" "node ~/.console-ninja/mcp"
  ```

- **Chrome DevTools**: Enable Chrome remote debugging, then:
  ```bash
  claude mcp add chrome-devtools -s project -- npx -y @anthropic/chrome-devtools-mcp
  ```

- **Serena**: Requires `uvx` (uv tool runner):
  ```bash
  claude mcp add serena -s project -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --enable-web-dashboard false
  ```

### Serena Benefits

When Serena MCP is available, agents gain semantic code analysis:

| Phase | Tool | Benefit |
|-------|------|---------|
| Hypothesis | `find_symbol` | Precise function/class location |
| Hypothesis | `find_referencing_symbols` | Trace callers and dependencies |
| Log Injection | `insert_after_symbol` | Semantic log placement |
| Analysis | `get_symbols_overview` | Understand code structure |

## Log Format

All debug logs use consistent format:
```javascript
console.log('[DEBUG] [file:line] [H1] message', { values });
```

- `[DEBUG]` - Prefix for easy identification and cleanup
- `[file:line]` - Location reference
- `[H1]` - Hypothesis being verified
- `{ values }` - Relevant variable state

## Cleanup

Debug logs are automatically removed when bug is confirmed fixed.

Manual cleanup:
```bash
grep -rn '\[DEBUG\]' . --include='*.ts' --include='*.tsx' --include='*.js'
```

## Example Session

```
User: /debug "Form submission fails silently"

Agent: I've analyzed the codebase and generated these hypotheses:

[H1] API error not being caught (High)
[H2] Form validation failing silently (Medium)
[H3] Network request timing out (Low)

Debug logs added at 5 locations. Please submit the form and let me know.

User: Done, here's the console output...

Agent: Confirmed H1 - The API returns 422 but the error handler
expects 400. Proposed fix: update error check to include 422.

Apply this fix?

User: Yes

Agent: Fixed. Please try submitting again.

User: Works now!

Agent: Removed debug logs. Bug resolved.
```
