# Design to Code

Claude Code plugin that extracts design systems from references and generates prompts for AI design tools or builds React 19 + Tailwind v4 components directly.

## Architecture

```
design-to-code/
├── .claude-plugin/
│   └── plugin.json                 # Plugin manifest
├── agents/                         # Specialized subagents
│   ├── copy-extractor.md           # Content Strategist
│   ├── design-extractor.md         # Creative Director
│   ├── prompt-generator.md         # Prompt Engineer
│   └── frontend-builder.md         # Frontend Engineer
├── commands/                       # Slash commands
│   ├── extract-copy.md
│   ├── extract-design.md
│   ├── generate-prompt.md
│   └── build-frontend.md
├── skills/                         # Auto-loaded guidance
│   └── frontend-design/SKILL.md
└── prompts/{project}/              # Output directory
    ├── copy.yaml
    ├── design.json
    └── prompt-{target}.md
```

## Workflow

```
URL ──► /extract-copy ──► copy.yaml ──► /extract-design ──► design.json ─┬─► /generate-prompt ──► prompt.md
                                              ▲                          │         │
                                              │                          │         ▼
                                    reference images                     │   External tools
                                    (Dribbble, screenshots)              │   (Replit, v0, etc)
                                                                         │
                                                                         └─► /build-frontend ──► React components
                                                                                                 (skill auto-applied)
```

## Commands

| Command | Description |
|---------|-------------|
| `/extract-copy` | Extract content from URL to copy.yaml |
| `/extract-design` | Extract design from images to design.json |
| `/generate-prompt` | Generate prompt for target platform |
| `/build-frontend` | Build React 19 + Tailwind v4 components |

## Agents

| Agent | Role | Model |
|-------|------|-------|
| `copy-extractor` | Content Strategist | opus |
| `design-extractor` | Creative Director | opus |
| `prompt-generator` | Prompt Engineer | opus |
| `frontend-builder` | Frontend Engineer | opus |

Agents can be invoked directly: "Use the copy-extractor agent to analyze this site"

## Skills

| Skill | Description |
|-------|-------------|
| `frontend-design` | Design principles auto-loaded for frontend tasks (avoids AI slop aesthetics) |

Skills are loaded automatically when relevant context is detected.

## Project Types

| Type | Description | Example |
|------|-------------|---------|
| `landing` | Single-page landing | Product page, lead capture |
| `website` | Multi-page site | Corporate, blog, portfolio |
| `webapp` | Interactive application | Dashboard, SaaS, admin panel |
| `app` | Mobile application | iOS/Android, PWA |

## Prompt Targets

| Target | Style | Best For |
|--------|-------|----------|
| `replit` | Detailed, design.json inline | Full landing pages with images |
| `v0` | Concise, shadcn/ui | Quick React components |
| `lovable` | UX-focused, flows | Apps with Supabase backend |
| `figma` | Component specs | Design system documentation |

## Usage

### 1. Extract Copy

```bash
/extract-copy https://example.com --type=landing --name=my-project
```

### 2. Extract Design

```bash
/extract-design
# Then paste reference images
```

### 3. Generate Prompt

```bash
/generate-prompt --target=replit
```

### 4. Build Frontend (alternative to external tools)

```bash
/build-frontend --output=./src/components
```

## Design Philosophy

### Avoid (symptoms of "vibe coded"):
- Generic purple gradients
- Inter as lazy fallback font
- Icons only, no real images
- Identical layouts across sections
- Missing hover states and micro-interactions
- Cramped spacing

### Do:
- Extract style from professional references
- Use consistent design tokens
- Implement all hover states
- Alternate backgrounds between sections
- Generous whitespace
- Subtle, purposeful animations

## Output Formats

### copy.yaml
- `landing/website`: sections with hero, features, cta, footer
- `webapp`: screens with widgets, auth, sidebar navigation
- `app`: screens, onboarding, bottom-tabs, gestures, native features

### design.json
```json
{
  "meta": { "name", "version", "project_type" },
  "principles": { "overall", "keywords", "avoid" },
  "colors": { "primary", "accent", "neutral", "semantic" },
  "typography": { "fonts", "scale", "emphasis" },
  "spacing": { "section", "container", "grid", "component" },
  "components": { "button", "card", "badge", "input", "icon" },
  "effects": { "shadows", "transitions" },
  "animations": { "fadeInUp", "hoverLift", "stagger" },
  "backgrounds": { "patterns", "gradients", "sections" }
}
```

## References

- Workflow based on Deborah Folloni's method (DebGPT)
- [Original post](https://dfolloni.substack.com/p/os-prompts-que-eu-uso-para-fazer)
- [Dribbble](https://dribbble.com/) for visual references

## Tips

1. **Find good Dribbble references:**
   - `"[niche] landing page"`
   - `"[niche] design system"`
   - `"SaaS dashboard"`
   - `"mobile app [niche]"`

2. **For webapps:**
   - `"dashboard UI"`
   - `"admin panel"`
   - `"SaaS interface"`

3. **For apps:**
   - `"mobile app UI"`
   - `"iOS app design"`
   - `"fintech app"`

4. **Iterate on design.json:**
   - If something doesn't look right, adjust specific values
   - The file is the single source of truth
