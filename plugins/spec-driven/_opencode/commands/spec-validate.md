---
description: Validate artifacts, code, and acceptance criteria
subtask: true
---

# Validate Command

Validate feature artifacts at any workflow phase. Auto-detects which mode to use.

## Arguments

- `$1` - Feature ID (optional if branch is associated)

## Current State

!`git branch --show-current`

## Process

1. **Resolve feature**: Match ID or current branch

2. **Detect mode** based on artifacts present:

   | Artifacts            | Mode  | Description             |
   | -------------------- | ----- | ----------------------- |
   | spec.md only         | Spec  | Validate structure      |
   | + plan.md            | Plan  | + doc compliance        |
   | + tasks.md           | Tasks | + requirements coverage |
   | + status in-progress | Full  | + code validation       |

3. **Run validation**:

   **Mode Spec**: Structure, frontmatter, sections, numbering

   **Mode Plan**: + critical files, architecture decision, traceability, doc compliance

   **Mode Tasks**: + task IDs, markers, FR/AC coverage, dependencies

   **Mode Full**: + acceptance criteria status, architecture compliance, code issues (>= 80 confidence)

4. **Determine status**:

   - **Ready**: All valid, all passed
   - **Needs fixes**: Errors or failures
   - **Needs clarification**: Markers found

5. **For Mode Full, if all pass**:
   - Update spec to `status: done`
   - Suggest `/archive`

## Output

| Mode  | If Valid       | If Issues      |
| ----- | -------------- | -------------- |
| Spec  | Run /plan      | Run /clarify   |
| Plan  | Run /tasks     | Fix plan       |
| Tasks | Run /implement | Fix coverage   |
| Full  | Run /archive   | Run /implement |

## Task

Validate feature. ID: $ARGUMENTS
