---
description: Push branch and create PR via gh cli
---

# Push PR Command

Push current branch and create a Pull Request.

## Arguments

- `$1` - Base branch (optional, auto-detects: main > master > develop)

## Current State

!`git branch --show-current`

!`which gh >/dev/null 2>&1 && echo "gh cli: installed" || echo "gh cli: NOT FOUND - install from https://cli.github.com"`

## Process

1. **Check prerequisites**:

   - gh cli must be installed
   - Must not be on base branch

2. **Gather context**:

   ```bash
   git log {base}..HEAD --oneline
   git diff {base}...HEAD --stat
   git diff {base}...HEAD
   ```

3. **Push branch**:

   ```bash
   git push -u origin HEAD
   ```

4. **Create PR**:

   ```bash
   gh pr create --title "type: description" --body "..."
   ```

5. **Output PR URL**

## PR Types

| Type       | Use when                                     |
| ---------- | -------------------------------------------- |
| `feat`     | Adding new functionality                     |
| `fix`      | Fixing a bug                                 |
| `refactor` | Restructuring code without changing behavior |
| `chore`    | Maintenance tasks, dependencies, configs     |
| `docs`     | Documentation changes                        |
| `test`     | Adding or updating tests                     |

## PR Format

**Title**: `type: concise description`

**Body**:

```markdown
{2-3 sentence summary}

## Changes

- {key change 1}
- {key change 2}
- {key change 3}
```

## Rules

- Analyze the diff, not conversation
- Use imperative mood
- Keep changes list to 3-5 items
- No attribution lines

## Task

Push and create PR. Base branch: $ARGUMENTS
