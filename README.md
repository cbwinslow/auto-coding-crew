# Autonomous Coding Crew

A production-ready OpenProse system for fully autonomous AI agent teams that can design, implement, test, secure, and document complete applications without human intervention.

## Overview

This system orchestrates a crew of 10 specialized AI agents that collaborate to build complete software projects:

- **Orchestrator**: Project manager and conductor, maintains state, coordinates team, enforces quality gates
- **Architect**: Designs system architecture, selects technologies, defines component interfaces
- **Researcher**: Performs web searches, gathers evidence, validates technical claims
- **Implementer**: Writes production code following architecture and quality standards
- **Reviewer**: Conducts code reviews, ensures quality, suggests improvements
- **Tester**: Designs test strategies, writes and executes tests, measures quality
- **Security-Expert**: Performs threat modeling, security architecture, vulnerability scanning
- **Debugger**: Diagnoses failures, finds root causes, proposes fixes
- **Validator**: Enforces quality gates, detects task drift and hallucinations, validates conformance
- **Synthesizer**: Builds consensus, resolves conflicts, integrates components, makes decisions

### Key Capabilities

- **Fully Autonomous**: From project specification to complete, deployable application
- **Self-Validating**: Multiple redundant quality checks and peer review
- **Self-Debugging**: Automated failure detection, diagnosis, and repair loops
- **Self-Correcting**: Task drift detection, hallucination prevention, quality gates
- **Parallel Execution**: Multiple implementers work concurrently on independent components
- **Democratic Decision Making**: Structured debate, evidence-based voting, dissenting opinions recorded
- **Anti-Hallucination**: Claim verification, source citation, cross-validation
- **Comprehensive Testing**: Unit, integration, E2E, performance, security testing
- **Professional Deliverables**: Architecture docs, API specs, test suites, security audits, deployment guides
- **Knowledge-Enhanced**: Semantic search of existing codebases for implementation patterns
- **Memory-Persistent**: Learns from past projects via Letta memory system
- **DevOps-Ready**: Automated Docker containerization and GitHub repository management

## Requirements

- **OpenProse environment**: Claude Code + Opus, OpenCode + Opus, or Amp + Opus
- **OpenProse skill installed**: `npx skills add openprose/prose`
- **Filesystem workspace**: Agents read/write files to communicate state
- **Prose Complete system**: Capable of spawning subagent sessions and executing the Prose VM

## API Keys & Environment Setup

**OpenProse itself uses ONE API key** - the key for your Prose Complete environment (Claude Code, OpenCode, or Amp). Individual agents do not get separate LLM API keys - they are subagent sessions within the same context.

However, some agents may need external API keys for specific functionality:

- **Researcher**: Uses `BRAVE_API_KEY` for web search and fact-checking
- **All agents**: May use `GITHUB_TOKEN` for repository operations
- **Fallback models**: `OPENROUTER_API_KEY` if needed

**Setup options:**

1. **Source bash_secrets** (recommended):
   ```bash
   source ~/.bash_secrets  # Contains all API keys
   ```

2. **Use .env file**:
   ```bash
   cp .env.example .env    # Edit with your keys
   ```

3. **Environment variables**: Set directly in your shell or CI/CD

The system automatically detects and uses available API keys from the environment.

## Installation

Clone or copy this system to your workspace:

```bash
git clone <your-repo> autonomous-coding-crew
cd autonomous-coding-crew
```

No dependencies to install - OpenProse runs natively in supported environments.

## Usage

### Basic Invocation

```bash
prose run autonomous-coder.md \
  --project-spec "Build a Todo API with user authentication, React frontend, PostgreSQL, Docker deployment" \
  --quality-bar "production-ready" \
  --team-size 3 \
  --max-iterations 10
```

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `project-spec` | string | required | Detailed specification of what to build |
| `quality-bar` | string | "production-ready" | Quality level: "prototype", "production-ready", "high-assurance", "safety-critical" |
| `team-size` | integer | 3 | Number of parallel implementer agents |
| `max-iterations` | integer | 10 | Maximum refinement cycles to prevent infinite loops |

