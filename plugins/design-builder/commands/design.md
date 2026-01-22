---
description: Extract design tokens from reference images
argument-hint: [image-url...]
---

# Extract Design Command

Extract design tokens from reference images and generate a design.json file.

## Arguments

- `[image-url...]` - Optional image URLs (will prompt if not provided)

Arguments received: $ARGUMENTS

## Process

Invoke the `design-extractor` subagent to extract design tokens from images.

The design-extractor will:

1. Request images from user if not provided
2. Check for existing copy.yaml for project context (optional)
3. If no copy.yaml, ask user for brief project description
4. Extract colors, typography, spacing, components
5. Generate design.json in ./docs/

Wait for the agent to complete and inform the user of the result.

## Error Handling

- **No images provided**: Ask user to paste reference images
