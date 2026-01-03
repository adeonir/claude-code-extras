---
description: Define product vision, data models, and features from scratch
argument-hint: [--type=landing|website|webapp|app]
---

# Plan Product Command

Define product structure when starting without reference URL or images.

## Arguments

- `--type` - Project type (landing, website, webapp, app)

Arguments received: $ARGUMENTS

## Process

Invoke the `product-planner` subagent to gather requirements and generate a product plan.

The product-planner will:
1. Ask about the product (name, type, description)
2. Define target audience and pain points
3. Establish value proposition and features
4. Structure sections/screens
5. Set style direction
6. Generate product-plan.yaml in ./docs/

Wait for the agent to complete and inform the user of the result.

## Next Steps

After the plan is created, user should:
1. Provide reference images and run `/design-builder:design`
2. Or run `/design-builder:design` without images (will use plan for context)
