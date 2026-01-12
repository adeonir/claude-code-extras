---
description: Explore codebase and generate technical plan
argument-hint: [ID] [additional instructions]
---

# Plan Command

Analyze the codebase and create a comprehensive technical plan for implementing the feature.

## Arguments

- `[ID]` - Feature ID (optional if branch is associated)
- `[additional instructions]` - Extra context for research or planning

Arguments received: $ARGUMENTS

## Process

### Step 1: Resolve Feature

If ID provided (numeric or full like `002-add-2fa`):
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

### Step 3: Check for Clarifications

Search for `[NEEDS CLARIFICATION]` in the spec.

If found:
- List the items needing clarification
- Suggest running `/spec-driven:clarify` first
- Exit

### Step 4: Research External Information

Determine if web research is needed by checking:
1. **User provided additional instructions** with the `/plan` command
2. **Spec mentions external technologies**: libraries, frameworks, APIs, services
3. **Spec references standards or protocols** that need verification

If research is needed:
- Check if `docs/research/{topic}.md` already exists for the technology
- If exists, use existing research
- If not, invoke the `researcher` agent

The researcher will create `docs/research/{topic}.md` with findings (shared across features).

Skip research if:
- The spec is purely about internal code changes
- No external dependencies mentioned
- Research already exists for all mentioned technologies

### Step 5: Explore Codebase

Invoke the `explorer` agent to analyze the codebase:

Ask it to explore:
- Similar existing features
- Architecture patterns and conventions
- Relevant entry points and integration areas
- Testing patterns

You may launch 2-3 explorer agents in parallel with different focuses.

### Step 6: Review Exploration

Read the files identified as essential by the explorers.

**Consolidate Critical Files:**
- **Reference Files**: Patterns to follow
- **Files to Modify**: Existing files that need changes
- **Files to Create**: New files to be added

### Step 7: Generate Plan

Invoke the `architect` agent with:
- The specification (spec.md)
- Research summary (from docs/research/ if applicable)
- Exploration insights
- Consolidated critical files list
- Feature ID and name

The architect will create `.specs/{ID}-{feature}/plan.md`

Include a Research Summary section if external research was used:
```markdown
## Research Summary

> From [docs/research/totp-authentication.md]

Key points:
- {relevant findings}
```

### Step 8: Validate Plan Against Documentation

After plan.md is generated, validate it against project documentation.

**Discover Project Documentation:**
- Find docs/*.md, README.md, *.md in project root
- Include files referenced in spec.md
- Check for architecture diagrams, ADRs, or specs

**Invoke validator Agent (Mode Plan):**

Pass to the agent:
- Validation mode: `plan`
- spec.md (requirements context)
- plan.md (just generated)
- List of discovered documentation files

**Handle Validation Results:**

If `Ready`:
- Continue to Step 9

If `Needs fixes`:
1. Present validation results to user (informational)
2. Re-invoke `architect` with:
   - Original inputs
   - List of specific corrections from validator
   - Explicit instruction: "Documentation is the source of truth. Address these inconsistencies."
3. After new plan.md generated, re-validate
4. Repeat until `Ready` or max 3 iterations reached

If max iterations reached with issues remaining:
- Report the remaining inconsistencies
- Ask user how to proceed:
  - **Continue anyway**: Proceed to Step 9 (plan may need manual adjustment later)
  - **Review documentation**: User will check if documentation is accurate/outdated
  - **Manually adjust plan**: User will edit plan.md directly to resolve issues

### Step 9: Update Status

Update spec.md frontmatter:
- Set `status: ready`

### Step 10: Report

Inform the user:
- Research conducted (if applicable) at `docs/research/{topic}.md`
- Plan created at `.specs/{ID}-{feature}/plan.md`
- Plan validated against documentation (X iterations if corrections were needed)
- Key architectural decisions made
- Next step: `/spec-driven:tasks` to generate task list

## Error Handling

- **Feature not found**: List available features or suggest `/spec-driven:init`
- **Spec not found**: Inform user to run `/spec-driven:init` first
- **Clarifications pending**: Suggest `/spec-driven:clarify` first
- **Codebase unclear**: Ask user for guidance on patterns to follow