### Project Specification Format

Your `project-spec` should be comprehensive. Include:

```markdown
# Project: [Name]

## Overview
Brief description of what this project is and who it's for.

## Functional Requirements
- [ ] Feature 1 with acceptance criteria
- [ ] Feature 2 with user stories
- [ ] ...

## Non-Functional Requirements
- Performance: [target response times, throughput]
- Security: [authentication method, authorization model, compliance needs]
- Reliability: [availability target, RTO/RPO]
- Scalability: [expected users, data volume, growth rate]
- Maintainability: [code quality standards, documentation needs]

## Constraints
- Technology preferences or prohibitions
- Timeline or budget constraints
- Team skill level assumptions
- Integration requirements (existing systems)
- Deployment environment (cloud provider, on-prem, etc.)

## Success Criteria
How we'll know the project is complete and successful.
```

### Quality Bars

- **prototype**: Quick exploration, basic functionality, no formal testing required, coverage >30%
- **production-ready**: Ship to users, comprehensive testing, security audit, documentation, coverage >80%
- **high-assurance**: Mission-critical, exhaustive testing, formal review, compliance, coverage >90%
- **safety-critical**: Regulatory compliance, formal methods where applicable, independent audit

### Team Size

- **1-2**: Sequential work, suitable for small components
- **3-5**: Optimal for most projects, good parallelism
- **6+**: For very large systems with independent modules

Larger teams require more coordination overhead; orchestrator manages this automatically.

## Enhanced Services

The system now includes **16 specialized AI agents** leveraging advanced capabilities:

#### Core Agents (Original)
- **Orchestrator**: Project management and team coordination
- **Architect**: System design and technology selection
- **Researcher**: External research and fact verification
- **Implementer**: Code writing and component development
- **Reviewer**: Code quality assessment and best practices
- **Tester**: Comprehensive testing strategy and execution
- **Security-Expert**: Threat modeling and security implementation
- **Debugger**: Root cause analysis and fix planning
- **Validator**: Quality gate enforcement and standards compliance
- **Synthesizer**: Consensus building and final integration

#### Enhanced Agents (New)
- **Knowledge-Retrieval**: Semantic search of existing codebases using CBW RAG
- **Memory-Manager**: Persistent learning via Letta memory system
- **GitHub-Ops**: Repository management and CI/CD integration
- **Docker-Ops**: Containerization and deployment automation

## Architecture

### Two-Phase Execution

**Phase 1: Forme Container**
- Reads all service contracts
- Matches `requires:`/`ensures:` between services
- Produces wiring manifest showing dependency graph
- Validates all contracts can be satisfied

**Phase 2: Prose VM**
- Reads manifest
- Creates workspace for each service
- Executes services in dependency order
- Passes data via filesystem bindings
- Manages state in `.prose/runs/`

### Service Contracts

Each service declares:
- `requires`: What inputs it needs (from caller or other services)
- `ensures`: What outputs it produces
- `errors`: What failure modes it can signal
- `invariants`: What must remain true throughout execution
- `strategies`: How to handle edge cases

The Forme Container auto-wires services by matching outputs to inputs.

### Communication Pattern

Services communicate via filesystem:
```
.prose/runs/{run-id}/
├── bindings/
│   ├── orchestrator/   # orchestrator's outputs
│   │   └── plan.md
│   ├── architect/
│   │   └── architecture.md
│   └── ...
└── workspace/          # private working directories
```

A service writes its outputs to `bindings/{service-name}/{filename}.md` where other services can read them.

### Execution Flow

