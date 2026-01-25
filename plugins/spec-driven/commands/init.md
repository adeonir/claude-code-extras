---
description: Create feature specification from description or PRD
argument-hint: <description> | @<file.md>
---

# Init Command

Initialize a new feature with a structured specification file.

## Content Separation (CRITICAL)

Each artifact has a distinct purpose. Never mix these concerns.

| File     | Purpose                                            |
| -------- | -------------------------------------------------- |
| spec.md  | WHAT to build (requirements, acceptance criteria)  |
| plan.md  | HOW to build (architecture, files, implementation) |
| tasks.md | WHEN to build (ordered tasks with dependencies)    |

### spec.md MUST contain ONLY:

- User stories (As a... I want... so that...)
- Functional requirements (what the system must do)
- Acceptance criteria (verifiable conditions)
- Business rules and constraints
- For brownfield: current behavior description (high-level, no code)

### spec.md MUST NOT contain:

- Code snippets or examples
- File paths or directory structures
- Technology choices (React, Node, etc.)
- Implementation approaches
- Database schemas or API designs
- Architecture decisions

These belong in plan.md, created by `/spec-driven:plan`.

## Arguments

- `<description>` - Text describing the feature
- `@<file.md>` - Path to PRD file to use as context
- `--link <ID>` - Associate current branch with existing feature

Arguments received: $ARGUMENTS

## Process

### Step 1: Handle --link Flag

If `--link <ID>` provided:

- Find feature with that ID in `.specs/`
- Get current git branch
- Update the feature's `spec.md` frontmatter with `branch: {current_branch}`
- Inform user and exit

### Step 2: Generate Feature ID

Scan `.specs/` directory for existing features.
Find the highest ID number and increment by 1.

Example: If `.specs/003-payment-flow/` exists, next ID is `004`.

If `.specs/` doesn't exist, start with `001`.

### Step 2b: Detect Greenfield vs Brownfield

Analyze the user's description to determine if this is greenfield (new) or brownfield (change to existing).

**1. Extract keywords from description:**

Brownfield keywords:

- "melhorar", "refatorar", "corrigir", "otimizar"
- "estender", "adicionar a", "modificar", "atualizar"
- "improve", "refactor", "fix", "optimize"
- "extend", "add to", "modify", "update"

Greenfield keywords:

- "criar", "novo", "implementar do zero"
- "create", "new", "implement from scratch"

**2. Search codebase for related code:**

Extract technical terms from the description (e.g., "cache", "auth", "payment").

Use Glob/Grep to find related files:

```bash
# Example for "improve cache performance"
find . -name "*cache*" -type f
grep -r "cache" --include="*.ts" --include="*.js" -l
```

**3. Determine type:**

| Keywords   | Code Found | Type         |
| ---------- | ---------- | ------------ |
| Greenfield | No         | `greenfield` |
| Greenfield | Yes        | Ask user     |
| Brownfield | No         | Ask user     |
| Brownfield | Yes        | `brownfield` |
| Unclear    | No         | `greenfield` |
| Unclear    | Yes        | Ask user     |

**4. If ambiguous, ask user:**

```
> Found related code in: src/cache/redis.ts, src/cache/memory.ts
> Is this:
> 1. Feature nova (greenfield) - nao relacionada ao codigo existente
> 2. Mudanca em codigo existente (brownfield)
```

Store detected type for use in Step 7.

### Step 3: Process Input

If input is a file reference (@file.md):

- Read the file content as PRD context

If input is text:

- Use as feature description

If input is empty:

- Ask the user for a feature description

### Step 4: Process Referenced Documentation

When documentation is referenced with @path:

1. **List all files** in the referenced path
2. **Read each file completely**
3. **Extract** from each file:
   - Rules (words: "must", "cannot", "always", "never", "required")
   - Constraints (words: "only if", "when", "unless")
   - Examples (code blocks, diagrams, sample data)
