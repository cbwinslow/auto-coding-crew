#!/bin/bash
# Simple validation test for the autonomous coding crew system
# This tests the basic structure without requiring the full OpenProse runtime

set -e

echo "🔍 Validating Autonomous Coding Crew System Structure"
echo "==================================================="

cd /home/cbwinslow/auto-coding-crew

# Test 1: Check main program structure
echo "✅ Test 1: Main program structure"
if grep -q "kind: program" autonomous-coder.md && grep -q "services:" autonomous-coder.md; then
    echo "   ✓ Main program has correct frontmatter"
else
    echo "   ✗ Main program missing required fields"
    exit 1
fi

# Test 2: Check all declared services exist
echo "✅ Test 2: Service file existence"
MAIN_SERVICES=$(grep "services:" autonomous-coder.md | grep -o '\[.*\]' | tr -d '[]' | tr ',' '\n' | sed 's/ //g')
MISSING_SERVICES=""
for service in $MAIN_SERVICES; do
    if [ ! -f "services/${service}.md" ]; then
        MISSING_SERVICES="$MISSING_SERVICES $service"
    fi
done

if [ -z "$MISSING_SERVICES" ]; then
    echo "   ✓ All declared services have corresponding files"
else
    echo "   ✗ Missing service files:$MISSING_SERVICES"
    exit 1
fi

# Test 3: Check service contracts
echo "✅ Test 3: Service contract structure"
INVALID_CONTRACTS=""
for service_file in services/*.md; do
    if ! grep -q "^requires:" "$service_file" || ! grep -q "^ensures:" "$service_file"; then
        INVALID_CONTRACTS="$INVALID_CONTRACTS $(basename "$service_file" .md)"
    fi
done

if [ -z "$INVALID_CONTRACTS" ]; then
    echo "   ✓ All services have proper contracts (requires/ensures)"
else
    echo "   ✗ Services missing contracts:$INVALID_CONTRACTS"
    exit 1
fi

# Test 4: Check execution flow references
echo "✅ Test 4: Execution flow validation"
if grep -q "call orchestrator" autonomous-coder.md && grep -q "parallel:" autonomous-coder.md; then
    echo "   ✓ Main program has execution flow with service calls"
else
    echo "   ✗ Main program missing execution flow"
    exit 1
fi

# Test 5: Check example specification
echo "✅ Test 5: Example project spec"
if [ -f "examples/todo-app-spec.md" ] && grep -q "# Project:" examples/todo-app-spec.md; then
    echo "   ✓ Example specification exists and is properly formatted"
else
    echo "   ✗ Example specification missing or malformed"
    exit 1
fi

echo ""
echo "🎉 All validation tests passed!"
echo ""
echo "📊 System Statistics:"
echo "   - Services: $(ls services/ | wc -l)"
echo "   - Total files: $(find . -name "*.md" -o -name "*.sh" -o -name ".gitignore" | wc -l)"
echo "   - Lines of code: $(find . -name "*.md" -exec wc -l {} \; | awk '{sum += $1} END {print sum}')"
echo ""
echo "🚀 System is ready for deployment!"
echo ""
echo "To run with OpenProse:"
echo "  ./run-crew.sh examples/todo-app-spec.md"
echo ""
echo "Or manually:"
echo "  prose run autonomous-coder.md --project-spec \"\$(cat examples/todo-app-spec.md)\" --quality-bar production-ready --team-size 3"
