# Quick Start Guide

Get your autonomous coding crew building in 5 minutes.

## Prerequisites

- **OpenProse environment**: Claude Code + Opus, OpenCode + Opus, or Amp + Opus
- **OpenProse skill installed**: Run `npx skills add openprose/prose`
- **API keys configured**: Source `~/.bash_secrets` or set up `.env` file
- **Bash shell** (Linux/Mac) or WSL on Windows

## Step 1: Clone and Setup

```bash
# Clone or copy the autonomous-coding-crew directory to your workspace
cd ~/projects
git clone <your-repo> autonomous-coding-crew
cd autonomous-coding-crew

# Make the runner script executable (already done if you copied)
chmod +x run-crew.sh
```

## Step 2: Configure API Keys

The system needs API keys for external services. Choose one option:

**Option A: Source bash_secrets (recommended)**
```bash
source ~/.bash_secrets
```

**Option B: Use .env file**
```bash
cp .env.example .env
# Edit .env with your actual API keys
```

**Required API keys:**
- `GITHUB_TOKEN`: For repository operations
- `BRAVE_API_KEY`: For web search (researcher agent)
- `OPENROUTER_API_KEY`: Fallback model access

The primary LLM API key is handled by your OpenProse environment.

## Step 3: Prepare Your Project Specification

Use the example as a template:

```bash
cp examples/todo-app-spec.md my-project-spec.md
```

Edit `my-project-spec.md` with your specific requirements:
- Project overview and goals
- Functional and non-functional requirements
- Technology preferences (or let architect choose)
- Constraints (budget, timeline, compliance)
- Success criteria

**Tip**: The more detailed your spec, the better the output. Include specific APIs, data models, performance targets, and security requirements.

## Step 4: Choose Quality Bar and Team Size

Select your **quality bar** based on intended use:
- **prototype**: Quick exploration, minimal testing (30min - 2hrs)
- **production-ready**: Ship to users, comprehensive testing (2 - 6 hrs)
- **high-assurance**: Mission-critical, exhaustive validation (6 - 12 hrs)
- **safety-critical**: Regulatory compliance, formal methods (12+ hrs)

Select **team size** based on project scale:
- **1-2**: Small single-component projects
- **3-5** (default): Most applications
- **6-10**: Large multi-module systems (requires substantial compute)

## Step 5: Run the Crew

```bash
# Basic usage
./run-crew.sh examples/todo-app-spec.md

# Custom quality bar and team size
./run-crew.sh my-project-spec.md production-ready 4

# Prototype with small team, fast iteration
./run-crew.sh my-project-spec.md prototype 2 5
```

Or using prose directly:
```bash
cat my-project-spec.md | prose run autonomous-coder.md \
  --quality-bar production-ready \
  --team-size 3
```

## Step 6: Monitor Progress

The crew runs autonomously. You can monitor:

**Execution State**:
```bash
ls .prose/runs/  # See active runs
tail -f .prose/runs/LATEST/state.md  # Follow execution log
```

**Agent Workspaces** (to inspect intermediate work):
```bash
ls .prose/runs/LATEST/workspace/
ls .prose/runs/LATEST/bindings/
```

**Estimated times** (highly variable based on complexity):
- Prototype: 30min - 2hrs
- Production-ready: 2 - 6 hours
- High-assurance: 6 - 12 hours
- Large systems: 12 - 48 hours

## Step 7: Collect Deliverables

When complete, the crew returns a packaged project in `complete-project/`:

```
complete-project/
├── README.md                      # Start here
├── ARCHITECTURE.md                # Design overview
├── components/                    # Source code by component
├── tests/                         # Test suites with coverage
├── docs/                          # Documentation
├── infrastructure/                # Docker, Kubernetes, CI/CD
├── security/                      # Threat model and audit
├── decisions/                     # Architecture Decision Records
└── knowledge-base/                # Lessons learned
```

## Step 8: Review and Iterate

1. **Review deliverables**: Start with `README.md` and `ARCHITECTURE.md`
2. **Run the application**: Follow `docs/deployment-guide.md`
3. **Check test coverage**: Open `tests/coverage-report.html`
4. **Read security audit**: `security/security-audit.md`
5. **Understand decisions**: Browse `decisions/` for ADRs

If issues are found, you can:
- Adjust quality bar and re-run (agents will incorporate feedback)
- Tweak your specification and rerun
- Manually fix specific problems in the output (not recommended for full rebuilds)

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "prose: command not found" | Install skill: `npx skills add openprose/prose` |
| Execution hangs | Check for circular dependencies; inspect `.prose/runs/*/manifest.md` |
| Low quality output | Lower quality-bar to "prototype" or provide more detailed spec |
| Agents stuck in loop | Verify all `loop` statements have `max:` bound |
| Out of tokens/credits | Reduce team-size or quality-bar complexity |
| Memory errors | Run on machine with more RAM or reduce parallelism |

## Next Steps

- **Customize agents**: Edit service files in `services/` to match your org's standards
- **Add new services**: Create additional agents for domain-specific tasks (ML, DevOps, DBA)
- **Create templates**: Save successful specs as templates for common project types
- **Integrate tools**: Hook into your internal APIs, databases, or CI systems

## Need Help?

- **OpenProse docs**: https://prose.md
- **Language reference**: `skills/open-prose/prose.md` in cloned repo
- **Examples**: `skills/open-prose/examples/` in cloned repo
- **Issues**: https://github.com/openprose/prose/issues

---

**You're ready to build autonomously!** 🚀
