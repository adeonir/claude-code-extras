# git-helpers

Git workflow helper commands for Claude Code.

> **Part of [claude-code-plugins](https://github.com/adeonir/claude-code-plugins)** - A curated marketplace of Claude Code plugins for feature development, debugging, frontend generation, and git helpers.

## Features

- Code review with quality analysis and confidence-based filtering
- Auto-generated commit messages from actual diffs
- Structured PR descriptions with impact assessment
- Direct PR creation via GitHub CLI
- Supports uncommitted changes and branch comparisons

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) - Anthropic's official CLI for Claude
- [gh](https://cli.github.com/) - GitHub CLI (required for `/create-pr` command)

### Add Marketplace

First, add the marketplace to Claude Code (only needed once):

```bash
/plugin marketplace add adeonir/claude-code-plugins
```

### Install Plugin

```bash
/plugin install git-helpers
```

This command automatically:
- Downloads the plugin from the marketplace
- Makes all git workflow commands available in your Claude Code session

## Commands

| Command | Description |
|---------|-------------|
| `/code-review` | Review code changes for issues |
| `/commit` | Create commits with well-formatted messages |
| `/commit -s` | Commit only staged files |
| `/details` | Generate PR title and description to file |
| `/create-pr` | Create PR with generated details |

## Workflow

```
/code-review (optional) --> /commit --> /details --> /create-pr
         |                      |           |            |
         v                      v           v            v
CODE_REVIEW.md              commit    PR_DETAILS.md  PR created
```

## Agents

| Agent | Description |
|-------|-------------|
| `code-reviewer` | Senior code reviewer for quality analysis |

## Usage

### /code-review

Review code changes using the `code-reviewer` agent.

```bash
/code-review          # Review uncommitted changes, or branch diff if clean
/code-review main     # Compare against main branch
```

**Output:** `CODE_REVIEW.md` with issues, suggestions, and summary.

**Modes:**
- Uncommitted changes: reviews staged + unstaged files
- Branch comparison: compares against base branch (when no local changes)

### /commit

Create a commit with an auto-generated message based on the actual diff.

```bash
/commit           # Stage all files and commit
/commit -s        # Commit only staged files
```

**Message format:** `type: concise description`

**Types:** `feat`, `fix`, `refactor`, `chore`, `docs`, `test`

### /details

Generate PR title and description and save to file.

```bash
/details          # Auto-detect base branch
/details main     # Use main as base
```

**Output:** `PR_DETAILS.md`

### /create-pr

Generate PR details and create the Pull Request directly.

```bash
/create-pr          # Auto-detect base branch
/create-pr main     # Use main as base
```

**Requires:** `gh` cli installed and authenticated.

**Output:** PR created, returns PR URL.

## Key Principles

- Analyzes actual file changes, not conversation context
- Messages reflect current implementation state
- Concise, actionable output
- No unnecessary sections or verbose templates

## License

MIT
