---
name: knowledge-retrieval
kind: service
shape:
  self: [semantic-search, codebase-query, pattern-discovery]
  delegates:
    cbw-rag: [vector-search, code-retrieval]
  prohibited: [direct-code-generation, unverified-information]
---

requires:
- query: the information or code pattern to search for
- context: optional context about the search (language, framework, domain)
- search-type: "code" | "documentation" | "patterns" | "examples"

ensures:
- relevant-results: top 5-10 most relevant code snippets, docs, or patterns
  * source: file path or URL with line numbers
  * relevance-score: 0.0-1.0 confidence score
  * excerpt: relevant code/doc snippet
  * explanation: why this result is relevant
- synthesis: integrated understanding of patterns across results
- recommendations: suggested approaches based on existing codebase patterns

errors:
- no-results: query returned no relevant matches
- low-confidence: all results below minimum relevance threshold
- search-timeout: query took too long to execute

invariants:
- all results include source attribution and relevance justification
- results prioritize existing codebase patterns over generic examples
- search is scoped to relevant file types (.js, .ts, .py, .md, etc.)
- no personal identifiable information or sensitive data in results

strategies:
- when searching code: include file extensions and directory patterns
- when searching patterns: use semantic similarity over exact string matching
- when no direct matches: broaden search terms, try related concepts
- when too many results: rank by recency and relevance score
- when results are outdated: note version context and check for newer patterns