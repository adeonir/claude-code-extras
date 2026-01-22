# Changelog

All notable changes to this plugin will be documented in this file.

## v1.2.2 (2026-01-22)

### Changed

- Rename `/details` command to `/summary` for clarity
- Rename `/code-review` command to `/review` for simplicity

## v1.2.1 (2026-01-07)

### Changed

- `/commit`: never use scope in commit type (`feat:` not `feat(scope):`)
- `/commit`: never add Co-Authored-By or similar attribution lines
- `/push-pr`: allow scope in PR title (`feat:` or `feat(scope):` both valid)
- `/push-pr`: never add Co-Authored-By or similar attribution lines

## v1.2.0 (2026-01-03)

### Added

- Confidence scoring (0-100) for code review findings
- `guidelines-auditor` agent for CLAUDE.md compliance checking
- `--comment` flag to post review as PR comment via gh cli
- Command prefixes (`/git-helpers:*`) for consistency
- Mermaid workflow diagram in documentation

### Changed

- Rename `/create-pr` to `/push-pr` (more descriptive)
- Code review now outputs to terminal first, asks to save
- Output format includes confidence score per issue: `[score] [file:line]`
- Only report issues with >= 80 confidence

### Fixed

- README.md URL references (claude-code-plugins -> claude-code-extras)

## v1.1.1 (2025-12-14)

### Fixed

- Support uncommitted changes in code-review command
- Remove command substitution that caused permission errors
- Add detection for staged and unstaged changes when on main branch

## v1.1.0 (2025-12-11)

### Changed

- Enhance `/details` command with comprehensive PR template
- Add file categorization and structured analysis sections
- Include Technical Flow, Impact Assessment, Priority Review Areas
- Add pre-execution validation for branch checks

## v1.0.0 (2025-12-02)

### Added

- Initial release
- `/code-review` command for analyzing code changes
- `/commit` command for creating well-formatted commits
- `/details` command for generating PR descriptions
- `/create-pr` command for creating pull requests
- `code-reviewer` agent for quality analysis
