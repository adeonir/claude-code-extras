---
description: Build frontend components from design tokens
argument-hint: [--variants]
---

# Build Frontend Command

Build production-grade frontend components using Claude Code.

## Arguments

- `--variants` - Generate 4 HTML+CSS preview variants for comparison before building React

Arguments received: $ARGUMENTS

## Process

### If --variants is present

Invoke the `variants-builder` subagent to generate 4 HTML+CSS preview variants.

The variants-builder will:

1. Load the frontend-design skill first
2. Locate design.json (required) and copy.yaml (optional)
3. Generate all 4 presets (minimal, editorial, startup, bold) in ./outputs/
4. Create index.html for side-by-side comparison
5. Run `npx http-server ./outputs -o -p 8080`
6. Inform user to open http://localhost:8080

After comparison, user tells Claude which variant to use (e.g., "use editorial") and the frontend-builder will create the React application based on that layout.

### If --variants is NOT present

Invoke the `frontend-builder` subagent to build React directly.

The frontend-builder will:

1. Detect existing project stack (React, Vue, Svelte, etc.)
2. If no project, ask user for preferred stack
3. Scaffold new project if needed
4. Locate design.json (required) and copy.yaml (optional)
5. If no copy.yaml, ask user for brief project description
6. Generate components in ./src/ applying the frontend-design skill

Wait for the agent to complete and inform the user of the result.

## Error Handling

- **No design.json found**: Run /design-builder:design first to extract design tokens
- **Scaffold failed**: Check package manager is installed and available