4. **For each item found**, ask: "Is this relevant to the feature?"
5. **If relevant**, it MUST become an FR or AC in the spec
6. **If skipped**, note WHY in the Notes section

Output before generating spec:

```markdown
## Extracted from Documentation

| Source | Item              | Relevant | Mapped To                           |
| ------ | ----------------- | -------- | ----------------------------------- |
| {file} | {rule/constraint} | Yes/No   | FR-xxx / AC-xxx / Skipped: {reason} |
```

### Step 4b: Baseline Discovery (if brownfield)

If type is `brownfield`, understand the current user-facing behavior.

**1. Analyze current behavior:**

Use the technical terms found in Step 2b to understand what the system currently does from a user perspective.

**2. Document baseline (high-level only):**

Prepare baseline information for spec.md focusing on:

- What users can currently do
- Current limitations or gaps
- What needs to change (in terms of behavior, not code)

IMPORTANT: Do NOT include in the baseline:

- File paths or directory structures
- Function or class names
- Code snippets
- Technical implementation details

Example baseline:

```
Current Behavior: Cache expires after fixed time, requires manual refresh
Gaps: No way to configure expiration, no automatic invalidation when data changes
```

### Step 5: Generate Feature Name

From the description, derive a short kebab-case name:

- "Add two-factor authentication" -> `add-2fa`
- "User registration flow" -> `user-registration`

### Step 6: Check Branch Association

Get current git branch:

```bash
git branch --show-current
```

Ask user:

- "Associate this feature with branch `{branch}`?" (Yes/No)

If on main/master, suggest creating a new branch.

### Step 7: Generate Specification

Create `.specs/{ID}-{feature}/spec.md` with frontmatter and content:

**Frontmatter:**

```yaml
---
id: { ID }
feature: { feature-name }
type: { greenfield | brownfield } # from Step 2b
status: draft
branch: { branch or empty }
created: { YYYY-MM-DD }
---
```

**Content for greenfield:**

```markdown
# Feature: {Feature Title}

## Overview

{brief_description}

## User Stories

- As a {user_type}, I want {goal} so that {benefit}

## Functional Requirements

- [ ] FR-001: {requirement}
- [ ] FR-002: {requirement}

## Acceptance Criteria

- [ ] AC-001: {criterion}
- [ ] AC-002: {criterion}

## Notes

{additional_context}

<!-- Items marked [NEEDS CLARIFICATION] require resolution before plan -->
```

**Content for brownfield (includes Baseline section):**

NOTE: Baseline describes current BEHAVIOR, not implementation details. No file paths, no code, no technical specifics.

```markdown
# Feature: {Feature Title}

## Overview

{brief_description}

## Baseline

Current state based on codebase analysis.

### Current Behavior

- {what the system currently does - user-facing behavior}
- {what the system currently does - user-facing behavior}

### Gaps / Limitations

- {what is missing or not working well}
- {what is missing or not working well}

## User Stories

- As a {user_type}, I want {goal} so that {benefit}

## Functional Requirements

- [ ] FR-001: {requirement}
- [ ] FR-002: {requirement}

## Acceptance Criteria

- [ ] AC-001: {criterion}
- [ ] AC-002: {criterion}

## Notes

{additional_context}

<!-- Items marked [NEEDS CLARIFICATION] require resolution before plan -->
```

### Step 8: Mark Ambiguities

For any unclear or underspecified items, add:

```
[NEEDS CLARIFICATION: specific question]
```

### Step 9: Report

Inform the user:

- Feature created: `{ID}-{feature}`
- Type: `{greenfield | brownfield}`
- Spec file at `.specs/{ID}-{feature}/spec.md`
- Branch associated: `{branch}` (or "none")
- If brownfield: Number of related files analyzed
- Number of items needing clarification (if any)
- Next step: `/spec-driven:clarify` to resolve ambiguities, or `/spec-driven:plan` if none

## Error Handling

- **No input provided**: Ask user for feature description
- **File not found**: Inform user and ask for correct path
- **ID conflict**: Should not happen, but regenerate if it does
