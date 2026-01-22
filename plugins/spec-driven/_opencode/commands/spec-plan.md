---
description: Explore codebase and generate technical plan
subtask: true
---

# Plan Command

Analyze the codebase and create a comprehensive technical plan for the feature.

## Arguments

- `$1` - Feature ID (optional if branch is associated)
- Additional instructions for research/planning

## Current State

!`git branch --show-current`

!`ls -d .specs/*/ 2>/dev/null | head -5`

## Process

1. **Resolve feature**: Match ID or current branch to spec

2. **Load spec**: Read `.specs/{ID}-{feature}/spec.md`

   - If `[NEEDS CLARIFICATION]` found: suggest `/clarify` first

3. **Research** (if needed):

   - Check `docs/research/` for existing research
   - If spec mentions external tech/APIs, research them
   - Save findings to `docs/research/{topic}.md`

4. **Explore codebase**:

   - Find similar features and patterns
   - Identify architecture conventions
   - Map integration points
   - Note testing patterns

5. **Generate plan**: Create `.specs/{ID}-{feature}/plan.md` with:

   - Research summary (if applicable)
   - Critical files (reference, modify, create)
   - Architecture decision (ONE approach)
   - Component design
   - Requirements traceability (FR-xxx mapped to components)

6. **Validate against docs**:

   - Check plan against project documentation
   - Fix inconsistencies (max 3 iterations)

7. **Update status**: Set spec to `status: ready`

## Output

Report:

- Research conducted (if any)
- Plan location
- Key architectural decisions
- Next step: `/tasks`

## Task

Generate technical plan. Feature: $ARGUMENTS
