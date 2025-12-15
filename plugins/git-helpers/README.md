# git-helpers

Git workflow helper commands for Claude Code.

## Installation

```bash
/plugin install git-helpers
```

## Commands

| Command | Description |
|---------|-------------|
| `/code-review` | Review code changes for issues |
| `/commit` | Create commits with well-formatted messages |
| `/commit -s` | Commit only staged files |
| `/details` | Generate PR title and description to file |
| `/create-pr` | Create PR with generated details |

## Workflow

```
/code-review (optional) --> /commit --> /details --> /create-pr
         |                      |           |            |
         v                      v           v            v
CODE_REVIEW.md              commit    PR_DETAILS.md  PR created
```

## Agents

| Agent | Description |
|-------|-------------|
| `code-reviewer` | Senior code reviewer for quality analysis |

## Usage

### /code-review

Review code changes using the `code-reviewer` agent.

```bash
/code-review          # Review uncommitted changes, or branch diff if clean
/code-review main     # Compare against main branch
```

**Output:** `CODE_REVIEW.md` with issues, suggestions, and summary.

**Modes:**
- Uncommitted changes: reviews staged + unstaged files
- Branch comparison: compares against base branch (when no local changes)

### /commit

Create a commit with an auto-generated message based on the actual diff.

```bash
/commit           # Stage all files and commit
/commit -s        # Commit only staged files
```

**Message format:** `type: concise description`

**Types:** `feat`, `fix`, `refactor`, `chore`, `docs`, `test`

### /details

Generate PR title and description and save to file.

```bash
/details          # Auto-detect base branch
/details main     # Use main as base
```

**Output:** `PR_DETAILS.md`

### /create-pr

Generate PR details and create the Pull Request directly.

```bash
/create-pr          # Auto-detect base branch
/create-pr main     # Use main as base
```

**Requires:** `gh` cli installed and authenticated.

**Output:** PR created, returns PR URL.

## Key Principles

- Analyzes actual file changes, not conversation context
- Messages reflect current implementation state
- Concise, actionable output
- No unnecessary sections or verbose templates

## License

MIT
