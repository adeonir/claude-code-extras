# Design to Code

Claude Code plugin that extracts design systems from references and generates prompts for AI design tools or builds React 19 + Tailwind v4 components directly.

## Features

- Extract content structure from URLs
- Extract design tokens from reference images (Dribbble, screenshots)
- Generate optimized prompts for Replit, v0, Lovable, Figma
- Build React 19 + Tailwind v4 components directly with Claude Code
- Auto-loaded skill to avoid generic "AI slop" aesthetics

## Installation

```bash
# Add marketplace (if not already added)
/plugin marketplace add adeonir/plugins

# Install plugin
/plugin install design-to-code
```

## Commands

| Command | Description |
|---------|-------------|
| `/extract-copy` | Extract content from URL to copy.yaml |
| `/extract-design` | Extract design from images to design.json |
| `/generate-prompt` | Generate prompt for target platform |
| `/build-frontend` | Build React 19 + Tailwind v4 components |

## Workflow

```
URL -> /extract-copy -> copy.yaml -> /extract-design -> design.json -+-> /generate-prompt -> External tools
                                                                      |
                                                                      +-> /build-frontend -> React components
```

## Agents

| Agent | Role |
|-------|------|
| `copy-extractor` | Content Strategist - extracts content from URLs |
| `design-extractor` | Creative Director - extracts design from images |
| `prompt-generator` | Prompt Engineer - generates platform-specific prompts |
| `frontend-builder` | Frontend Engineer - builds React components |

## Skills

| Skill | Description |
|-------|-------------|
| `frontend-design` | Design principles auto-loaded for frontend tasks |

## Project Types

| Type | Example |
|------|---------|
| `landing` | Product page, lead capture |
| `website` | Corporate, blog, portfolio |
| `webapp` | Dashboard, SaaS, admin panel |
| `app` | iOS/Android, PWA |

## Prompt Targets

| Target | Best For |
|--------|----------|
| `replit` | Full landing pages with images |
| `v0` | Quick React/shadcn components |
| `lovable` | Apps with Supabase backend |
| `figma` | Design system documentation |

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

### 4. Build Frontend

```bash
/build-frontend --output=./src/components
```

## Credits

Workflow inspired by [Deborah Folloni's method](https://dfolloni.substack.com/p/os-prompts-que-eu-uso-para-fazer).

## License

MIT
