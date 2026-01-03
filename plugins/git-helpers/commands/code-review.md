---
description: Review code changes using specialized agents
argument-hint: "[base-branch] [--comment]"
---

# Code Review Command

Review code changes using `code-reviewer` and `guidelines-auditor` agents.

## Arguments

- **No argument**: Review uncommitted changes, or branch diff if clean
- **`base-branch`**: Compare against specified base branch
- **`--comment`**: Post review as PR comment via gh cli

## Usage

```bash
/git-helpers:code-review              # Terminal output, ask to save
/git-helpers:code-review main         # Compare against main
/git-helpers:code-review --comment    # Post to PR via gh
```

## Process

1. **Parse arguments**:
   - Check if `--comment` flag is present
   - Extract base branch if provided

2. **Determine base branch**:
   - If provided: use specified branch
   - If not: auto-detect (`development` -> `develop` -> `main` -> `master`)

3. **Detect review mode**:
   - Run `git status --porcelain` to check for uncommitted changes
   - If uncommitted changes: review working directory
   - If clean: compare current branch against base

4. **Get modified files and diff**:
   - For uncommitted changes:
     - Files: `git diff --name-only` + `git diff --cached --name-only`
     - Diff: `git diff` + `git diff --cached`
   - For branch comparison:
     - Files: `git diff $BASE...HEAD --name-only`
     - Diff: `git diff $BASE...HEAD`

5. **Launch agents in parallel**:
   - `code-reviewer`: Bug detection, security, performance
   - `guidelines-auditor`: CLAUDE.md compliance checking

6. **Combine results and output**:
   - If `--comment`: Post combined review to PR via `gh pr comment`
   - Otherwise: Output to terminal, then ask if user wants to save to `CODE_REVIEW.md`

## Output Format

```markdown
# Code Review: {branch-name}

Reviewed against `{base-branch}` | {date}

## Issues

Only issues with confidence >= 80 are reported.

- **[{score}] [{file}:{line}]** Issue description
  - Why it's a problem and how to fix

## CLAUDE.md Compliance

- **[{score}] [{file}:{line}]** Guideline violation
  - Which guideline and how to fix

## Summary

X files | Y issues | Z compliance findings
```

## Notes

- Only reports issues with >= 80 confidence score
- Analyzes actual diff, not conversation context
- Guidelines auditor reads CLAUDE.md files from repository
