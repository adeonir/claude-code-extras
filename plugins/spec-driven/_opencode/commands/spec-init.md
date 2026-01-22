---
description: Create feature specification from description or PRD
---

# Init Command

Initialize a new feature with a structured specification file.

## Arguments

- `$1` - Feature description or `@file.md` for PRD
- `--link <ID>` - Associate current branch with existing feature

## Current State

!`ls -d .specs/*/ 2>/dev/null | tail -5 || echo "No .specs/ directory"`

!`git branch --show-current`

## Process

1. **Handle --link flag** (if present):

   - Find feature with that ID in `.specs/`
   - Update spec.md frontmatter with current branch
   - Exit

2. **Generate Feature ID**:

   - Scan `.specs/` for highest ID, increment by 1
   - Start with `001` if no features exist

3. **Detect greenfield vs brownfield**:

   - Check description for keywords (improve, refactor, fix = brownfield)
   - Search codebase for related code
   - Ask user if ambiguous

4. **Process input**:

   - If `@file.md`: read as PRD context
   - If text: use as description
   - If empty: ask user

5. **Generate spec.md** at `.specs/{ID}-{feature}/spec.md`:

   ```yaml
   ---
   id: { ID }
   feature: { feature-name }
   type: { greenfield|brownfield }
   status: draft
   branch: { branch or empty }
   created: { YYYY-MM-DD }
   ---
   ```

   With sections: Overview, User Stories, Functional Requirements (FR-xxx), Acceptance Criteria (AC-xxx), Notes

6. **For brownfield**: Include Baseline section with related files and current behavior

7. **Mark ambiguities** with `[NEEDS CLARIFICATION: question]`

## Output

Report:

- Feature ID and type
- Spec file location
- Branch association (if any)
- Clarifications needed (if any)
- Next step: `/clarify` or `/plan`

## Task

Create feature specification. Input: $ARGUMENTS
