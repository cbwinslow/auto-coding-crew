---
name: autonomous-coding-crew
kind: program
services: [orchestrator, architect, researcher, implementer, reviewer, tester, security-expert, debugger, validator, synthesizer]
---

requires:
- project-spec: a detailed specification of the application/website/project to build (features, tech-stack, constraints, success-criteria)
- quality-bar: the minimum quality standard (e.g., "production-ready", "prototype", "high-assurance")
- team-size: number of implementers to run in parallel (default: 3)
- max-iterations: maximum refinement cycles to prevent infinite loops (default: 10)

ensures:
- complete-project: a fully functional, tested, documented, and production-ready application
- architecture-docs: system design documents, API specs, and component diagrams
- test-suite: comprehensive unit, integration, and E2E tests with coverage report
- security-audit: security review report with all critical issues resolved
- deployment-guide: instructions for deploying and operating the system
- knowledge-base: lessons learned, decisions made, and rationale captured

strategies:
- when architecture is ambiguous: architect synthesizes multiple proposals and orchestrator selects via team voting
- when implementation issues arise: debugger analyzes, proposes fixes, implementer retries (loop max 5)
- when security vulnerabilities found: security-expert prioritizes, implementer fixes, validator re-checks
- when tests fail repeatedly: tester diagnoses, debugger finds root cause, implementer fixes
- when quality bar not met: orchestrator increases iteration depth or team collaboration
- when disagreements occur: synthesizer facilitates structured debate and votes
- when task drift detected: orchestrator re-anchors to original spec and validates alignment
- when hallucinations detected: validator flags, researcher fact-checks, team revises
- when external research needed: orchestrator delegates to researcher with clear questions

---
# Execution

# Phase 0: Project initialization and team formation
let team-charter = call orchestrator
  task: "form team, understand spec, create project charter"
  project-spec: project-spec
  quality-bar: quality-bar
  team-size: team-size

let research-questions = call orchestrator
  task: "identify knowledge gaps requiring external research"
  team-charter: team-charter

let research-findings = call researcher
  task: "conduct targeted research on technologies, patterns, and dependencies"
  questions: research-questions
  depth: "comprehensive"

let enriched-spec = call synthesizer
  task: "merge team-charter and research into actionable specification"
  team-charter: team-charter
  research: research-findings

# Phase 1: Architecture and design (with validation voting)
parallel:
  architecture = call architect
    task: "design complete system architecture"
    spec: enriched-spec
    constraints: team-charter.constraints

  security-architecture = call security-expert
    task: "design security architecture and threat model"
    spec: enriched-spec
    architecture-input: architecture

let validated-architecture = call validator
  task: "validate architecture for feasibility, completeness, and alignment"
  architecture: architecture
  security-design: security-architecture
  spec: enriched-spec

if architecture-revisions-needed:
  let revised-architecture = call architect
    task: "revise architecture based on validation feedback"
    current: architecture
    feedback: validated-architecture.feedback

  let revised-security = call security-expert
    task: "update security architecture to align with revisions"
    current: security-architecture
    architecture-revisions: revised-architecture

  let re-validated = call validator
    task: "re-validate revised architecture"
    architecture: revised-architecture
    security-design: revised-security

  let architecture = revised-architecture
  let security-architecture = revised-security

call orchestrator
  task: "approve final architecture and decomposition into components"
  architecture: architecture
  security-design: security-architecture
  validation: re-validated or validated-architecture

# Phase 2: Parallel component implementation with cross-validation
let components = architecture.component-list
let num-teams = team-size

# Distribute components across parallel implementer teams
parallel for component in components (max-parallel: team-size):
  let implementation-team = distribute-component component across implementers
  
  let code = call implementation-team
    task: "implement component according to spec"
    component: component
    architecture: architecture
    security-guidelines: security-architecture
  
  let unit-tests = call tester
    task: "write comprehensive unit tests for this component"
    component: component
    implementation: code
  
  let integration-tests = call tester
    task: "write integration tests for component interactions"
    component: component
    architecture: architecture
    test-scope: "component-integration"
  
  let code-review = call reviewer
    task: "conduct thorough code review"
    code: code
    tests: { unit-tests, integration-tests }
    style-guide: architecture.coding-standards
  
  let security-review = call security-expert
    task: "review implementation for security vulnerabilities"
    code: code
    threat-model: security-architecture
    component: component

# Phase 3: Continuous integration and issue resolution
let all-reviews = collect { code-review, security-review } for all components

loop until all reviews pass or max-iterations reached (max: max-iterations):
  let failed-reviews = filter all-reviews where verdict != "PASS"
  
  if no failed-reviews:
    break loop
  
  let prioritized-issues = call orchestrator
    task: "prioritize and batch review issues by severity and dependency"
    failed-reviews: failed-reviews
  
  parallel for issue-batch in prioritized-issues.batches:
    let fix-result = call debugger
      task: "diagnose root cause and propose fix"
      issue: issue-batch
      code: get-current-code(issue-batch.component)
    
    let revised-code = call implementer
      task: "implement fix according to debugger's plan"
      component: issue-batch.component
      fix-plan: fix-result
    
    call orchestrator
      task: "validate fix addresses issue"
      fix-result: fix-result
      revised-code: revised-code

# Phase 4: Integration testing and system validation
let integrated-system = call implementer
  task: "integrate all components and wire dependencies"
  components: all-components
  architecture: architecture

let system-tests = call tester
  task: "execute full system E2E test suite"
  system: integrated-system
  test-plan: architecture.test-plan
  success-criteria: enriched-spec.success-criteria

let security-audit = call security-expert
  task: "conduct full security audit on integrated system"
  system: integrated-system
  threat-model: security-architecture

let performance-benchmarks = call tester
  task: "run performance benchmarks and load tests"
  system: integrated-system
  performance-requirements: enriched-spec.performance-requirements

# Phase 5: Final validation, documentation, and handoff
let final-validation = call validator
  task: "conduct final comprehensive validation"
  system: integrated-system
  tests: system-tests
  security: security-audit
  performance: performance-benchmarks
  quality-bar: quality-bar
  spec: enriched-spec

if validation-issues:
  let issues-addressed = call debugger
    task: "resolve final validation issues"
    issues: final-validation.issues
    system: integrated-system
  
  let final-validation = re-run-validation after fixes

let documentation = call orchestrator
  task: "coordinate documentation generation"
  architecture: architecture
  code: integrated-system
  tests: system-tests
  security: security-audit

let deployment-guide = call orchestrator
  task: "create deployment and operations guide"
  system: integrated-system
  architecture: architecture
  infrastructure: enriched-spec.infrastructure

let knowledge-base = call synthesizer
  task: "capture lessons learned, decisions, and rationale"
  project-charter: team-charter
  architecture: architecture
  revisions: all-revisions-throughout-project
  final-validation: final-validation

# Phase 6: Final deliverable packaging
let complete-project = call synthesizer
  task: "assemble final deliverable package"
  system: integrated-system
  documentation: documentation
  deployment: deployment-guide
  validation: final-validation
  knowledge: knowledge-base
  security-audit: security-audit
  quality-certification: final-validation.quality-certification

return complete-project
