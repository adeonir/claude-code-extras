---
description: Generate docs and mark feature as archived
argument-hint: [ID]
---

# Archive Command

Generate documentation from the completed feature and mark it as archived.

## Arguments

- `[ID]` - Feature ID (optional if branch is associated)

Arguments received: $ARGUMENTS

## Process

### Step 1: Resolve Feature

If ID provided:
- Use that feature directly

If no ID:
- Get current git branch
- Search `.specs/*/spec.md` for matching `branch:` in frontmatter
- If found, use that feature
- If not found, list available features and ask user to specify

### Step 2: Validate Status

Read `.specs/{ID}-{feature}/spec.md` frontmatter.

Check status:
- If `done`: proceed
- If `to-review`: suggest running `/spec-driven:validate` first
- If other: inform user feature is not ready for archive

### Step 3: Load Artifacts

Read from `.specs/{ID}-{feature}/`:
- `spec.md` - Overview and feature description
- `plan.md` - Architecture decisions
- `tasks.md` - Count completed tasks

### Step 4: Check for Existing Docs

Determine target path from feature name (e.g., `add-2fa` -> `docs/features/auth.md` or new file).

If `docs/features/{relevant}.md` exists:
- Will update that file with new content

If not:
- Will create new file

### Step 5: Generate Feature Documentation

Create/update `docs/features/{feature}.md` (NO changelog section - just permanent docs):

```markdown
# {Feature Title}

## Overview

{from spec.md Overview section}

## Architecture Decisions

{from plan.md Architecture Decision section}
```

### Step 6: Update Centralized Changelog

Update `docs/CHANGELOG.md` (create if not exists):

```markdown
# Changelog

## {YYYY-MM-DD}

### Added
- {New capabilities from this feature}

### Changed
- {Modified behaviors}

### Removed
- {Deprecated/removed items}

## {previous date}
...
```

Rules for changelog:
- Add new date section at TOP of file (after # Changelog header)
- Use Keep a Changelog format (Added/Changed/Removed/Fixed/Deprecated/Security)
- Only include sections that have entries
- Each entry describes user-visible change, not implementation detail

### Step 7: Update Status

Update `.specs/{ID}-{feature}/spec.md` frontmatter:
- Set `status: archived`

### Step 8: Report

Inform user:
- Documentation generated/updated at `docs/features/{file}.md`
- Changelog entry added to `docs/CHANGELOG.md`
- Feature marked as archived
- User can delete `.specs/{ID}-{feature}/` manually if desired

## Error Handling

- **Feature not found**: List available features
- **Not in done status**: Suggest running `/spec-driven:validate` first
- **Missing artifacts**: Note which files are missing
