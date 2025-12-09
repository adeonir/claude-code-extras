---
description: Create PR with generated title and description
argument-hint: [base-branch]
allowed-tools: Bash(git:*), Bash(gh:*), Bash(which gh)
---

# Create PR Command

Generate PR details and create the Pull Request directly via `gh` cli.

## Arguments

- **No argument**: Auto-detect base branch (main > master > develop)
- **`base-branch`**: Use specified branch as base for comparison

## Process

1. **Check gh cli availability**:
   ```bash
   which gh
   ```
   If not available, stop and inform user to install `gh` cli or use `/details` instead.

2. **Detect base branch** (if not specified):
   ```bash
   git branch -a | grep -E "(main|master|develop)$" | head -1
   ```

3. **Gather context** (run in parallel):
   ```bash
   git branch --show-current
   git log {base}..HEAD --oneline
   git diff {base}...HEAD --stat
   git diff {base}...HEAD
   ```

4. **Analyze changes**:
   - Review commits and diff to understand what changed
   - Base analysis solely on file contents, not conversation context
   - Determine the appropriate PR type

5. **Create PR**:
   ```bash
   gh pr create --title "type: description" --body "..."
   ```

## PR Types

| Type | Use when |
|------|----------|
| `feat` | Adding new functionality |
| `fix` | Fixing a bug |
| `refactor` | Restructuring code without changing behavior |
| `chore` | Maintenance tasks, dependencies, configs |
| `docs` | Documentation changes |
| `test` | Adding or updating tests |

## Format

**Title:** `type: concise description` or `type(scope): concise description`

**Body:**
```markdown
Brief summary of what this PR does (2-3 sentences max).

## Changes
- Key change 1
- Key change 2
- Key change 3
```

## Guidelines

- Analyze commits and diff, not conversation context
- Title and description should reflect the current implementation state
- Be specific about functionality, not generic
- Focus on WHAT is being done, not HOW
- Use imperative mood: "add", "fix", "implement"
- Keep changes list to 3-5 key items
- Do not include risk assessment, testing instructions, or technical flow sections

## Task

Generate PR details for current branch with $ARGUMENTS and create PR using `gh pr create`.

Output the PR URL when done.
