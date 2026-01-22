# Changelog

All notable changes to this plugin will be documented in this file.

## v2.5.2 (2026-01-18)

### Added

- Quality Gates in tasks.md output
  - Detects lint/typecheck scripts from package.json
  - Adds instruction to run quality checks after each task
- Implementer now runs quality gates after each task, tries `--fix` flag first, then fixes remaining manually

### Changed

- `/tasks` command now reads package.json to detect quality gate commands

## v2.5.1 (2026-01-18)

### Added

- Project Conventions Discovery step in `explorer` agent
  - Identifies wrapper libraries/abstractions the project uses
  - Documents patterns that MUST be followed (with reference files)
  - Documents what to avoid (e.g., direct access when abstraction exists)
- "Project conventions" as mandatory output item in explorer analysis

### Changed

- Rule 4 in explorer now emphasizes explicit documentation of conventions

## v2.5.0 (2026-01-12)

### Added

- Brownfield support in `/init` command
  - Auto-detects greenfield vs brownfield based on keywords and codebase analysis
  - Generates Baseline section for brownfield specs (related files, current behavior, modification points)
  - New `type: greenfield | brownfield` field in spec.md frontmatter
- Multi-mode validation in `/validate` command
  - Mode Spec: validates spec structure (after /init)
  - Mode Plan: + documentation compliance (after /plan)
  - Mode Tasks: + requirements coverage (after /tasks)
  - Mode Full: + code validation (after /implement)
  - Auto-detects mode based on available artifacts

### Changed

- Consolidated `plan-validator` and `spec-validator` into unified `validator` agent
- Renamed agents for consistency:
  - `web-researcher` -> `researcher`
  - `code-explorer` -> `explorer`
  - `code-architect` -> `architect`
  - `task-generator` -> `tasker`
  - `implement-agent` -> `implementer`
  - `spec-archiver` -> `archiver`
- Reduced agent count from 8 to 7
- `/validate` can now run at any workflow phase (not just after /implement)

### Removed

- `plan-validator` agent (merged into `validator`)
- `spec-validator` agent (merged into `validator`)

## v2.4.0 (2026-01-12)

### Added

- `plan-validator` agent to validate plan.md against project documentation
- Plan validation step in `/plan` command (Step 8)
- Auto-correction loop: re-generates plan until documentation consistency achieved (max 3 iterations)
- User prompt when max iterations reached with remaining inconsistencies

### Changed

- `/plan` command now has 10 steps (was 9)

## v2.3.3 (2026-01-12)

### Fixed

- `/init` now systematically reads all files in referenced @path
- `/init` extracts rules, constraints, and examples from documentation
- `code-architect` re-reads referenced docs before implementation decisions
- `code-architect` marks undocumented decisions as `[NOT DOCUMENTED - needs verification]`

## v2.3.2 (2026-01-07)

### Fixed

- Status update timing in `/plan` command: now sets `ready` only after plan is generated

## v2.3.1 (2026-01-07)

### Changed

- Renamed status values for consistency:
  - `planning` -> `ready`
  - `review` -> `to-review`
- Status lifecycle: `draft` -> `ready` -> `in-progress` -> `to-review` -> `done` -> `archived`

## v2.3.0 (2026-01-05)

### Changed

- `/archive` now generates centralized changelog at `docs/CHANGELOG.md`
- Feature docs (`docs/features/*.md`) no longer include changelog section
- Changelog uses Keep a Changelog format (Added/Changed/Removed/Fixed/Deprecated/Security)

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