1. **Initialization**: Orchestrator forms team charter from spec
2. **Research**: Researcher fills knowledge gaps
3. **Architecture**: Architect produces complete design with security review
4. **Validation**: Validator checks architecture quality
5. **Implementation**: Parallel implementers build components
6. **Review**: Reviewer and security-expert examine each component
7. **Testing**: Tester creates and executes comprehensive test suite
8. **Debugging**: Debugger fixes any issues, loop until clean
9. **Integration**: Components integrated, system testing
10. **Validation**: Final quality assurance check
11. **Documentation**: Complete docs and deployment guides
12. **Knowledge Capture**: Synthesizer captures lessons learned
13. **Delivery**: Final packaged deliverable returned

## Anti-Hallucination Mechanisms

1. **Source Verification**: Researcher must cite sources; validator verifies citations
2. **Cross-Validation**: Critical claims checked by multiple agents
3. **Fact-Checking Loop**: Unsupported claims trigger researcher intervention
4. **Evidence Threshold**: "Known facts" require ≥2 authoritative sources; opinions clearly marked as such
5. **Version Anchoring**: All claims tied to specific versions or dates

## Task Drift Prevention

1. **Constant Referencing**: Orchestrator maintains and references original spec and team charter
2. **Scope Change Process**: Any deviation requires charter update and orchestrator approval
3. **Quality Gates**: Phase transitions require validation against original objectives
4. **Drift Detection**: Validator quantifies scope change and flags >10% drift
5. **Re-anchoring**: When drift detected, orchestrator realigns team to original goals

## Conflict Resolution & Voting

When agents disagree:

1. **Structured Debate** (synthesizer facilitates):
   - Each side presents evidence and reasoning
   - Cross-examination of assumptions
   - Expert testimony weighted by relevant expertise

2. **Evidence-Based Voting**:
   - Each agent casts vote with rationale
   - Expert opinions weighted (security-expert on security matters = 2 votes)
   - Majority wins, with supermajority (>66%) for major decisions

3. **Dissent Recording**:
   - Minority opinions documented in Decision Records (ADRs)
   - Rationale for rejecting minority view explicitly stated
   - Dissent can trigger reconsideration if new evidence emerges

4. **Tie-Breaking**: Orchestrator decides when vote is 50-50

## Directory Structure

```
autonomous-coding-crew/
├── autonomous-coder.md           # Main program entry point
├── README.md                     # This file
├── services/                     # Agent service definitions
│   ├── orchestrator.md
│   ├── architect.md
│   ├── researcher.md
│   ├── implementer.md
│   ├── reviewer.md
│   ├── tester.md
│   ├── security-expert.md
│   ├── debugger.md
│   ├── validator.md
│   └── synthesizer.md
├── templates/                    # Optional: templates for deliverables
│   ├── architecture-template.md
│   ├── adr-template.md
│   └── security-audit-template.md
└── examples/                     # Example project specifications
    └── todo-api-react-postgres.md
```

## Output Deliverables

After successful execution, you receive:

```
complete-project/
├── README.md                     # Project overview
├── ARCHITECTURE.md               # System design
├── api-specs/
│   ├── openapi.yaml              # REST API specification
│   └── graphql-schema.graphql    # GraphQL schema (if applicable)
├── components/
│   ├── [component-a]/
│   │   ├── src/
│   │   ├── tests/
│   │   └── README.md
│   └── [component-b]/
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── e2e/
│   ├── performance/
│   ├── coverage-report.html
│   └── test-results.xml
├── docs/
│   ├── deployment-guide.md
│   ├── operations-runbook.md
│   ├── api-documentation.md
│   └── user-manual.md
├── security/
│   ├── threat-model.md
│   ├── security-audit.md
│   └── compliance-matrix.md
├── infrastructure/
│   ├── docker-compose.yml
│   ├── kubernetes/
│   ├── terraform/ or cdk/
│   └── ci-cd-pipeline.yml
├── decisions/
│   ├── adr-001-*.md
│   ├── adr-002-*.md
│   └── ...
├── knowledge-base/
│   ├── lessons-learned.md
│   ├── technical-debt.md
│   └── decisions-rationale.md
├── scripts/                      # Helper scripts
└── package.json / requirements.txt / etc.
```

All code is production-ready, tested, documented, and deployable.

## Advanced Usage

