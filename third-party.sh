#!/usr/bin/env bash
# Installs the third-party skills I use, globally, from their original sources.
# My own skills live in ./skills; install them with: npx skills add micksmits/skills -g
set -euo pipefail

add() { npx -y skills add "$@" -g -y; }

add vercel-labs/agent-skills -s vercel-react-best-practices vercel-composition-patterns vercel-react-native-skills web-design-guidelines
add vercel-labs/skills -s find-skills
add vercel/ai -s ai-sdk
add supabase/agent-skills -s supabase supabase-postgres-best-practices
add posthog/posthog-for-claude -s posthog-instrumentation
add https://www.evlog.dev -s analyze-logs build-audit-logs review-logging-patterns
add caldoai/skills -s untangle-codebase

# Keep installed skills current with: npx skills update -g
