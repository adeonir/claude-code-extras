---
description: Resolve ambiguities in the specification
argument-hint: [ID]
---

# Clarify Command

Identify and resolve items marked [NEEDS CLARIFICATION] in the specification.

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

Read `.specs/{ID}-{feature}/spec.md`

If file doesn't exist, inform user to run `/init` first.

### Step 3: Find Clarifications Needed

Search for all `[NEEDS CLARIFICATION: ...]` markers in the spec.

If none found:

- Inform user the spec is complete
- Suggest running `/spec-driven:plan` next
- Exit

### Step 4: Present Questions

For each clarification needed:

- Present the question clearly
- Provide context from the surrounding spec content
- Suggest options if applicable

Use AskUserQuestion for structured choices when appropriate.

### Step 5: Update Specification

For each answered question:

- Replace the `[NEEDS CLARIFICATION: ...]` marker with the clarified content
- Keep the spec well-formatted

### Step 6: Report

After all clarifications:

- Show summary of what was clarified
- Check if any new clarifications emerged
- Suggest `/spec-driven:plan` as next step if spec is complete

## Error Handling

- **Feature not found**: List available features or suggest `/spec-driven:init`
- **Spec not found**: Inform user to run `/spec-driven:init` first
- **User unsure**: Mark as still needing clarification, move on
- **Conflicting answers**: Ask for resolution before proceeding
