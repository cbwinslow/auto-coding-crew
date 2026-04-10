#!/bin/bash
# Runs the autonomous coding crew with the provided project specification
# Usage: ./run-crew.sh "path-to-spec.md" [quality-bar] [team-size]

set -e

SPEC_FILE="$1"
QUALITY_BAR="${2:-production-ready}"
TEAM_SIZE="${3:-3}"
MAX_ITERATIONS="${4:-10}"

if [ -z "$SPEC_FILE" ]; then
  echo "Usage: $0 <spec-file> [quality-bar:production-ready] [team-size:3] [max-iterations:10]"
  echo ""
  echo "Examples:"
  echo "  $0 examples/todo-app-spec.md"
  echo "  $0 examples/todo-app-spec.md prototype 2"
  exit 1
fi

if [ ! -f "$SPEC_FILE" ]; then
  echo "Error: Specification file not found: $SPEC_FILE"
  exit 1
fi

# Read spec content
SPEC_CONTENT=$(cat "$SPEC_FILE")

echo "🚀 Starting Autonomous Coding Crew..."
echo "📋 Specification: $SPEC_FILE"
echo "🎯 Quality Bar: $QUALITY_BAR"
echo "👥 Team Size: $TEAM_SIZE"
echo "🔄 Max Iterations: $MAX_ITERATIONS"
echo ""

# Verify OpenProse is available
if ! command -v prose &> /dev/null; then
  echo "⚠️  OpenProse CLI not found. Ensure skill is installed."
  echo "Install with: npx skills add openprose/prose"
  exit 1
fi

# Run the program
exec prose run autonomous-coder.md \
  --project-spec "$SPEC_CONTENT" \
  --quality-bar "$QUALITY_BAR" \
  --team-size "$TEAM_SIZE" \
  --max-iterations "$MAX_ITERATIONS"
