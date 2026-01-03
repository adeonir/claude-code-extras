---
description: Generate PR title and description to file
argument-hint: "[base-branch]"
---

# PR Details Command

Generate a comprehensive PR description comparing current branch with base branch, save to `PR_DETAILS.md`.

## Arguments

- **No argument**: Auto-detect base branch (main > master > develop > development)
- **`base-branch`**: Use specified branch as base for comparison

## Pre-execution Validation

**CRITICAL**: Always validate before running analysis:

```bash
# 1. Verify base branch exists
git branch -a | grep -E "(main|master|develop|development)$"

# 2. Confirm current branch is NOT the base branch
git branch --show-current
```

**Requirements:**
- Base branch must exist in repository
- Current branch must NOT be the base branch (avoid empty diffs)

## Process

1. **Detect base branch** (if not specified):
   ```bash
   git branch -a | grep -E "(main|master|develop|development)$" | head -1
   ```

2. **Gather context** (run in parallel):
   ```bash
   # Extract tickets from branch name
   git branch --show-current

   # Get diff statistics
   git diff {base}...HEAD --stat

   # Get file change status
   git diff {base}...HEAD --name-status

   # Get commit history
   git log {base}..HEAD --oneline

   # Get detailed diff for content analysis
   git diff {base}...HEAD
   ```

3. **Analyze changes** and categorize files:
   - **Core Changes**: Main application source files
   - **API Changes**: Endpoint modifications, services
   - **State Management**: Store/state files
   - **UI Components**: Component files
   - **Configuration**: Config, package.json, build files
   - **Documentation**: README, CLAUDE.md, docs

5. **Assess risk and impact**:
   - **Risk Level**: HIGH (breaking changes, DB mods) | MEDIUM (new features, UI changes) | LOW (bug fixes, minor)
   - **Performance Impact**: POSITIVE | NEUTRAL | NEGATIVE
   - **Compatibility Impact**: NONE | MINOR | MAJOR

6. **Generate PR_DETAILS.md** using Write tool with template below.

## PR_DETAILS.md Template

```markdown
# Brief Descriptive Title

## Summary
[2-3 sentences describing the main functional change or feature - focus on business value, not implementation details]

## Key Changes

### Core Changes (X files)
- **[filename]**: [Brief functional description of changes]

### API Changes (X files)
- **[filename]**: [Brief description]

### State Management (X files)
- **[filename]**: [Brief description]

### UI Components (X files)
- **[filename]**: [Brief description]

### Configuration/Build (X files)
- **[filename]**: [Brief description]

### Documentation (X files)
- **[filename]**: [Brief description]

## Technical Flow

**Change Flow Description:**
1. [User action or trigger that initiates the change]
2. [How modified components handle the interaction]
3. [API calls or state updates that occur]
4. [Final outcome or UI response]
5. [Fallback mechanisms or error handling]

**Key Components Involved:**
- **[Component Name]**: [Role in the change]
- **[API/Service Name]**: [API modifications or interactions]
- **[State Management]**: [State changes if applicable]

**Data Flow:**
- Input: [What triggers the change]
- Processing: [How the change is handled]
- Output: [What the user experiences]

## Impact Assessment

### Risk Level: [LOW/MEDIUM/HIGH]
- [Justification for risk level]
- [Potential issues to watch for]

### Performance Impact: [POSITIVE/NEUTRAL/NEGATIVE]
- [Description of performance changes]

### Compatibility Impact: [NONE/MINOR/MAJOR]
- [Backward compatibility considerations]
- [API changes if any]

## Priority Review Areas
- **HIGH**: [Critical areas - breaking changes, core business logic, state management]
- **MEDIUM**: [Important areas - UI changes, new features, refactoring]
- **LOW**: [Minor areas - documentation, styling, configuration]

## Testing Instructions
1. [Step-by-step instructions to test the changes]
2. [Expected outcomes for each step]
3. [Edge cases to verify]

## Additional Notes
[Any additional context, future considerations, or related work]
```

## Template Guidelines

- **Only include sections with actual file changes** - omit empty categories
- **File descriptions**: Focus on functional impact, not line-by-line changes
- **Technical Flow**: Describe the user-facing flow, not internal implementation
- **Priority Review**: Focus on component names and areas, NOT line numbers
- **Risk assessment**: Be honest about potential issues

## Task

Generate PR description for current branch with $ARGUMENTS and save to `PR_DETAILS.md`.

After analyzing all changes:
1. Generate complete PR_DETAILS.md file using Write tool
2. Provide brief summary of key changes and priority review areas
