# Changelog

All notable changes to this plugin will be documented in this file.

## v2.2.0 (2026-01-05)

### Added
- Requirements Traceability in `code-architect` agent
  - New "Requirements Mapping" step in process
  - Mandatory "Requirements Traceability" table in plan.md output
- Requirements Coverage in `task-generator` agent
  - New "Extract Requirements" step to read spec.md
  - New "Verify Requirements Coverage" step
  - Mandatory "Requirements Coverage" table in tasks.md output
- `/tasks` command now passes spec.md to task-generator agent

### Changed
- Task categories renamed for clarity:
  - "Setup & Dependencies" -> "Foundation"
  - "Core Implementation" -> "Implementation"
  - "Testing & Validation" -> "Validation"
  - "Polish & Documentation" -> "Documentation"
- `code-architect` must map every FR-xxx to components
- `task-generator` must ensure every FR-xxx has at least one task

## v2.1.0 (2026-01-03)

### Added
- Documentation Discovery phase in `code-explorer` agent
  - Scans READMEs in related directories
  - Finds architecture docs, diagrams (mermaid, dbml, puml, drawio)
  - Checks related specs and CLAUDE.md for conventions
- Documentation Review phase in `code-architect` agent
  - Extracts implicit requirements from diagrams
  - Verifies plan completeness against documentation
- Documentation Context section in plan.md template
- Planning Completeness validation in `spec-validator` agent
  - Detects unplanned files created during implementation
  - Reports planning gaps for future improvements

### Changed
- `code-explorer` now includes documentation findings in output
- `code-architect` verifies files against discovered documentation
- `spec-validator` reports planning gaps (non-blocking feedback)

## v2.0.0 (2026-01-03)

### Added
- Feature organization by sequential ID (`001-user-auth/`, `002-add-2fa/`)
- Optional branch association for automatic feature detection
- `/init` command (renamed from `/spec`) with `--link` flag for branch association
- `/validate` command (renamed from `/review`) with three-level validation
- `/archive` command for documentation generation
- `/specs` command to list all features by status
- `spec-validator` agent with artifact, consistency, and code validation
- `spec-archiver` agent for documentation generation
- Shared research in `docs/research/` for cross-feature reuse
- Feature documentation output to `docs/features/` with changelog
- Frontmatter metadata in spec.md (id, feature, status, branch, created)

### Changed
- Renamed `/spec` to `/init`
- Renamed `/review` to `/validate`
- Renamed `code-reviewer` agent to `spec-validator`
- Artifacts now in `.specs/{ID}-{feature}/` instead of `.specs/{branch}/`
- Research output to `docs/research/{topic}.md` (shared, committed)
- `/implement` auto-marks as `review` when all tasks complete
- `/validate` auto-marks as `done` if all checks pass
- All commands support optional `[ID]` argument
- Updated all commands with `/spec-driven:` prefix

### Removed
- Branch-based artifact organization
- Feature-specific research.md (now shared in docs/research/)
- Templates folder (formats defined in agents/commands)

## v1.2.0 (2025-12-19)

### Added
- Context Flow system for consistent context passing between phases
- Critical Files section in plan.md (Reference, Modify, Create)
- Artifacts section in tasks.md with references to all spec artifacts
- Acceptance Criteria validation in /implement and /review
- Architecture compliance validation in /review
- Reference file loading for implement-agent (patterns to follow)

### Changed
- code-architect now receives and outputs consolidated Critical Files
- implement-agent receives spec.md, research.md, and reference file contents
- code-reviewer validates against acceptance criteria and architectural decisions
- task-generator includes file refs only for complex tasks

## v1.1.0 (2025-12-15)

### Added
- Web-researcher agent for external research when specs mention external technologies
- Serena MCP integration for semantic code analysis

### Changed
- Standardize plugin commands to pure markdown format
- Disable Serena web UI auto-open
- Add color attribute to agent frontmatter

## v1.0.0 (2025-12-05)

### Added
- Initial release
- `/spec` command for creating feature specifications
- `/clarify` command for resolving ambiguities
- `/plan` command for generating technical plans
- `/tasks` command for task decomposition
- `/implement` command for executing tasks
- `/review` command for code review
- Agents: code-explorer, code-architect, code-reviewer, implement-agent, task-generator
