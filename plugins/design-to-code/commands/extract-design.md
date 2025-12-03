---
description: Extract design tokens from reference images to design.json
argument-hint: [image-url...]
---

Extract design tokens from reference images to generate a design.json file.

**Arguments received:** $ARGUMENTS

**Task:** Use the design-extractor agent to:
1. If image URLs provided, fetch them with WebFetch
2. If no URLs, request images from user (paste screenshots or provide URLs)
3. Locate existing copy.yaml for project context
4. Extract colors, typography, spacing, components
5. Generate design.json in the same folder as copy.yaml
