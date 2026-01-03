---
description: Generate HTML and export to Figma via YashiTech plugin
argument-hint: ""
---

# Export to Figma Command

Generate HTML from design tokens and export to Figma.

## Arguments

None

Arguments received: $ARGUMENTS

## Prerequisites

- [YashiTech Chrome Extension](https://chromewebstore.google.com/detail/html-to-figma-by-yashi-te/apgdhlibcimkkffajannbmpnbjaealmo)
- [YashiTech Figma Plugin](https://www.figma.com/community/plugin/1459487250118622106)

Free tier: 40 imports/week

## Process

Invoke the `figma-builder` subagent to generate HTML for Figma import.

The figma-builder will:
1. Locate design.json (required) and copy.yaml (optional)
2. Generate clean HTML with inline CSS
3. Save to ./outputs/figma-export/index.html
4. Start local server at http://localhost:8081
5. Provide step-by-step import instructions

Wait for the agent to complete and follow the instructions to import into Figma.

## Error Handling

- **No design.json found**: Run /design-builder:design first to extract design tokens
