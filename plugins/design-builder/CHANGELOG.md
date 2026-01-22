# Changelog

All notable changes to this plugin will be documented in this file.

## v4.0.1 (2026-01-11)

### Added

- `context: fork` to frontend-design skill for conversation context access

## v4.0.0 (2026-01-03)

### Added

- `/design-builder:plan` command for product planning from scratch
- `/design-builder:figma` command for Figma export via YashiTech plugin
- `product-planner` agent for defining vision, data models, features
- `figma-builder` agent for generating Figma-optimized HTML
- Multiple entry points: from scratch, URL reference, or image reference
- Multiple outputs: React code or Figma design

### Changed

- Command prefixes added (`/design-builder:*`) for consistency
- Shorter command names: `copy`, `design`, `frontend`, `plan`, `figma`
- Repository URL updated to claude-code-extras

### Fixed

- URL references updated from claude-code-plugins to claude-code-extras

## v3.0.0 (2025-12-22)

### Added

- `minimal` variant preset (text-only hero, extra whitespace, typography-focused)
- Two-stage build workflow: HTML+CSS previews -> choose -> React
- Auto-start http-server for variant comparison at localhost:8080

### Changed

- `--variants` flag no longer accepts count (always generates 4: minimal, editorial, startup, bold)
- Renamed `preview.html` to `index.html` in outputs
- `frontend-builder` now accepts variant reference for layout guidance

### Removed

- `/generate-prompt` command and `prompt-generator` agent
- `/select-variation` command (just tell Claude "use editorial")
- Prompt targets (Replit, v0, Lovable, Figma)

## v2.0.1 (2025-12-12)

### Changed

- Standardize plugin commands to pure markdown format
- Add explicit Arguments and Process sections for consistency

## v2.0.0 (2025-12-12)

### Added

- Design variations feature with editorial, startup, and bold presets
- `variations-builder` agent for generating multiple layout variations
- `/select-variation` command to choose preferred layout
- `/build-frontend --variations N` flag for comparison workflow
- `preview.html` template for side-by-side comparison

## v1.0.0 (2025-12-05)

### Added

- Initial release (renamed from design-to-code)
- `/extract-copy` command for extracting content from URLs
- `/extract-design` command for extracting design tokens from images
- `/build-frontend` command for generating frontend code
- `/generate-prompt` command for Replit/v0/Lovable/Figma prompts
- Agents: copy-extractor, design-extractor, frontend-builder, prompt-generator
- Frontend-design skill for auto-loaded contextual guidance

### Changed

- Rename from design-to-code to design-builder
- Standardize frontmatter across commands and agents
