---
description: Create feature specification from description or PRD
argument-hint: <description> | @<file.md>
---

# Init Command

Initialize a new feature with a structured specification file.

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

If type is `brownfield`, gather information about the current implementation.

**1. Find related files:**

Use the technical terms and file paths found in Step 2b.

**2. Read main files:**

For each related file (up to 5 most relevant):

- Read the file content
- Identify key behaviors, functions, classes
- Note current implementation approach

**3. Document baseline:**

Prepare baseline information for spec.md:

- List of related files with brief descriptions
- Current behavior summary
- Points that will be modified

Example baseline data:

```
Files: src/cache/redis.ts, src/cache/memory.ts
Current: Fixed TTL of 3600s, manual invalidation only
Modification points: TTL configuration, tag-based invalidation
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

```markdown
# Feature: {Feature Title}

## Overview

{brief_description}

## Baseline

Estado atual baseado em analise de: {list of files analyzed}

### Arquivos Relacionados

- `{file_path}`: {brief description of current behavior}
- `{file_path}`: {brief description of current behavior}

### Comportamento Atual

- {description of current implementation}
- {description of current implementation}

### Pontos de Modificacao

- {component/file} sera modificado para {action}
- {component/file} sera modificado para {action}

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
