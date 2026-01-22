---
description: Review code changes using code-reviewer and guidelines-auditor agents
subtask: true
---

# Review Command

Review code changes for bugs, security issues, and CLAUDE.md compliance.

## Arguments

- `$1` - Base branch to compare against (optional, auto-detects if not provided)
- `--comment` - Post review as PR comment via gh cli

## Current State

!`git status --porcelain | head -20`

## Process

1. **Determine what to review**:

   - If uncommitted changes exist: review working directory
   - If clean: compare current branch against base branch

2. **Detect base branch** (if not specified):

   - Try in order: `development`, `develop`, `main`, `master`

3. **Get the diff**:

   - For uncommitted: `git diff` + `git diff --cached`
   - For branch: `git diff {base}...HEAD`

4. **Review for issues**:

   - Security vulnerabilities (SQL injection, XSS, auth bypass, credential exposure)
   - Bugs that will cause runtime failures
   - Data loss risks
   - Severe performance issues (N+1 queries, memory leaks)
   - Only report issues with >= 80 confidence score

5. **Check CLAUDE.md compliance**:

   - Find all CLAUDE.md files in the repository
   - Check changes against explicit guidelines
   - Only report clear violations (>= 80 confidence)

6. **Output results**:
   - If `--comment` in arguments: post to PR via `gh pr comment`
   - Otherwise: output to terminal

## Output Format

```markdown
# Code Review: {branch-name}

Reviewed against `{base-branch}` | {date}

## Issues

- **[{score}] [{file}:{line}]** Issue description
  - Why it's a problem and how to fix

## CLAUDE.md Compliance

- **[{score}] [{file}:{line}]** Guideline violation
  - Which guideline and how to fix

## Summary

X files | Y issues | Z compliance findings
```

## Task

Review code changes. Arguments: $ARGUMENTS
