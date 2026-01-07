---
description: Validate artifacts, code, and acceptance criteria
argument-hint: [ID]
---

# Validate Command

Validate feature artifacts, code changes, and acceptance criteria. Marks as done if all checks pass.

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

### Step 2: Load Context

Read from `.specs/{ID}-{feature}/`:
- `spec.md` - Requirements and Acceptance Criteria
- `plan.md` - Architectural decisions and Critical Files
- `tasks.md` - Task list and completion status

### Step 3: Invoke Validator

Invoke the `spec-validator` agent with:
- Specification (full spec.md)
- Technical plan (full plan.md)
- Task list (full tasks.md)
- git diff of changes

The agent will perform three types of validation:

**1. Artifact Validation**
- spec.md: Valid frontmatter, required sections (Overview, Requirements, AC)
- plan.md: Critical Files section, Architecture Decision section
- tasks.md: Sequential IDs, valid dependency markers

**2. Consistency Validation**
- All FR-xxx have associated tasks
- All AC-xxx are addressed in plan
- Task dependencies reference existing tasks
- Critical files marked "to modify" exist in codebase

**3. Code Validation**
- Acceptance Criteria status (Satisfied/Partial/Missing)
- Architecture decisions followed
- Code quality issues (confidence >= 80 only)

### Step 4: Present Results

Show validation results:

```markdown
## Validation: {ID}-{feature}

### Artifact Structure

| File | Status |
|------|--------|
| spec.md | Valid |
| plan.md | Valid |
| tasks.md | Valid |

### Consistency

| Check | Status |
|-------|--------|
| Requirements coverage | Passed |
| AC coverage | Passed |
| Task dependencies | Passed |
| Critical files | Passed |

### Acceptance Criteria

| AC | Status | Notes |
|----|--------|-------|
| AC-001 | Satisfied | ... |
| AC-002 | Satisfied | ... |

### Code Issues

(none with confidence >= 80)

### Summary

- Artifacts: 3 valid
- Consistency: 4 passed
- AC: 2/2 satisfied
- Status: **Ready**
```

### Step 5: Determine Outcome

**If all checks pass:**
- Update spec.md frontmatter to `status: done`
- Inform user feature is complete
- Suggest `/spec-driven:archive` to generate documentation

**If any checks fail:**
- Keep status as `to-review`
- List issues that need fixing
- Suggest running `/spec-driven:implement` to fix issues

### Step 6: Report

Summary with next steps:
- If done: Suggest `/spec-driven:archive` or creating PR
- If issues: List what needs fixing

## Error Handling

- **Feature not found**: List available features or suggest `/spec-driven:init`
- **Artifacts missing**: Note which files need to be created
- **No code changes**: Warn that there's nothing to validate
