# Debug Tools

Iterative debugging workflow for Claude Code with hypothesis generation and runtime analysis.

> **Part of [claude-code-plugins](https://github.com/adeonir/claude-code-plugins)** - A curated marketplace of Claude Code plugins for feature development, debugging, frontend generation, and git helpers.

## Features

- Hypothesis-driven debugging (3-5 ranked possibilities)
- Strategic log injection with `[DEBUG]` prefix
- Runtime analysis via Console Ninja MCP
- Browser debugging via Chrome DevTools MCP
- Iterative refinement until bug is fixed
- Automatic cleanup of debug logs

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) - Anthropic's official CLI for Claude

### Add Marketplace

First, add the marketplace to Claude Code (only needed once):

```bash
/plugin marketplace add adeonir/claude-code-plugins
```

### Install Plugin

```bash
/plugin install debug-tools
```

This command automatically:
- Downloads the plugin from the marketplace
- Configures Console Ninja and Chrome DevTools MCPs for runtime inspection
- Makes the `/debug` command available in your Claude Code session

> **Note:** Console Ninja requires the [VS Code extension](https://marketplace.visualstudio.com/items?itemName=WallabyJs.console-ninja) installed. Chrome DevTools requires Chrome running with [remote debugging enabled](https://developer.chrome.com/docs/devtools/remote-debugging/).

## Quick Start

```bash
# Start debugging session
claude /debug "user cannot login after page refresh"

# The workflow is conversational from here:
# 1. Agent generates hypotheses
# 2. Agent injects debug logs
# 3. You reproduce the bug
# 4. Agent analyzes and proposes fix
# 5. You approve and verify
# 6. Agent cleans up logs
```

## Command

| Command | Description |
|---------|-------------|
| `/debug <description>` | Start iterative debugging session |

## Workflow

```
/debug "bug description"
    |
    v
Bug Investigator generates hypotheses:
    - H1: Most likely cause (High)
    - H2: Alternative cause (Medium)
    - H3: Edge case (Low)
    |
    v
Log Injector adds [DEBUG] logs at strategic points
    |
    v
You: "Reproduce the bug and let me know"
    |
    v
You: "reproduced" (share console output)
    |
    v
Bug Investigator analyzes logs:
    - Confirms hypothesis
    - Proposes minimal fix
    |
    v
You: "Apply fix?" -> "yes"
    |
    v
You: "Verify fix worked" -> "works!"
    |
    v
Agent removes all [DEBUG] logs, done
```

## Log Format

All debug logs use consistent format for easy identification:

```javascript
console.log('[DEBUG] [file:line] [H1] message', { values });
```

- `[DEBUG]` - Prefix for grep and cleanup
- `[file:line]` - Location reference
- `[H1]` - Hypothesis being verified
- `{ values }` - Relevant variable state

## MCP Servers

The plugin can leverage these MCP servers if installed:

| MCP | Purpose |
|-----|---------|
| Console Ninja | Runtime values, test status, code coverage |
| Chrome DevTools | Network inspection, browser console, DOM |

## Cleanup

Debug logs are automatically removed when the bug is confirmed fixed.

Manual cleanup:
```bash
grep -rn '\[DEBUG\]' . --include='*.ts' --include='*.tsx' --include='*.js'
```

## Example Session

```
User: /debug "Form submission fails silently"

Agent: I've analyzed the codebase and generated these hypotheses:

[H1] API error not being caught (High)
- Evidence: api/submit.ts:42 - catch block only handles 400
- Verify: Log response status in catch

[H2] Form validation failing silently (Medium)
- Evidence: Form.tsx:15 - no error state display
- Verify: Log validation result

[H3] Network request timing out (Low)
- Evidence: api/client.ts:10 - 5s timeout
- Verify: Log request duration

Debug logs added at 5 locations. Please submit the form and let me know.

User: Done, here's the console output...

Agent: Confirmed H1 - The API returns 422 but the error handler
only catches 400. Proposed fix:

// api/submit.ts:45
- if (error.response?.status === 400) {
+ if (error.response?.status === 400 || error.response?.status === 422) {

Apply this fix?

User: Yes

Agent: Fixed. Please try submitting again.

User: Works now!

Agent: Bug resolved. Removed 5 debug logs.

Summary:
- Root cause: Error handler not catching 422 status
- Fix: Added 422 to error status check
- Files modified: api/submit.ts
```

## License

MIT
