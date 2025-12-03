---
description: Build React 19 + Tailwind v4 components from copy.yaml and design.json
argument-hint: [--output=path]
---

Build production-grade React components using Claude Code instead of external tools.

**Arguments received:** $ARGUMENTS

**Task:** Use the frontend-builder agent to:
1. Locate copy.yaml and design.json
2. Use --output if provided, otherwise ask user for directory
3. Generate React 19 + Tailwind v4 components with all design tokens applied
