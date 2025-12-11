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
│   ├── agents/               # Subagents (code-explorer, code-architect, etc.)
│   ├── commands/             # Slash commands (/spec, /plan, /tasks, etc.)
│   └── templates/            # Artifact templates
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
│   ├── agents/               # Subagents (copy-extractor, design-extractor, etc.)
│   ├── commands/             # Slash commands (/extract-copy, /extract-design, etc.)
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
`/spec` -> `/clarify` -> `/plan` -> `/tasks` -> `/implement` -> `/review`

Artifacts persisted in `.specs/{branch}/` (spec.md, plan.md, tasks.md).

### debug-tools
Iterative debugging workflow: `/debug "bug description"`

Conversational flow: generates hypotheses -> injects `[DEBUG]` logs -> user reproduces -> analyzes runtime logs -> proposes fix -> user verifies -> cleanup.

Uses Console Ninja MCP for runtime values and Chrome DevTools MCP for browser inspection.

### design-builder
Two entry points, each can end with `/build-frontend` or `/generate-prompt`:
- **Full**: URL -> `/extract-copy` -> `copy.yaml` -> `/extract-design` -> `design.json`
- **Minimal**: Image -> `/extract-design` -> `design.json` (with brief project description)

Then choose: `/build-frontend` (Claude Code builds it) or `/generate-prompt` (for Replit/v0/Lovable)

Outputs go to `./prompts/` directory.

### git-helpers
Workflow: `/code-review` -> `/commit` -> `/details` -> `/create-pr`

Commands analyze actual git diffs, not conversation context. Commit message format: `type: concise description` where type is one of: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`.

## Writing New Plugins

1. Create directory under `plugins/<name>/`
2. Add `.claude-plugin/plugin.json` manifest with arrays for `commands`, `agents`, `skills`
3. Register in `.claude-plugin/marketplace.json`
4. Commands/agents/skills are markdown files with prompts
