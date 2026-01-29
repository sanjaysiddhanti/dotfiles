#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values using jq
MODEL_ID=$(echo "$input" | jq -r '.model.id // "?"')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

# Extract model name from Bedrock ARN format
# Example: arn:aws:bedrock:...:claude-sonnet-4-5-20250929-v1:0 -> "Sonnet 4.5"
if [[ $MODEL_ID =~ (sonnet|haiku|opus)-([0-9]+)-([0-9]+) ]]; then
  model_type="${BASH_REMATCH[1]}"
  major_version="${BASH_REMATCH[2]}"
  minor_version="${BASH_REMATCH[3]}"
  # Capitalize first letter
  MODEL_DISPLAY="${model_type^} ${major_version}.${minor_version}"
else
  # Fallback to display_name if pattern doesn't match
  MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name // "?"')
fi
CONTEXT_USED=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
LINES_ADDED=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
LINES_REMOVED=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Get repo name from git
repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)

if [ -z "$repo_name" ]; then
  repo_name="no-repo"
else
  # Apply substitutions
  case "$repo_name" in
  customer-portal-data-gateway)
    repo_name="CPDG"
    ;;
  customer-portal-2)
    repo_name="CP2"
    ;;
  akasa-workflow-engine)
    repo_name="wfe"
    ;;
  esac
fi

# Format cost with $ prefix
cost_formatted=$(printf '$%.4f' "$COST")

# Calculate net lines (added - removed)
net_lines=$((LINES_ADDED - LINES_REMOVED))
if [ $net_lines -ge 0 ]; then
  lines_display="+${net_lines}"
else
  lines_display="${net_lines}"
fi

# Format context usage percentage
context_display=$(printf "%.0f%%" "$CONTEXT_USED")

echo "${repo_name} | ${MODEL_DISPLAY} | ${cost_formatted} | ${context_display} | ${lines_display}"
