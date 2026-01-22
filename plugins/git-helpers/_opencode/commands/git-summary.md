---
description: Generate PR description and save to PR_DETAILS.md
---

# Summary Command

Generate a comprehensive PR description and save to `PR_DETAILS.md`.

## Arguments

- `$1` - Base branch (optional, auto-detects: main > master > develop)

## Current State

!`git branch --show-current`

!`git branch -a | grep -E "(main|master|develop)$" | head -3`

## Process

1. **Validate**: Current branch must not be the base branch

2. **Gather context**:

   ```bash
   git diff {base}...HEAD --stat
   git diff {base}...HEAD --name-status
   git log {base}..HEAD --oneline
   git diff {base}...HEAD
   ```

3. **Analyze and categorize**:

   - Core changes (source files)
   - API changes (endpoints, services)
   - UI components
   - Configuration (package.json, configs)
   - Documentation

4. **Assess impact**:

   - Risk: HIGH (breaking) | MEDIUM (new features) | LOW (fixes)
   - Performance: POSITIVE | NEUTRAL | NEGATIVE
   - Compatibility: NONE | MINOR | MAJOR

5. **Write PR_DETAILS.md**

## Output Template

```markdown
# {Title}

## Summary

{2-3 sentences on business value}

## Key Changes

### {Category} ({count} files)

- **{file}**: {description}

## Impact Assessment

### Risk Level: {LOW/MEDIUM/HIGH}

- {justification}

### Performance Impact: {POSITIVE/NEUTRAL/NEGATIVE}

- {description}

## Testing Instructions

1. {step}
2. {expected outcome}
```

## Guidelines

- Omit empty sections
- Focus on functional impact, not line-by-line changes
- Be honest about risks

## Task

Generate PR description. Base branch: $ARGUMENTS
