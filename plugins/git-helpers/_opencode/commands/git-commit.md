---
description: Create commits with well-formatted messages based on actual changes
---

# Commit Command

Create a commit with a well-formatted message based on the actual file changes.

## Arguments

- `-s` or `--staged` - commit only staged files (default: stage all changes)

## Current State

!`git status --short`

!`git log --oneline -5`

## Process

1. **Get the diff** to understand what changed:

   ```bash
   git diff HEAD
   ```

2. **Stage files** (unless `--staged` flag):

   ```bash
   git add .
   ```

3. **Create commit**:

   ```bash
   git commit -m "type: concise description"
   ```

4. **Verify**:
   ```bash
   git log -1 --format="%B"
   ```

## Commit Types

| Type       | Use when                                     |
| ---------- | -------------------------------------------- |
| `feat`     | Adding new functionality                     |
| `fix`      | Fixing a bug                                 |
| `refactor` | Restructuring code without changing behavior |
| `chore`    | Maintenance tasks, dependencies, configs     |
| `docs`     | Documentation changes                        |
| `test`     | Adding or updating tests                     |

## Message Format

```
type: concise description in imperative mood

- Optional bullet if change spans 3+ areas
- Keep to 3-4 items max
```

## Rules

- Analyze the actual diff, not conversation context
- Use imperative mood: "add", "fix", "implement"
- Focus on WHAT, not HOW
- No file names or technical decisions
- No version numbers (e.g., "update lodash" not "update lodash to 4.17.21")
- No scope: use `feat:` not `feat(scope):`
- No attribution lines (Co-Authored-By, etc.)

## Task

Create commit. Arguments: $ARGUMENTS
