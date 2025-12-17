# Design Builder

Claude Code plugin that extracts copy and design from references to build frontend components or generate prompts for AI tools.

> **Part of [claude-code-plugins](https://github.com/adeonir/claude-code-plugins)** - A curated marketplace of Claude Code plugins for feature development, debugging, frontend generation, and git helpers.

## Features

- Extract content structure from URLs (optional)
- Extract design tokens from reference images (screenshots, mockups)
- Build frontend components directly with Claude Code
- Generate optimized prompts for Replit, v0, Lovable, Figma
- Auto-scaffold Vite projects when needed
- Auto-loaded skill to avoid generic "AI slop" aesthetics
- Generate multiple design variations for comparison

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) - Anthropic's official CLI for Claude

### Add Marketplace

First, add the marketplace to Claude Code (only needed once):

```bash
/plugin marketplace add adeonir/claude-code-plugins
```

### Install Plugin

```bash
/plugin install design-builder
```

This command automatically:
- Downloads the plugin from the marketplace
- Auto-loads the `frontend-design` skill for distinctive aesthetics
- Makes all commands available in your Claude Code session

## Workflows

Two entry points, each can end with `/build-frontend` or `/generate-prompt`:

```
# Full: Start from URL reference
URL -> /extract-copy -> copy.yaml -> /extract-design -> design.json

# Minimal: Start from design image only (with brief project description)
Image -> /extract-design -> design.json

# Then choose output:
-> /build-frontend              # Single build
-> /build-frontend --variations # Multiple variations
-> /generate-prompt             # For Replit/v0/Lovable
```

## Commands

| Command | Description |
|---------|-------------|
| `/extract-copy` | Extract content from URL to copy.yaml (optional) |
| `/extract-design` | Extract design from images to design.json |
| `/generate-prompt` | Generate prompt for target platform |
| `/build-frontend` | Build frontend in ./src/ (or `--variations N` for comparison) |
| `/select` | Select a variation after comparison |

## Agents

| Agent | Role |
|-------|------|
| `copy-extractor` | Content Strategist - extracts content from URLs |
| `design-extractor` | Creative Director - extracts design from images |
| `prompt-generator` | Prompt Engineer - generates platform-specific prompts |
| `frontend-builder` | Frontend Engineer - builds components |
| `variations-builder` | Variations Engineer - generates multiple layouts |

## Skills

| Skill | Description |
|-------|-------------|
| `frontend-design` | Distinctive design principles that avoid generic AI aesthetics |

## Design Variations

Generate 2-3 layout variations to compare before choosing:

```bash
/build-frontend --variations 3
```

This generates:
```
./outputs/
  editorial/   # Split hero, generous spacing, flat cards
  startup/     # Centered hero, balanced, shadow cards
  bold/        # Fullscreen hero, compact, bordered cards
  preview.html # Side-by-side comparison
```

Then select your preferred variation:

```bash
/select editorial
# Copies to ./src/ (outputs/ preserved as backup)
```

### Variation Presets

Each preset applies design guidelines (60-30-10 color rule, visual hierarchy, rhythm):

| Preset | Style | Hero | Spacing | Cards |
|--------|-------|------|---------|-------|
| `editorial` | Magazine feel | Split 50/50, image left | Generous | Flat, no shadow |
| `startup` | SaaS modern | Centered, prominent CTA | Balanced | Soft shadows |
| `bold` | High impact | Fullscreen, text over image | Compact | Strong borders |

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

### Full Workflow

```bash
# 1. Extract copy from reference URL
/extract-copy https://example.com --type=landing

# 2. Extract design from images
/extract-design
# Then paste reference images

# 3. Build or generate prompt
/build-frontend
# OR
/generate-prompt --target=replit
```

### Minimal Workflow (design only)

```bash
# 1. Extract design from images (will ask for project description)
/extract-design
# Paste images, then provide brief description

# 2. Build frontend
/build-frontend
```

### Variations Workflow

```bash
# 1. Extract design (same as before)
/extract-design

# 2. Generate variations
/build-frontend --variations 3

# 3. Open outputs/preview.html to compare

# 4. Select preferred variation
/select startup
```

## Credits

Copy/design extraction workflow inspired by [Deborah Folloni's method](https://dfolloni.substack.com/p/os-prompts-que-eu-uso-para-fazer).

## License

MIT
