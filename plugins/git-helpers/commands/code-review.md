---
description: Review code changes using code-reviewer agent
argument-hint: [base-branch]
---

# Code Review Command

Review code changes using the `code-reviewer` agent.

## Arguments

- **No argument**: Review uncommitted changes (staged + unstaged), or branch diff if on a feature branch
- **`base-branch`**: Compare current branch against specified base branch

## Context

- Current branch: !`git branch --show-current`

## Task

1. **Detect review mode**:
   - Run `git status --porcelain` to check for uncommitted changes
   - If there are uncommitted changes: review those files (working directory changes)
   - If no uncommitted changes: compare against base branch (use `$ARGUMENTS` if provided, otherwise auto-detect main/master/develop)

2. **Get modified files**:
   - For uncommitted changes: `git diff --name-only` (unstaged) and `git diff --cached --name-only` (staged)
   - For branch comparison: `git diff <base-branch>...HEAD --name-only`

3. **Launch code-reviewer agent**: Pass the list of modified files to review

The agent should:
1. Read each modified file
2. Analyze for bugs, security issues, performance problems, and maintainability concerns
3. Generate `CODE_REVIEW.md` with issues, suggestions, and summary
