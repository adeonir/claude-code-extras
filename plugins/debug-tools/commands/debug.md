---
description: Start iterative debugging with hypothesis generation and log injection
argument-hint: "bug description"
allowed-tools: Glob, Grep, Read, Write, Edit, Bash, Task
---

# Debug Command

Start an iterative debugging session with hypothesis generation, strategic log injection, and runtime analysis.

## Arguments

- `"bug description"` - Description of the bug to investigate

## Process

### Step 1: Investigate and Generate Hypotheses

Use the `bug-investigator` agent with the bug description to:
- Analyze the codebase for relevant code paths
- Generate 3-5 ranked hypotheses
- Identify strategic log points for verification

Present the hypotheses to the user in a clear format.

### Step 2: Inject Debug Logs

Use the `log-injector` agent to:
- Add `[DEBUG]` logs at strategic points based on hypotheses
- Report all log locations to the user

Tell the user:
> "Debug logs have been added. Please reproduce the bug and let me know when you're done."

### Step 3: Wait for User Feedback

The user will respond naturally when they've reproduced the bug. Common responses:
- "done", "reproduced", "ready"
- Paste of console output
- Description of what happened

### Step 4: Analyze and Propose Fix

Use the `bug-investigator` agent again to:
- Analyze runtime logs (via Console Ninja MCP if available)
- Confirm which hypothesis was correct
- Propose a minimal fix

Ask the user:
> "I believe the issue is [root cause]. Should I apply this fix?"

### Step 5: Apply Fix (if approved)

If user confirms:
- Apply the proposed fix
- Ask user to reproduce again to verify

### Step 6: Cleanup

When the bug is confirmed fixed:
- Remove all `[DEBUG]` logs from the codebase
- Report the fix summary

If the bug persists:
- Refine hypotheses based on new information
- Add more targeted logs
- Repeat the cycle

## Error Handling

- **No relevant code found**: Ask user for more context about the bug location
- **MCP not available**: Rely on user to share console output manually
- **Fix doesn't work**: Generate new hypotheses based on observed behavior
- **User cancels**: Offer to clean up debug logs

## Example Flow

```
User: /debug "Login fails silently after page refresh"

Agent: [Investigates codebase, generates hypotheses]

I've identified 3 possible causes:

**[H1] Token refresh not triggered (High)**
- Evidence: auth/refresh.ts:42 - refresh only called on 401
- Verify: Check if refresh is called after page load

**[H2] Cookie not persisting (Medium)**
- Evidence: auth/cookies.ts:15 - httpOnly flag
- Verify: Check cookie presence after refresh

**[H3] Race condition in auth check (Low)**
- Evidence: auth/middleware.ts:30 - async check
- Verify: Check timing of auth vs render

I've added debug logs. Please reproduce the bug and let me know when done.

User: reproduced, here's the output [paste]

Agent: [Analyzes logs]

Confirmed: H1 - Token refresh is not being triggered after page load.
The refresh token exists but `refreshToken()` is never called.

**Proposed fix:**
```typescript
// auth/provider.tsx:25
useEffect(() => {
+ if (!accessToken && refreshToken) {
+   refreshAccessToken();
+ }
}, []);
```

Should I apply this fix?

User: yes

Agent: [Applies fix]

Fix applied. Please refresh and try logging in again.

User: works now!

Agent: [Removes debug logs]

Bug fixed. I've removed all debug logs. Summary:
- Root cause: Token refresh not triggered on mount
- Fix: Added refresh check in auth provider useEffect
```
