---
description: Generate task list from technical plan
argument-hint: [ID]
---

# Tasks Command

Transform the technical plan into an organized, trackable task list.

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
- If not found:
  - If only one feature exists, use it
  - If multiple, list them and ask user to specify

### Step 2: Load Specification

Read `.specs/{ID}-{feature}/spec.md` to have access to:
- Functional requirements (FR-xxx)
- Acceptance criteria (AC-xxx)

### Step 3: Load Plan

Read `.specs/{ID}-{feature}/plan.md`

If file doesn't exist, inform user to run `/plan` first.

### Step 4: Generate Tasks

Invoke the `tasker` agent with:
- The specification (spec.md) with requirements
- The technical plan (plan.md)
- Feature ID and name

The agent will create `.specs/{ID}-{feature}/tasks.md` with:
- Sequential IDs (T001, T002...)
- Dependency markers [P] and [B:Txxx]
- Categories (Foundation, Implementation, Validation, Documentation)
- Checkboxes for tracking
- Requirements coverage table

### Step 5: Report

Inform the user:
- Tasks created at `.specs/{ID}-{feature}/tasks.md`
- Next step: `/spec-driven:implement` to start implementation

Show a summary table:
```
## Task Summary

| Category | Tasks | Complexity |
|----------|-------|------------|
| Foundation | T001-T002 | Low |
| Implementation | T003-T006 | High |
| Validation | T007-T008 | Medium |
| Documentation | T009 | Low |

Run `/spec-driven:implement` to start, or `/spec-driven:implement T001` for a specific task.
```

## Error Handling

- **Feature not found**: List available features or suggest `/spec-driven:init`
- **Plan not found**: Inform user to run `/spec-driven:plan` first
- **Plan incomplete**: Point out missing sections, suggest updating plan
