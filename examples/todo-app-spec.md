# Project: Enterprise Todo Management API

## Overview

Build a complete, production-ready todo management application with:
- **Backend**: RESTful API with user authentication, CRUD operations, team collaboration
- **Database**: PostgreSQL with proper schema, indexes, and migrations
- **Frontend**: React single-page application with TypeScript
- **DevOps**: Docker containerization, CI/CD pipeline, monitoring

Target Users: Small to medium teams needing collaborative task management.

## Functional Requirements

### User Management
- [ ] User registration with email verification
- [ ] Login/logout with JWT tokens
- [ ] Password reset flow
- [ ] Profile management (name, avatar, preferences)
- [ ] Role-based access control (admin, member, viewer)

### Authentication & Authorization
- [ ] OAuth 2.0 with OIDC (Google, GitHub)
- [ ] Session management with refresh tokens
- [ ] Password strength validation
- [ ] Rate limiting on auth endpoints (5 attempts per 5 minutes)
- [ ] Audit log for auth events

### Todo CRUD
- [ ] Create todo with title, description, due date, priority (low/med/high), tags
- [ ] Read todo with full details and comments
- [ ] Update todo (all fields except created timestamps)
- [ ] Delete todo (soft delete, 30-day recovery)
- [ ] List todos with pagination (20 per page), sorting, filtering
- [ ] Search todos by title, description, tags

### Collaboration
- [ ] Team workspaces (up to 50 users per workspace)
- [ ] Assign todos to team members
- [ ] Comments on todos with @mentions
- [ ] Activity feed showing changes
- [ ] Permissions: creator can edit/delete, assignee can update status, viewers read-only
- [ ] Invite members via email, accept/decline workflow

### Advanced Features
- [ ] Recurring todos (daily, weekly, monthly)
- [ ] Todo templates for common patterns
- [ ] Bulk operations (assign, complete, delete)
- [ ] File attachments (images, PDFs) up to 10MB each
- [ ] Email notifications for assignments and mentions
- [ ] Webhook support for integrations
- [ ] Export todos as CSV/JSON
- [ ] Import todos from CSV

### Non-Functional Requirements

#### Performance
- API response P95 < 200ms for simple queries
- API response P95 < 500ms for complex queries with joins
- Support 1000 concurrent users
- Database query response < 100ms (indexed queries)
- Page load < 2s on 3G connection

#### Security
- All data encrypted at rest (AES-256)
- All communications TLS 1.3+
- OWASP Top 10 protections (injection, XSS, CSRF, etc.)
- Annual penetration testing required
- Secrets in KMS, never in source code
- Security headers (HSTS, CSP, X-Frame-Options)
- GDPR compliance (data export/delete)

#### Reliability
- 99.9% uptime (8h 45m downtime/year max)
- Zero data loss (WAL archiving, point-in-time recovery)
- Automated backups daily, 30-day retention
- Graceful degradation (read-only mode if DB issues)
- Health check endpoints for load balancer
- Circuit breakers for external dependencies

#### Scalability
- Horizontal scaling of API servers behind load balancer
- Database connection pool max 100 connections
- Caching layer (Redis) for session data and hot queries
- Queue (RabbitMQ or SQS) for async tasks (email, notifications)
- CDN for static assets (images, JS bundles)

#### Maintainability
- API versioning (v1, v2 with backward compatibility for 1 year)
- Comprehensive documentation (OpenAPI/Swagger)
- >80% unit test coverage
- >60% integration test coverage
- All tests passing on every PR
- Code review required for all changes
- Static analysis in CI (SonarQube quality gate)

#### Observability
- Structured JSON logging (ELK stack)
- Metrics: response times, error rates, throughput (Prometheus + Grafana)
- Distributed tracing (Jaeger)
- Alerting on:
  - Error rate > 1%
  - P95 latency > 500ms
  - Disk usage > 80%
  - Failed login attempts > 100/min

## Constraints

- **Language**: Backend: TypeScript with Node.js (Express or Fastify). Frontend: TypeScript with React
- **Database**: PostgreSQL 15+ on RDS or self-hosted
- **Authentication**: JWT with refresh tokens, optional OIDC
- **Infrastructure**: Docker containers, preferably deployable to Kubernetes or ECS
- **Compliance**: GDPR (EU users), no data residency requirements yet
- **Budget**: Standard t3.medium instances acceptable for MVP; must scale economically
- **Timeline**: 4-6 weeks for MVP, 8-12 for full feature set
- **Team**: 3-5 AI agents with one experienced DevOps advisor (call researcher for best practices)

## Success Criteria

- [ ] All functional requirements implemented and tested
- [ ] Load test: 1000 concurrent users completing typical workflows
- [ ] Security audit: zero critical or high vulnerabilities
- [ ] Uptime: 99.9% achieved in 30-day observation period
- [ ] Documentation complete: API docs, deployment guide, ops runbook
- [ ] Code quality: SonarQube quality gate passed, no code smells
- [ ] User acceptance testing: demo to stakeholders with positive feedback

## In Scope

MVP features:
- User registration, login, JWT auth
- Todo CRUD with basic filtering
- Team workspaces and member management
- Comments and notifications
- Docker deployment with PostgreSQL
- Basic monitoring and logging

Phase 2 (if time permits):
- Recurring todos
- File attachments
- Advanced sharing and permissions
- Webhooks
- Export/import

## Out of Scope

- Mobile native apps (responsive web app only)
- Real-time collaboration (no WebSocket live editing)
- Advanced analytics dashboard
- Multi-language/i18n
- SMS notifications
- Billing/subscription management (assume internal tool, not monetized yet)
- SSO with SAML (OIDC sufficient)

## Technical Questions for Researcher

Please research and provide answers to:

1. JWT implementation best practices in 2025 (token lifetimes, refresh strategies, revocation)
2. PostgreSQL schema design for hierarchical todos (parent-child) and efficient filtering
3. React state management approaches (Redux Toolkit, Zustand, React Query, Context)
4. File upload implementation with S3 pre-signed URLs vs multipart to app server
5. Email notification service options (SendGrid, AWS SES, Postmark) and deliverability
6. Rate limiting implementation at API layer (express-rate-limit vs nginx vs cloud provider)
7. Distributed tracing setup with OpenTelemetry in Node.js
8. Kubernetes deployment best practices (resource limits, probes, config management)
9. Database migration strategy (flyway, knex, sequelize-cli, raw SQL)
10. Testing pyramid proportions for this project, recommended frameworks

## Notes for Architects

- Keep it simple: monolithic or modular monolith initially; microservices only if justified by scale
- Prefer proven, mainstream technologies over cutting edge
- Developer experience matters: hot reload, good error messages, helpful logs
- Security from start, not bolt-on later
- Containerize everything; infrastructure as code
- Observability from day one (logs, metrics, traces)
- Prepare for horizontal scaling but optimize for MVP simplicity first