### Customizing Agent Behavior

Each service's behavior is defined by its contract and execution logic in the service file. To customize:

1. Edit the `requires`, `ensures`, `shape`, or strategies in the service file
2. Modify the execution block logic if needed
3. Quality bar enforcement can be tuned per-project

### Integrating Custom Tools

Agents can use any tools available in the Prose environment:
- Web search
- File operations
- Shell commands
- Database access
- API calls

To add custom tool integration, edit the appropriate service's execution logic to invoke the desired tool.

### Parallelism Tuning

Adjust `team-size` based on your compute budget:
- More team members = faster but more concurrent API calls and token usage
- Fewer team members = slower but cheaper

Also, the main program automatically uses `parallel:` blocks for independent work. This can be tuned if needed.

### Quality Bar Tuning

Edit the quality bar definitions in `autonomous-coder.md` strategies or the service contracts to match your needs. For example, if you don't need security for a prototype, set quality-bar to "prototype" and security-expert will be less strict.

## Monitoring Progress

The Prose VM maintains state in `.prose/runs/{run-id}/`. Useful files:

- `manifest.md`: Shows dependency graph and execution order
- `state.md`: Execution log with timestamps
- `workspace/{agent}/`: Agent's working files and intermediate output
- `bindings/{agent}/`: Agent's final outputs

Track progress by examining these files mid-execution.

## Troubleshooting

### Issues hang or timeout
- Check for circular dependencies in contracts
- Look for infinite loops; ensure all loops have `max:` limit
- Some services may be waiting for dependencies; inspect manifest

### Agents hallucinate or produce poor quality
- Lower quality bar or provide more detailed spec
- Increase research depth
- Add more specific constraints to project spec
- Run validator to identify and flag hallucinations

### Quality bar not met repeatedly
- Increase number of iterations
- Adjust quality bar expectations
- Debug persistent issues with debugger service
- Consider manual intervention for architectural fixes

### Performance slow
- Reduce team-size to lower parallelism
- Use faster/higher-context models for agents
- Check for redundant work being done

## Is OpenProse the Future?

Yes. OpenProse (and the broader "prose programming" paradigm) represents the future of AI agent orchestration because:

1. **Portability**: No vendor lock-in; runs on any Prose Complete system
2. **Declarative by default**: Contracts make intent explicit, container auto-wires
3. **AI-native**: Designed for LLM understanding, not human convenience
4. **Composable**: Services as reusable building blocks with clear interfaces
5. **Stateful**: Built-in state management without external databases
6. **Zero dependencies**: Just markdown files; no Python packages or npm modules
7. **Intelligent IoC**: The container understands contracts, not just type signatures
8. **Multi-agent orchestration**: Native support for complex dependency graphs
9. **Production proven**: Real systems built with it (see examples in repo)
10. **Markdown-first**: Documentation and code are the same artifact

LangChain, CrewAI, and similar are orchestration libraries - they still require code. OpenProse is declarative programming: you describe *what* (contracts and strategies), the VM figures out *how*. This is the abstraction level needed for autonomous agents.

## Example Run

```bash
# Clone system
git clone https://github.com/your-org/autonomous-coding-crew.git
cd autonomous-coding-crew

# Run with detailed specification
prose run autonomous-coder.md \
  --project-spec "$(cat examples/todo-api-react-postgres.md)" \
  --quality-bar production-ready \
  --team-size 3
```

After ~30 minutes to several hours (depending on complexity and team size), you'll have a complete, working application.

## Contributing

This system is designed to be extended:

- Add new specialized agents for domain-specific tasks (ML engineer, DevOps, DBA)
- Tune agent behavior for your organization's standards
- Add industry-specific compliance checks
- Create templates for common project types
- Integrate with your internal tools and services

## License

MIT - Use freely. You are responsible for actions of agents you spawn.

## Disclaimer

Autonomous systems can and will make mistakes. Always review output before deploying to production. Use appropriate quality bar for your risk tolerance. You are responsible for all actions performed by agents.
