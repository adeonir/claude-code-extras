---
description: Generate docs and mark feature as archived
---

# Archive Command

Generate documentation from completed feature and mark as archived.

## Arguments

- `$1` - Feature ID (optional if branch is associated)

## Current State

!`git branch --show-current`

!`ls docs/features/ 2>/dev/null | head -5 || echo "No docs/features/ yet"`

## Process

1. **Resolve feature**: Match ID or current branch

2. **Validate status**:

   - If `done`: proceed
   - If `to-review`: suggest `/validate` first
   - Otherwise: not ready for archive

3. **Load artifacts**:

   - spec.md (overview, description)
   - plan.md (architecture decisions)
   - tasks.md (completion count)

4. **Determine target file**:

   - If relates to existing doc: update it
   - Otherwise: create new `docs/features/{feature}.md`

5. **Generate feature doc**:

   ```markdown
   # {Feature Title}

   ## Overview

   {from spec.md - condensed}

   ## Architecture Decisions

   {from plan.md}
   ```

6. **Update changelog** at `docs/CHANGELOG.md`:

   Add at TOP (after # Changelog):

   ```markdown
   ## {YYYY-MM-DD}

   ### Added

   - {new capability}
   ```

   Categories: Added, Changed, Deprecated, Removed, Fixed, Security

7. **Update status**: Set spec to `status: archived`

## Output

- Documentation path
- Changelog updated
- Feature archived
- Note: `.specs/{ID}-{feature}/` can be deleted manually

## Task

Archive feature. ID: $ARGUMENTS
