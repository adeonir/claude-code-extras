# OpenCode Extras

Use the same plugins from this repository in [OpenCode](https://opencode.ai).

## Installation

Clone the repository and run the install script:

```bash
git clone https://github.com/adeonir/claude-code-extras
cd claude-code-extras
./install/opencode.sh
```

This copies agents and commands to `~/.config/opencode/`.

## Update

Pull the latest changes and reinstall:

```bash
cd claude-code-extras
git pull
./install/opencode.sh
```

## Available Plugins

| Plugin      | Agents                                                                                  | Commands                                                                                                                        |
| ----------- | --------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| git-helpers | `code-reviewer`, `guidelines-auditor`                                                   | `/git-review`, `/git-commit`, `/git-summary`, `/git-push-pr`                                                                    |
| spec-driven | `researcher`, `explorer`, `architect`, `validator`, `tasker`, `implementer`, `archiver` | `/spec-init`, `/spec-clarify`, `/spec-plan`, `/spec-tasks`, `/spec-implement`, `/spec-validate`, `/spec-archive`, `/spec-specs` |

## Usage

### git-helpers

```bash
# Commands
/git-review              # Review code changes
/git-review main         # Review against main branch
/git-commit              # Create commit with formatted message
/git-commit --staged     # Commit only staged files
/git-summary             # Generate PR_DETAILS.md
/git-push-pr             # Push branch and create PR

# Agents
@code-reviewer           # Review code for bugs and security issues
@guidelines-auditor      # Check CLAUDE.md compliance
```

### spec-driven

Specification-driven development workflow:

```bash
# Workflow: init -> clarify -> plan -> tasks -> implement -> validate -> archive

/spec-init "feature description"    # Create specification
/spec-init @prd.md                  # Create from PRD file
/spec-clarify                       # Resolve ambiguities
/spec-plan                          # Generate technical plan
/spec-tasks                         # Generate task list
/spec-implement                     # Execute next task
/spec-implement T001-T005           # Execute task range
/spec-implement --all               # Execute all tasks
/spec-validate                      # Validate artifacts and code
/spec-archive                       # Generate docs and archive
/spec-specs                         # List all features by status

# Agents
@researcher          # Research external technologies
@explorer            # Analyze codebase patterns
@architect           # Create technical plans
@validator           # Validate artifacts
@tasker              # Generate task lists
@implementer         # Execute tasks
@archiver            # Generate documentation
```

## Structure

OpenCode versions live inside each plugin at `plugins/*/_opencode/`:

```
plugins/git-helpers/
├── agents/           # Claude Code
├── commands/         # Claude Code
└── _opencode/        # OpenCode
    ├── agents/
    └── commands/
```

## Differences from Claude Code

OpenCode plugins use adapted frontmatter and support additional features:

| Feature          | Claude Code          | OpenCode                |
| ---------------- | -------------------- | ----------------------- |
| Shell injection  | No                   | `` !`git status` ``     |
| Positional args  | `$ARGUMENTS`         | `$1`, `$2`, `$3`        |
| File reference   | No                   | `@file.md`              |
| Agent mode       | `color`              | `mode: subagent`        |
| Tool permissions | `tools: Read, Write` | `tools: {write: false}` |

## License

MIT
