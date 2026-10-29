# Enterprise Cloud Infrastructure & DevOps Automation

## 1. Project Objective

Demonstrate core Cloud Computing and DevOps practices through a containerized application, Kubernetes orchestration, Infrastructure as Code (IaC), CI validation, monitoring, security hardening, and backup and recovery procedures.

The project uses a local Minikube environment in GitHub Codespaces to provide a free-first implementation without requiring paid cloud resources.

## 2. Technology Stack

- **Infrastructure as Code:** Terraform with the Kubernetes provider
- **Containerization:** Docker
- **Container orchestration:** Kubernetes and Minikube
- **CI automation:** GitHub Actions
- **Monitoring:** Prometheus
- **HTTP availability checks:** Blackbox Exporter
- **Dashboards:** Grafana
- **Version control:** Git and GitHub
- **Automation:** YAML and Bash

## 3. Implemented Architecture

The application runs as two Kubernetes replicas in the `enterprise-dev` namespace and is exposed internally through a ClusterIP Service.

The monitoring stack runs in the `monitoring` namespace. Blackbox Exporter probes the application endpoint, Prometheus scrapes the exporter metrics, and Grafana queries Prometheus for visualization.

GitHub Actions validates the Terraform configuration and builds the Docker image. Terraform manages a Kubernetes ConfigMap containing project metadata.

## 4. Implementation Status

| Component | Status | Evidence |
|---|---|---|
| Docker containerization | Implemented and tested | Successful image build and healthy test container |
| Kubernetes application deployment | Implemented and tested | Two ready application replicas |
| Kubernetes Service | Implemented | Service manifest and cluster resources |
| Terraform configuration | Applied and validated | Managed ConfigMap and no-change Terraform plan |
| GitHub Actions CI | Passed | Successful workflow run |
| Prometheus monitoring | Tested | Successful HTTP probe and `probe_success = 1` |
| Grafana dashboard | Configured and tested | Dashboard and query screenshots |
| Container security | Configured | Non-root user, dropped capabilities, and health check |
| Kubernetes backup manifests | Prepared and validated | Backup YAML files and dry-run checks |
| Recovery script | Syntax and dry-run validated | `scripts/restore-kubernetes-backup.sh` |
| End-to-end disaster recovery | Not yet tested | Recovery drill remains outstanding |
| Automated deployment through CI/CD | Not implemented | Current workflow validates and builds only |
| Public cloud deployment | Not implemented | Project runs locally on Minikube |

## 5. Security and Reliability

The Docker image runs the application as a non-root user and defines a health check. The Kubernetes deployment includes resource requests and limits, non-root execution, disabled privilege escalation, dropped Linux capabilities, and the `RuntimeDefault` seccomp profile.

Backup manifests and a recovery script provide a documented recovery approach. The script validates the recovery manifest before applying it and checks the application rollout afterward. A complete recovery drill is still required to verify the procedure end to end.

## 6. CI Workflow

The GitHub Actions workflow performs the following checks:

1. Checks that required project files exist.
2. Initializes Terraform without configuring a remote backend.
3. Validates the Terraform configuration.
4. Builds the Docker image.

The workflow does not currently publish images to a container registry or deploy the application automatically.

## 7. Monitoring and Validation

Monitoring was validated in the local Minikube environment:

- Application and monitoring pods reached the Ready state.
- The application endpoint returned HTTP 200 during testing.
- Prometheus successfully scraped the Blackbox Exporter.
- The `probe_success` metric returned `1` during verification.
- Grafana displayed the probe metrics.

These results represent observations from the test environment and do not establish production availability or performance.

## 8. Backup and Recovery

The repository contains Kubernetes backup manifests under `terraform/backups/` and a recovery script at `scripts/restore-kubernetes-backup.sh`.

Manifest validation and script syntax checks passed. The recovery procedure has not yet been exercised as a complete end-to-end disaster-recovery test.

## 9. Limitations

- The environment is a local Kubernetes lab, not a production cloud deployment.
- Terraform manages a Kubernetes ConfigMap rather than provisioning a complete cloud infrastructure.
- The CI workflow builds an image but does not publish or deploy it.
- Production-scale availability, external alerting, and end-to-end disaster recovery have not been established.

## 10. Future Improvements

- Add automated deployment to a suitable Kubernetes environment.
- Publish versioned container images to a registry.
- Perform an end-to-end recovery drill and document the results.
- Add monitoring alerts and notification channels.
- Expand automated application tests.
- Explore an affordable or eligible free-tier public cloud deployment.

## 11. Deliverables

- Infrastructure configuration and Kubernetes manifests
- Dockerfile and containerized application
- Terraform configuration and variables
- GitHub Actions workflow
- Prometheus and Grafana monitoring configuration
- Kubernetes backup manifests and recovery script
- Screenshots documenting the implementation
- Architecture documentation and final project report
