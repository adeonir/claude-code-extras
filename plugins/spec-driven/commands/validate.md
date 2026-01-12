---
description: Validate artifacts, code, and acceptance criteria
argument-hint: [ID]
---

# Validate Command

Validate feature artifacts at any workflow phase. Automatically detects which artifacts exist and runs appropriate validation mode.

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

### Step 2: Detect Validation Mode

Check which artifacts exist in `.specs/{ID}-{feature}/`:

| Artifacts Present | Mode | Description |
|-------------------|------|-------------|
| spec.md only | **Spec** | Validate spec structure |
| spec.md + plan.md | **Plan** | + documentation compliance |
| spec.md + plan.md + tasks.md | **Tasks** | + requirements coverage |
| All + status is in-progress/to-review | **Full** | + code validation |

Inform user which mode will be used:
```
Detected mode: {mode} (found: spec.md, plan.md, tasks.md)
```

### Step 3: Load Context

Based on detected mode, read:
- **Mode Spec**: `spec.md`
- **Mode Plan**: `spec.md`, `plan.md`, docs files from plan.md references
- **Mode Tasks**: `spec.md`, `plan.md`, `tasks.md`
- **Mode Full**: All artifacts + `git diff`

### Step 4: Discover Documentation (Mode Plan+)

If mode is Plan or higher:
- Find docs/*.md, README.md in project root
- Find files referenced in spec.md
- Look for architecture docs, ADRs

### Step 5: Invoke Validator

Invoke the `validator` agent with:
- Validation mode
- Available artifacts
- Documentation files list (for Plan+)
- git diff (for Full mode)

### Step 6: Present Results

Show validation results based on mode:

**Mode Spec:**
```markdown
## Validation: {ID}-{feature}

### Mode: Spec

### Artifact Structure

| File | Status | Issues |
|------|--------|--------|
| spec.md | Valid | - |

### Summary

- Status: **Ready for /plan** or **Needs clarification**

### Next Steps

- Run `/spec-driven:clarify` if ambiguities found
- Run `/spec-driven:plan` to generate technical plan
```

**Mode Plan:**
```markdown
## Validation: {ID}-{feature}

### Mode: Plan

### Artifact Structure

| File | Status | Issues |
|------|--------|--------|
| spec.md | Valid | - |
| plan.md | Valid | - |

### Documentation Compliance

| Severity | Issue | Source |
|----------|-------|--------|
| ... | ... | ... |

### Summary

- Status: **Ready for /tasks** or **Needs corrections**
```

**Mode Tasks:**
```markdown
## Validation: {ID}-{feature}

### Mode: Tasks

### Consistency

| Check | Status |
|-------|--------|
| Requirements coverage | Passed (5/5 FR have tasks) |
| AC coverage | Passed (4/4 AC addressed) |
| Task dependencies | Passed |

### Summary

- Status: **Ready for /implement** or **Needs fixes**
```

**Mode Full:**
(Full output as in validator agent)

### Step 7: Determine Outcome

**Mode Spec/Plan/Tasks:**
- If valid: Suggest next command in workflow
- If issues: List what needs fixing

**Mode Full:**
- **If all checks pass:**
  - Update spec.md frontmatter to `status: done`
  - Inform user feature is complete
  - Suggest `/spec-driven:archive` to generate documentation

- **If any checks fail:**
  - Keep status as `to-review`
  - List issues that need fixing
  - Suggest running `/spec-driven:implement` to fix issues

### Step 8: Report

Summary with next steps based on mode:

| Mode | If Valid | If Issues |
|------|----------|-----------|
| Spec | Run /plan | Run /clarify |
| Plan | Run /tasks | Fix plan inconsistencies |
| Tasks | Run /implement | Fix coverage gaps |
| Full | Run /archive | Run /implement |

## Error Handling

- **Feature not found**: List available features or suggest `/spec-driven:init`
- **No artifacts**: Suggest `/spec-driven:init` to start
- **No code changes (Full mode)**: Warn and suggest running /implement first
