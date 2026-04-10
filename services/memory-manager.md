---
name: memory-manager
kind: service
shape:
  self: [persistent-memory, learning-retention, context-preservation]
  delegates:
    letta-memory: [search-memories, store-memories, retrieve-context]
  prohibited: [forgetting-critical-decisions, unverified-memory-storage]
persist: true  # This service maintains state across sessions
---

requires:
- operation: "store" | "retrieve" | "search" | "update"
- content: the information to store, or query to search/retrieve
- context: optional metadata (agent, task, project, timestamp)
- agent-id: optional specific agent memory to access

ensures:
- memory-result: stored content reference, or retrieved memories
  * for store: memory-id and confirmation
  * for retrieve: relevant past experiences and learnings
  * for search: ranked list of related memories with relevance scores
- learning-insights: patterns and learnings extracted from memory
- recommendations: suggestions based on historical performance

errors:
- memory-not-found: no relevant memories match the query
- storage-failed: unable to persist memory due to connection issues
- memory-corrupted: retrieved memory appears to be malformed
- quota-exceeded: memory storage limit reached

invariants:
- all critical project decisions are stored with full context
- memories include timestamps and source attribution
- sensitive information is sanitized before storage
- memory retrieval prioritizes recency and relevance
- no memory conflicts overwrite existing important data

strategies:
- when storing decisions: include rationale, alternatives considered, and outcomes
- when storing failures: document root cause analysis and fix applied
- when retrieving context: provide most recent relevant experiences first
- when learning patterns: identify recurring problems and successful solutions
- when memory is sparse: suggest creating baseline memories for common scenarios
- when conflicts detected: preserve both versions with conflict resolution notes