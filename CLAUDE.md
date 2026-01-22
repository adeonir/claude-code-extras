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
│   ├── agents/               # Subagents (researcher, explorer, architect, validator, tasker, implementer, archiver)
│   └── commands/             # Slash commands (/init, /plan, /tasks, /validate, /archive, etc.)
│
├── debug-tools/              # Debugging workflow plugin
│   ├── .claude-plugin/plugin.json
│   ├── .mcp.json             # Console Ninja + Chrome DevTools MCP
│   ├── agents/               # Subagents (bug-investigator, log-injector)
│   ├── commands/             # Slash commands (/debug)
│   └── skills/               # Auto-loaded skills (debugging)
│
├── design-builder/           # Frontend/Figma generation plugin
│   ├── .claude-plugin/plugin.json
│   ├── agents/               # Subagents (product-planner, copy-extractor, design-extractor, figma-builder, etc.)
│   ├── commands/             # Slash commands (/plan, /copy, /design, /frontend, /figma)
│   └── skills/               # Auto-loaded skills (frontend-design)
│
└── git-helpers/              # Git workflow plugin
    ├── .claude-plugin/plugin.json
    ├── agents/               # Subagents (code-reviewer, guidelines-auditor)
    └── commands/             # Slash commands (/review, /commit, /summary, /push-pr)
```

## Plugin Structure

Each plugin follows this structure:
- `.claude-plugin/plugin.json` - Plugin manifest defining commands, agents, and skills
- `agents/*.md` - Subagent definitions (invoked via Task tool)
- `commands/*.md` - Slash command prompts
- `skills/*/SKILL.md` - Auto-loaded contextual guidance

## Key Plugins

### spec-driven
Specification-driven development workflow with brownfield support:
`/init` -> `/clarify` -> `/plan` -> `/tasks` -> `/implement` -> `/validate` -> `/archive`

Supports both greenfield (new features) and brownfield (modifications to existing code). The `/init` command auto-detects type based on keywords and codebase analysis. Brownfield specs include a Baseline section documenting current implementation.

Features organized by sequential ID (`001-user-auth/`, `002-add-2fa/`) with optional branch association. The `/validate` command works at any workflow phase, auto-detecting mode (Spec, Plan, Tasks, Full) based on available artifacts.

Artifacts persisted in `.specs/{ID}-{feature}/` (spec.md, plan.md, tasks.md). Research shared in `docs/research/`. Feature docs generated to `docs/features/`, changelog to `docs/CHANGELOG.md` via `/archive`.

### debug-tools
Iterative debugging workflow: `/debug-tools:debug "bug description"`

5-phase workflow: Investigate (with confidence scoring) -> Inject Logs -> Propose Fix -> Verify -> Cleanup. Findings rated 0-100: >= 70 high confidence, 50-69 medium, < 50 not reported.

Uses Console Ninja MCP for runtime values and Chrome DevTools MCP for browser inspection.

### design-builder
Multiple entry points:
- **From scratch**: `/design-builder:plan` -> `product-plan.yaml` -> `/design-builder:design` -> `design.json`
- **URL reference**: `/design-builder:copy` -> `copy.yaml` -> `/design-builder:design` -> `design.json`
- **Image reference**: `/design-builder:design` -> `design.json` (with brief description)

Multiple outputs:
- `/design-builder:frontend` - React directly
- `/design-builder:frontend --variants` - 4 HTML previews -> choose -> React
- `/design-builder:figma` - HTML for Figma import via YashiTech plugin (40/week free)

**Design Variants**: Generate 4 layout presets (minimal, editorial, startup, bold) as HTML+CSS previews. Compare at http://localhost:8080, then tell Claude which to use (e.g., "use editorial").

### git-helpers

Workflow: `/git-helpers:review` -> `/git-helpers:commit` -> `/git-helpers:summary` -> `/git-helpers:push-pr`

Confidence-scored code review (>= 80 threshold) with CLAUDE.md compliance checking. Commands analyze actual git diffs, not conversation context. Commit message format: `type: concise description`.

## Writing New Plugins

1. Create directory under `plugins/<name>/`
2. Add `.claude-plugin/plugin.json` manifest with arrays for `commands`, `agents`, `skills`
3. Register in `.claude-plugin/marketplace.json`
4. Commands/agents/skills are markdown files with prompts

## Version Bumps

When bumping a plugin version, update ALL references:

1. `plugins/<name>/.claude-plugin/plugin.json` - version field
2. `plugins/<name>/CHANGELOG.md` - new version entry
3. `plugins/<name>/CLAUDE.md` - relevant sections
4. `plugins/<name>/README.md` - features, workflow
5. `.claude-plugin/marketplace.json` - version, description, keywords
6. `README.md` (root) - version in plugins table
7. `CLAUDE.md` (root) - plugin description if changed
