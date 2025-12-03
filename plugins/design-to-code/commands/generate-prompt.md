---
description: Generate optimized prompt for design tools
argument-hint: [--target=replit|v0|lovable|figma]
---

Generate an optimized prompt for AI design tools.

**Arguments received:** $ARGUMENTS

**Task:** Use the prompt-generator agent to:
1. Locate copy.yaml and design.json
2. Use --target if provided, otherwise ask user
3. Generate prompt-{target}.md optimized for the platform
