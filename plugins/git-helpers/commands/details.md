---
description: Generate PR title and description to file
argument-hint: [base-branch]
allowed-tools: Bash(git:*), Write
---

# PR Details Command

Generate a title and description for a Pull Request and save to `PR_DETAILS.md`.

## Arguments

- **No argument**: Auto-detect base branch (main > master > develop)
- **`base-branch`**: Use specified branch as base for comparison

## Process

1. **Detect base branch** (if not specified):
   ```bash
   git branch -a | grep -E "(main|master|develop)$" | head -1
   ```

2. **Gather context** (run in parallel):
   ```bash
   git branch --show-current
   git log {base}..HEAD --oneline
   git diff {base}...HEAD --stat
   git diff {base}...HEAD
   ```

3. **Analyze changes**:
   - Review commits and diff to understand what changed
   - Base analysis solely on file contents, not conversation context
   - Determine the appropriate PR type

4. **Save to file**:
   - Always save to `PR_DETAILS.md` in repository root

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

Generate PR description for current branch with $ARGUMENTS and save to `PR_DETAILS.md`.
