# Debugging Skill

Guide for iterative debugging with hypothesis generation, log injection, and runtime analysis.

## When to Use

This skill activates when users describe bugs or request debugging help:
- "X is not working"
- "Getting error Y when doing Z"
- "Something broke after [change]"
- "Can you help debug [issue]?"

## Debugging Approach

### 1. Hypothesis-Driven Debugging

Never guess randomly. Always:
- Generate 3-5 hypotheses ranked by probability
- Each hypothesis needs: description, code evidence, verification method
- Test most likely hypothesis first

### 2. Strategic Log Injection

Add logs that answer specific questions:
- Is this function being called?
- What value does this variable have at this point?
- Which branch of this conditional is taken?
- What's the order of execution?

### 3. Iterative Refinement

Debug cycle:
1. Hypothesize -> 2. Instrument -> 3. Reproduce -> 4. Analyze -> 5. Fix or Refine

## Log Patterns by Framework

### React/Next.js

**Component Lifecycle**
```javascript
console.log('[DEBUG] [Component.tsx:10] [H1] Mount', { props });

useEffect(() => {
  console.log('[DEBUG] [Component.tsx:15] [H1] Effect run', { deps });
  return () => console.log('[DEBUG] [Component.tsx:17] [H1] Cleanup');
}, [deps]);
```

**State Updates**
```javascript
console.log('[DEBUG] [Component.tsx:25] [H1] setState', { prev: state, next: newValue });
```

**Re-render Tracking**
```javascript
console.log('[DEBUG] [Component.tsx:5] [H1] Render', { renderCount: ++renderCount });
```

### Node.js/Express

**Request Flow**
```javascript
console.log('[DEBUG] [route.ts:10] [H1] Request', { method: req.method, path: req.path, body: req.body });
console.log('[DEBUG] [route.ts:50] [H1] Response', { status: res.statusCode });
```

**Middleware Chain**
```javascript
console.log('[DEBUG] [auth.ts:5] [H1] Auth middleware', { hasToken: !!req.headers.authorization });
```

**Error Handling**
```javascript
console.log('[DEBUG] [service.ts:30] [H1] Error', { name: err.name, message: err.message });
```

### API/Fetch Calls

**Request/Response**
```javascript
console.log('[DEBUG] [api.ts:10] [H1] Fetch start', { url, method });
console.log('[DEBUG] [api.ts:15] [H1] Fetch complete', { status: res.status, ok: res.ok });
```

### State Management (Redux/Zustand)

**Action Dispatch**
```javascript
console.log('[DEBUG] [store.ts:20] [H1] Action', { type: action.type, payload: action.payload });
console.log('[DEBUG] [store.ts:25] [H1] State after', { relevantSlice });
```

## Common Bug Patterns

### Null/Undefined Access
**Symptom**: "Cannot read property X of undefined"
**Check**: Optional chaining, default values, data loading states

### Race Conditions
**Symptom**: Works sometimes, fails randomly
**Check**: Async operation ordering, state updates during renders

### Stale Closures
**Symptom**: Using old values in callbacks
**Check**: useCallback dependencies, event handler bindings

### API Contract Mismatch
**Symptom**: Data not displaying correctly
**Check**: Response shape vs expected shape, null handling

### Auth/Session Issues
**Symptom**: Logged out unexpectedly, actions fail after time
**Check**: Token expiry, refresh logic, cookie persistence

### Memory Leaks
**Symptom**: App slows down over time
**Check**: Effect cleanup, event listener removal, subscription unsubscribe

## Log Format Standard

```
[DEBUG] [file:line] [hypothesis] message { values }
```

Components:
- `[DEBUG]` - Prefix for easy grep and cleanup
- `[file:line]` - Location for quick navigation
- `[hypothesis]` - Which hypothesis this log verifies (H1, H2, etc.)
- `message` - What this log is checking
- `{ values }` - Relevant data (avoid sensitive info)

## Cleanup

After debugging is complete, remove all logs:

```bash
# Find all debug logs
grep -rn '\[DEBUG\]' . --include='*.ts' --include='*.tsx' --include='*.js' --include='*.jsx'

# Verify before removing
git diff --stat
```

## MCP Integration

### Console Ninja
When available, Console Ninja MCP provides:
- Runtime values without modifying code
- Test status and errors
- Code coverage information

### Chrome DevTools
When available, DevTools MCP provides:
- Network request/response inspection
- Browser console logs
- DOM state inspection
