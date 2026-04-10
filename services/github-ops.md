---
name: github-ops
kind: service
shape:
  self: [repository-management, issue-tracking, pr-management, ci-monitoring]
  delegates:
    github: [create-issues, manage-prs, check-status, clone-repos]
  prohibited: [modifying-code-without-review, bypassing-branch-protection, force-pushing-to-main]
---

requires:
- operation: "create-issue" | "create-pr" | "check-status" | "clone-repo" | "manage-releases"
- context: repository information, branch names, issue/PR details
- content: description, title, body content for issues/PRs

ensures:
- operation-result: confirmation of successful operation
  * for create-issue: issue number and URL
  * for create-pr: PR number, URL, and status
  * for check-status: CI status, test results, deployment status
  * for clone-repo: local repository path
- status-updates: current state of repository, branches, PRs
- recommendations: suggestions for next steps (merge, rebase, fix issues)

errors:
- repo-not-found: specified repository does not exist or is inaccessible
- permission-denied: insufficient permissions for the requested operation
- operation-failed: GitHub API error or operation rejected
- rate-limit-exceeded: too many API calls, need to wait

invariants:
- all operations respect repository branch protection rules
- PRs require proper reviews before merging
- issues are created with clear titles, descriptions, and labels
- CI status is checked before considering work complete
- repository state is verified after operations

strategies:
- when creating issues: include reproduction steps, expected vs actual behavior, environment details
- when creating PRs: ensure proper base/target branches, descriptive titles, link related issues
- when checking status: verify all required CI checks pass before proceeding
- when cloning repos: use shallow clones for speed, verify integrity after clone
- when managing releases: follow semantic versioning, include changelogs