---
description: Extract structured content from URLs
argument-hint: <url> [--type=landing|website|webapp|app]
---

# Extract Copy Command

Extract structured content from a URL and generate a copy.yaml file.

## Arguments

- `<url>` - URL to extract content from
- `--type` - Project type (landing, website, webapp, app)

Arguments received: $ARGUMENTS

## Process

Invoke the `copy-extractor` subagent to extract content from the provided URL.

The copy-extractor will:
1. Fetch and analyze the URL
2. Detect project type or use --type if provided
3. Generate copy.yaml in ./docs/

Wait for the agent to complete and inform the user of the result.

## Error Handling

- **URL not accessible**: Ask user to paste a screenshot instead
- **Project type unclear**: Ask user to specify --type
