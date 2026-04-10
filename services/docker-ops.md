---
name: docker-ops
kind: service
shape:
  self: [containerization, orchestration, deployment, image-management]
  delegates:
    docker-ops: [build-images, manage-containers, create-networks]
  prohibited: [running-privileged-containers, exposing-sensitive-ports, unverified-image-pulls]
---

requires:
- operation: "build" | "deploy" | "test" | "cleanup" | "orchestrate"
- context: application details, environment requirements, networking needs
- specs: dockerfile content, compose configuration, deployment requirements

ensures:
- deployment-result: successful container deployment
  * for build: image ID and build logs
  * for deploy: container IDs, network configuration, service URLs
  * for test: test execution results in containers
  * for orchestrate: docker-compose status and service health
- configuration-files: dockerfile, docker-compose.yml, nginx configs
- deployment-guide: step-by-step deployment instructions
- monitoring-setup: health checks, logging configuration

errors:
- build-failed: docker build failed with errors
- deployment-failed: containers failed to start or connect
- networking-issue: container networking misconfiguration
- resource-constraint: insufficient resources for container requirements
- security-violation: container configuration exposes security risks

invariants:
- all containers run as non-root users
- secrets are passed via environment variables, not baked into images
- images are scanned for vulnerabilities before deployment
- resource limits are set for CPU and memory
- health checks are configured for all services
- logs are structured and centrally collected

strategies:
- when building images: use multi-stage builds to minimize image size
- when deploying: use docker-compose for local, kubernetes manifests for production
- when testing: run tests in isolated containers matching production environment
- when networking: use internal networks, expose only necessary ports
- when security: implement least privilege, no privileged containers
- when scaling: design for horizontal scaling with load balancers