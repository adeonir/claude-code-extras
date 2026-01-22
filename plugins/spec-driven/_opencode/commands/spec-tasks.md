---
description: Generate task list from technical plan
subtask: true
---

# Tasks Command

Transform the technical plan into an organized, trackable task list.

## Arguments

- `$1` - Feature ID (optional if branch is associated)

## Current State

!`git branch --show-current`

!`cat package.json 2>/dev/null | grep -E '"(lint|typecheck|type-check|check)"' | head -4`

## Process

1. **Resolve feature**: Match ID or current branch

2. **Load artifacts**:

   - spec.md (FR-xxx and AC-xxx)
   - plan.md (required - suggest `/plan` if missing)

3. **Detect quality gates**:

   - Find package manager (check lockfiles)
   - Find lint/typecheck scripts in package.json

4. **Generate tasks**: Create `.specs/{ID}-{feature}/tasks.md` with:

   - Sequential IDs: T001, T002...
   - Markers: `[P]` parallel-safe, `[B:Txxx]` blocked
   - Categories: Foundation, Implementation, Validation, Documentation
   - Checkboxes for tracking
   - Quality gates instruction
   - Requirements coverage table

5. **Verify coverage**:
   - Each FR-xxx has at least one task
   - Each AC-xxx has validation approach

## Output

Summary table:

| Category       | Tasks     | Complexity |
| -------------- | --------- | ---------- |
| Foundation     | T001-T002 | Low        |
| Implementation | T003-T006 | High       |
| Validation     | T007-T008 | Medium     |

Next step: `/implement` or `/implement T001`

## Task

Generate task list. Feature: $ARGUMENTS
