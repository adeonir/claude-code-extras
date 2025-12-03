---
name: frontend-design
description: Apply distinctive design principles when building frontend interfaces. Avoids generic AI aesthetics.
---

## Design Principles

When building frontend interfaces, apply these principles to avoid distributional convergence to generic "AI slop" aesthetics.

### Typography

- Use distinctive fonts from Google Fonts (avoid Inter, Arial, Roboto, system fonts)
- Apply extremes: weights 100/200 vs 800/900, size jumps of 3x+
- Pick ONE distinctive display font and commit to it
- Pair a characterful display font with a refined body font

### Color & Theme

- Dominant colors with sharp accents (not evenly distributed palettes)
- Use CSS variables for consistency
- Draw inspiration from IDE themes, editorial design, or specific aesthetics
- Commit to a cohesive aesthetic: brutally minimal, maximalist, retro-futuristic, organic, luxury, playful, editorial, brutalist, art deco, soft/pastel, or industrial

### Motion

- Prioritize ONE well-orchestrated animation moment over scattered micro-interactions
- Use staggered page-load reveals with animation-delay
- CSS-only solutions for HTML; Motion library for React
- Focus on high-impact moments: scroll-triggering and hover states that surprise

### Backgrounds & Depth

- Create atmosphere with gradients, noise, geometric patterns
- Layer transparencies and subtle textures
- Apply gradient meshes, grain overlays, decorative borders
- Avoid flat solid color backgrounds

### Spatial Composition

- Unexpected layouts with asymmetry and overlap
- Diagonal flow and grid-breaking elements
- Generous negative space OR controlled density
- Alternate backgrounds between sections

### Anti-Patterns (NEVER use)

- Inter, Roboto, Arial as primary fonts
- Purple gradients on white backgrounds
- Predictable centered layouts
- Missing hover states and micro-interactions
- Icons only without real images
- Cramped spacing
- Cookie-cutter design lacking context-specific character

### Stack

- React 19 + Tailwind v4
- Load fonts from Google Fonts
- Use CSS variables for design tokens
- Implement all hover/focus/active states
