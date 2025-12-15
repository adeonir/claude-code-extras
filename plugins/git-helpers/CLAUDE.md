# git-helpers

Git workflow helper commands for Claude Code.

## Workflow

```
/code-review (optional) --> /commit --> /details --> /create-pr
         |                      |           |            |
         v                      v           v            v
   CODE_REVIEW.md            commit    PR_DETAILS.md  PR created
```

## Commands

### /code-review

Review code changes using the `code-reviewer` agent.

**Usage:**
```bash
/code-review          # Review uncommitted changes, or branch diff if clean
/code-review main     # Compare against main branch
```

**Output:** `CODE_REVIEW.md`

**Key behavior:**
- Analyzes the actual diff, not conversation context
- Focus: bugs, security, performance, maintainability
- Supports uncommitted changes (staged + unstaged) when on main with local modifications
- Falls back to branch comparison when working directory is clean

### /commit

Create commits with well-formatted messages based on actual file changes.

**Usage:**
```bash
/commit           # Stage all files and commit
/commit -s        # Commit only staged files
```

**Message format:** `type: concise description`

**Key behavior:**
- Analyzes the actual diff, not conversation context
- Handles pre-commit hooks with automatic amend

### /details

Generate comprehensive PR description with structured analysis.

**Usage:**
```bash
/details              # Auto-detect base branch
/details development  # Use development as base
```

**Output:** `PR_DETAILS.md`

**Key behavior:**
- Analyzes commits and diff, not conversation context
- Categorizes files: Core, API, State, UI, Config, Docs
- Includes Technical Flow, Impact Assessment, Priority Review Areas
- Provides Testing Instructions

### /create-pr

Generate PR details and create the Pull Request directly.

**Usage:**
```bash
/create-pr          # Auto-detect base branch
/create-pr main     # Use main as base
```

**Requires:** `gh` cli

**Output:** PR created, returns PR URL

**Key behavior:**
- Analyzes commits and diff, not conversation context
- Creates PR via `gh pr create`

## Agents

### code-reviewer

Senior code reviewer for quality analysis. Invoked by `/code-review`.

**Focus:** bugs, security, performance, maintainability

**Output format:**
```markdown
## Issues
- **[file:line]** Problem description
  - Suggested fix

## Suggestions
- **[file:line]** Improvement description
  - How to improve

## Summary
X files | Y issues | Z suggestions
```

## Types

`feat`, `fix`, `refactor`, `chore`, `docs`, `test`
