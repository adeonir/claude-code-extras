---
description: Extract content from URL to copy.yaml
argument-hint: <url> [--type=landing|website|webapp|app] [--name=project-name]
---

Extract structured content from a URL and generate a copy.yaml file.

**Arguments received:** $ARGUMENTS

**Task:** Use the copy-extractor agent to:
1. Fetch and analyze the URL (first argument)
2. Use --type if provided, otherwise detect automatically
3. Use --name if provided, otherwise infer from URL
4. Generate copy.yaml in ./prompts/{project-name}/
