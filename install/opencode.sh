#!/bin/bash

# Install OpenCode agents, commands, and skills from plugins/*/_opencode/ to ~/.config/opencode/

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

echo "OpenCode Install"
echo "================"
echo ""

# Create config directories
mkdir -p "$CONFIG_DIR/agents" "$CONFIG_DIR/commands" "$CONFIG_DIR/skills"

# Counters
plugin_count=0
agent_count=0
command_count=0
skill_count=0

# Process all plugins
for plugin in "$REPO_DIR"/plugins/*/; do
    plugin_name=$(basename "$plugin")
    opencode_dir="$plugin/_opencode"
    
    # Skip if no _opencode folder
    [[ ! -d "$opencode_dir" ]] && continue
    
    ((plugin_count++))
    echo "Plugin: $plugin_name"
    
    # Copy agents
    if [[ -d "$opencode_dir/agents" ]]; then
        for agent in "$opencode_dir/agents/"*.md; do
            [[ -f "$agent" ]] || continue
            cp "$agent" "$CONFIG_DIR/agents/"
            ((agent_count++))
            echo "  + agent: $(basename "$agent" .md)"
        done
    fi
    
    # Copy commands
    if [[ -d "$opencode_dir/commands" ]]; then
        for cmd in "$opencode_dir/commands/"*.md; do
            [[ -f "$cmd" ]] || continue
            cp "$cmd" "$CONFIG_DIR/commands/"
            ((command_count++))
            echo "  + command: $(basename "$cmd" .md)"
        done
    fi
    
    # Copy skills (directory structure: skills/{name}/SKILL.md)
    if [[ -d "$opencode_dir/skills" ]]; then
        for skill_dir in "$opencode_dir/skills/"*/; do
            [[ -d "$skill_dir" ]] || continue
            skill_name=$(basename "$skill_dir")
            if [[ -f "$skill_dir/SKILL.md" ]]; then
                mkdir -p "$CONFIG_DIR/skills/$skill_name"
                cp "$skill_dir/SKILL.md" "$CONFIG_DIR/skills/$skill_name/"
                ((skill_count++))
                echo "  + skill: $skill_name"
            fi
        done
    fi
done

echo ""

if [[ $plugin_count -eq 0 ]]; then
    echo "No plugins with _opencode/ folder found."
    exit 1
fi

# Build summary
summary="Plugins: $plugin_count | Agents: $agent_count | Commands: $command_count"
if [[ $skill_count -gt 0 ]]; then
    summary="$summary | Skills: $skill_count"
fi

echo "Installed to $CONFIG_DIR"
echo "$summary"
