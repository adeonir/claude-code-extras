---
description: List all features by status
---

# Specs Command

List all features in `.specs/` organized by status.

## Current Features

!`ls -d .specs/*/ 2>/dev/null | while read dir; do echo "$(basename $dir)"; done | head -10 || echo "No features found"`

## Process

1. **Scan .specs/**:

   - Find directories matching `{ID}-{name}/`
   - Read spec.md frontmatter from each

2. **Parse metadata**:

   - Extract: id, feature, status, branch, created
   - Sort by ID ascending

3. **Group by status**:
   - Order: in-progress, to-review, ready, draft, done, archived

## Output Format

```markdown
## Features

### In Progress

| ID  | Feature      | Branch        | Created    |
| --- | ------------ | ------------- | ---------- |
| 003 | payment-flow | feat/payments | 2025-01-02 |

### Review

| ID  | Feature | Branch       | Created    |
| --- | ------- | ------------ | ---------- |
| 002 | add-2fa | feat/add-2fa | 2025-01-01 |

### Done

| ID  | Feature   | Branch | Created    |
| --- | --------- | ------ | ---------- |
| 001 | user-auth | -      | 2024-12-15 |

---

Total: 3 features
```

## Filtering

- `/specs` - All features
- `/specs --status ready` - Only ready
- `/specs --status done` - Only done

## Task

List features. Filter: $ARGUMENTS
