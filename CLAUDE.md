# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Claude Code plugin marketplace with a plugins-only architecture. All agents, commands, and skills are packaged as plugins - from minimal single-command plugins to comprehensive multi-agent workflows. Install via `/plugin install <name>`.

## Architecture

```
.claude-plugin/
└── marketplace.json          # Marketplace registry listing all plugins

plugins/
├── spec-driven/              # Specification-driven workflow
│   ├── .claude-plugin/plugin.json
│   ├── .mcp.json             # Serena MCP
│   ├── agents/               # Subagents (web-researcher, code-explorer, code-architect, spec-validator, etc.)
│   └── commands/             # Slash commands (/init, /plan, /tasks, /validate, /archive, etc.)
│
├── debug-tools/              # Debugging workflow plugin
│   ├── .claude-plugin/plugin.json
│   ├── .mcp.json             # Console Ninja + Chrome DevTools MCP
│   ├── agents/               # Subagents (bug-investigator, log-injector)
│   ├── commands/             # Slash commands (/debug)
│   └── skills/               # Auto-loaded skills (debugging)
│
├── design-builder/           # Frontend generation plugin
│   ├── .claude-plugin/plugin.json
│   ├── agents/               # Subagents (copy-extractor, design-extractor, variants-builder, etc.)
│   ├── commands/             # Slash commands (/extract-copy, /extract-design, /build-frontend, etc.)
│   ├── templates/            # HTML templates (preview.html)
│   └── skills/               # Auto-loaded skills (frontend-design)
│
└── git-helpers/              # Git workflow plugin
    ├── .claude-plugin/plugin.json
    ├── agents/               # Subagents (code-reviewer)
    └── commands/             # Slash commands (/code-review, /commit, /details, /create-pr)
```

## Plugin Structure

Each plugin follows this structure:
- `.claude-plugin/plugin.json` - Plugin manifest defining commands, agents, and skills
- `agents/*.md` - Subagent definitions (invoked via Task tool)
- `commands/*.md` - Slash command prompts
- `skills/*/SKILL.md` - Auto-loaded contextual guidance

## Key Plugins

### spec-driven
Specification-driven development workflow:
`/init` -> `/clarify` -> `/plan` -> `/tasks` -> `/implement` -> `/validate` -> `/archive`

Features organized by sequential ID (`001-user-auth/`, `002-add-2fa/`) with optional branch association. The `/plan` command checks `docs/research/` for existing research before invoking `web-researcher` agent.

Artifacts persisted in `.specs/{ID}-{feature}/` (spec.md, plan.md, tasks.md). Research shared in `docs/research/`. Documentation generated to `docs/features/` via `/archive`.

### debug-tools
Iterative debugging workflow: `/debug-tools:debug "bug description"`

5-phase workflow: Investigate (with confidence scoring) -> Inject Logs -> Propose Fix -> Verify -> Cleanup. Findings rated 0-100: >= 70 high confidence, 50-69 medium, < 50 not reported.

Uses Console Ninja MCP for runtime values and Chrome DevTools MCP for browser inspection.

### design-builder
Two entry points:
- **Full**: URL -> `/extract-copy` -> `copy.yaml` -> `/extract-design` -> `design.json`
- **Minimal**: Image -> `/extract-design` -> `design.json` (with brief project description)

Then build:
- `/build-frontend` - React directly
- `/build-frontend --variants` - 4 HTML previews -> choose -> React

**Design Variants**: Generate 4 layout presets (minimal, editorial, startup, bold) as HTML+CSS previews. Compare at http://localhost:8080, then tell Claude which to use (e.g., "use editorial") and it builds the React app.

### git-helpers
Workflow: `/code-review` -> `/commit` -> `/details` -> `/create-pr`

Commands analyze actual git diffs, not conversation context. Commit message format: `type: concise description` where type is one of: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`.

## Writing New Plugins

1. Create directory under `plugins/<name>/`
2. Add `.claude-plugin/plugin.json` manifest with arrays for `commands`, `agents`, `skills`
3. Register in `.claude-plugin/marketplace.json`
4. Commands/agents/skills are markdown files with prompts
