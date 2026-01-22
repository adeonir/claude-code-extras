---
description: Resolve ambiguities in the specification
---

# Clarify Command

Identify and resolve items marked `[NEEDS CLARIFICATION]` in the specification.

## Arguments

- `$1` - Feature ID (optional if branch is associated)

## Current State

!`git branch --show-current`

!`ls -d .specs/*/ 2>/dev/null | head -5`

## Process

1. **Resolve feature**:

   - Use ID if provided
   - Otherwise match current branch to spec frontmatter
   - Or use only feature if single one exists

2. **Load spec**: Read `.specs/{ID}-{feature}/spec.md`

3. **Find clarifications**: Search for `[NEEDS CLARIFICATION: ...]`

   - If none found: spec is complete, suggest `/plan`

4. **For each clarification**:

   - Present question with context
   - Suggest options if applicable
   - Get user answer

5. **Update spec**: Replace markers with clarified content

6. **Report**:
   - Summary of clarifications resolved
   - Any new clarifications that emerged
   - Next step: `/plan` if complete

## Task

Resolve clarifications. Feature: $ARGUMENTS
