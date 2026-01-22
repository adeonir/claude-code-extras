---
description: Execute implementation tasks
---

# Implement Command

Execute tasks from the task list, respecting dependencies and updating progress.

## Arguments

- `$1` - Feature ID (optional) or task scope
- Task scope: (empty) next pending, `T001` single, `T001-T005` range, `--all`

## Current State

!`git branch --show-current`

## Process

1. **Resolve feature**: Match ID or current branch

2. **Load context**:

   - spec.md (acceptance criteria)
   - plan.md (decisions, critical files)
   - tasks.md (task list, progress)
   - docs/research/ (if referenced)

3. **Update status**: Set spec to `status: in-progress`

4. **Load reference files**: From plan.md critical files section

5. **Parse scope**: Determine which tasks to execute

6. **Validate dependencies**:

   - `[P]` can proceed
   - `[B:Txxx]` needs Txxx completed
   - Skip blocked tasks

7. **Execute tasks**:

   - Follow plan precisely
   - Follow reference file patterns
   - Apply research best practices
   - Match codebase conventions

8. **Run quality gates**:

   - Run lint/typecheck after each task
   - Use `--fix` flag first
   - Fix remaining manually

9. **Update progress**:

   - Mark completed: `- [x] T001 ...`
   - Update counters

10. **Check completion**:
    - If all done: set `status: to-review`
    - Suggest `/validate`

## Output

- Tasks completed
- Files created/modified
- Suggested commit
- Remaining tasks (if any)

## Task

Execute tasks. Scope: $ARGUMENTS
