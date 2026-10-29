
# Enterprise Cloud Infrastructure & DevOps Automation

**Project Report**

**Author:** Sapna Ahamed  
**Degree:** B.E. Computer Science and Engineering  
**Graduation Year:** 2027  
**Repository:** https://github.com/sapnaahamed23-hub/cognevance_enterprise-cloud-infrastructure-devops

---

## 1. Abstract

This project demonstrates core Cloud Computing and DevOps practices through application containerization, Kubernetes orchestration, infrastructure configuration using Terraform, automated validation with GitHub Actions, and application availability monitoring using Prometheus, Blackbox Exporter, and Grafana.

The implementation uses Docker and a local Minikube Kubernetes cluster in GitHub Codespaces. This free-first approach provides a practical environment for exploring cloud-native deployment and monitoring workflows without requiring paid public cloud resources.

## 2. Objectives

The primary objectives are:

- Containerize an application using Docker.
- Deploy and manage application replicas using Kubernetes.
- Configure infrastructure resources using Terraform.
- Automate configuration validation and image building with GitHub Actions.
- Monitor application endpoint availability.
- Visualize monitoring metrics using Grafana.
- Apply container security practices.
- Prepare Kubernetes backup manifests and a recovery procedure.
- Document the architecture, validation results, and limitations.

## 3. Technologies Used

| Technology | Purpose |
|---|---|
| Docker | Containerization and image building |
| Kubernetes | Application orchestration |
| Minikube | Local Kubernetes environment |
| Terraform | Infrastructure configuration |
| GitHub Actions | Continuous integration |
| Prometheus | Metrics collection |
| Blackbox Exporter | HTTP availability probing |
| Grafana | Monitoring visualization |
| Git and GitHub | Version control and collaboration |
| YAML and Bash | Resource configuration and recovery automation |

## 4. System Architecture

The application is deployed as two replicas in the `enterprise-dev` namespace and exposed through a Kubernetes ClusterIP Service.

The monitoring components run in a separate `monitoring` namespace. Blackbox Exporter probes the application endpoint, Prometheus collects exporter metrics, and Grafana queries Prometheus to display monitoring information.

GitHub Actions validates the Terraform configuration and builds the Docker image. Terraform manages a Kubernetes ConfigMap containing project metadata.

The architecture diagram is available at `docs/architecture/architecture-diagram.mmd`.

## 5. Implementation

### 5.1 Application Containerization

A Docker image was created using `python:3.12-slim`. The application is served using Python's built-in HTTP server.

The container configuration includes a non-root application user, a health check, and port 8000. The image was built and tested in the development environment, and the test container reported a healthy status.

### 5.2 Kubernetes Deployment

The application was deployed to Minikube using Kubernetes manifests.

The deployment uses two replicas, a ClusterIP Service, and resource requests and limits. The application and monitoring components use separate namespaces.

Both application replicas were verified as running and ready during testing.

### 5.3 Infrastructure as Code

Terraform was configured with the Kubernetes provider to manage a ConfigMap named `terraform-project-info` in the `enterprise-dev` namespace.

Terraform initialization and validation completed successfully. After applying the configuration, a subsequent Terraform plan reported no changes, indicating that the managed resource matched the declared configuration at that time.

This implementation manages a Kubernetes resource; it does not provision an entire public cloud environment.

### 5.4 Continuous Integration

A GitHub Actions workflow was configured to run on pushes and pull requests targeting the `main` branch.

The workflow checks for required files, initializes Terraform, validates the Terraform configuration, and builds the Docker image.

The workflow completed successfully during testing. It does not currently publish the image to a registry or automatically deploy the application.

### 5.5 Monitoring and Visualization

Prometheus, Blackbox Exporter, and Grafana were configured in the local Kubernetes environment.

Blackbox Exporter checks HTTP endpoint availability. Prometheus collects the probe metrics, and Grafana provides a dashboard for visualization.

The following Prometheus query was used to inspect probe success:

```promql
probe_success{job="blackbox-app"}
```

A value of `1` was observed during verification, and the monitored endpoint returned HTTP status 200 at the time of testing.

### 5.6 Security

The container and Kubernetes configuration incorporate several baseline security controls:

- Run the application as a non-root user.
- Disable privilege escalation.
- Drop unnecessary Linux capabilities.
- Use the `RuntimeDefault` seccomp profile.
- Define CPU and memory requests and limits.
- Configure a container health check.

These controls demonstrate basic hardening practices but do not constitute a complete production security audit.

### 5.7 Backup and Recovery

Kubernetes backup manifests were created under `terraform/backups/`. A recovery script, `scripts/restore-kubernetes-backup.sh`, validates the recovery manifest before applying it and checks the application rollout afterward.

The recovery script passed syntax validation, and manifest dry-run checks passed. A complete end-to-end disaster-recovery drill has not yet been performed.

## 6. Testing and Validation

The following checks were performed:

| Test | Result |
|---|---|
| Minikube node readiness | Passed |
| Application replica readiness | Passed |
| Monitoring pod readiness | Passed |
| HTTP availability probe | Passed during testing |
| Prometheus probe metric | `probe_success = 1` observed |
| Application HTTP response | Status 200 observed |
| Docker image build | Passed |
| Docker container health check | Healthy during testing |
| Terraform validation | Passed |
| Terraform plan after apply | No changes reported |
| Backup manifest dry-run validation | Passed |
| Recovery script syntax check | Passed |
| GitHub Actions CI workflow | Passed |

Results reflect the development environment and test times; they do not guarantee continuous or production availability.

## 7. Limitations

- The project runs on a local Minikube cluster rather than AWS, Azure, or GCP.
- Terraform manages a Kubernetes ConfigMap rather than complete cloud infrastructure.
- The CI workflow validates configuration and builds the image but does not publish or deploy it.
- The recovery process has not been tested through a complete disaster-recovery exercise.
- Production-scale load testing, external alerting, and a comprehensive security audit remain outside the completed implementation.

## 8. Future Enhancements

- Add automated deployment to a suitable Kubernetes environment.
- Publish versioned Docker images to a container registry.
- Add application-level automated tests.
- Configure monitoring alerts and notifications.
- Perform and document an end-to-end recovery drill.
- Explore public cloud deployment after reviewing free-tier limits and potential costs.
- Expand security testing and operational documentation.

## 9. Conclusion

The project demonstrates a practical local implementation of core Cloud Computing and DevOps concepts. It combines Docker containerization, Kubernetes orchestration, Terraform-based resource management, GitHub Actions continuous integration, monitoring with Prometheus and Grafana, and backup and recovery preparation.

The implementation provides a foundation for future work on automated deployment, public cloud infrastructure, and production-oriented reliability practices.

## 10. Project Repository

Source code, configuration files, architecture documentation, monitoring evidence, and recovery scripts are maintained in the GitHub repository:

https://github.com/sapnaahamed23-hub/cognevance_enterprise-cloud-infrastructure-devops
