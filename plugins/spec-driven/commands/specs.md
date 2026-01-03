---
description: List all features by status
---

# /specs Command

List all features in `.specs/` organized by status.

## Process

1. **Scan .specs/ directory**
   - Find all feature directories matching pattern `{ID}-{name}/`
   - Read `spec.md` frontmatter from each

2. **Parse metadata**
   - Extract: id, feature, status, branch, created
   - Sort by ID (ascending)

3. **Group by status**
   - Group features by their status field
   - Order: in-progress, review, planning, draft, done, archived

4. **Display summary**

## Output Format

```markdown
## Features

### In Progress
| ID | Feature | Branch | Created |
|----|---------|--------|---------|
| 003 | payment-flow | feat/payments | 2025-01-02 |

### Review
| ID | Feature | Branch | Created |
|----|---------|--------|---------|
| 002 | add-2fa | feat/add-2fa | 2025-01-01 |

### Done
| ID | Feature | Branch | Created |
|----|---------|--------|---------|
| 001 | user-auth | - | 2024-12-15 |

---
Total: 3 features
```

## Edge Cases

- **No .specs/ directory**: "No features found. Use /spec-driven:init to create one."
- **Empty .specs/**: "No features found. Use /spec-driven:init to create one."
- **Missing frontmatter**: Show with status "unknown"
- **Invalid directory name**: Skip (not a feature)

## Filtering (optional)

```bash
/specs                    # All features
/specs --status planning  # Only planning
/specs --status done      # Only done
```
