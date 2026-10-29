# Enterprise Cloud Infrastructure & DevOps Automation

A hands-on Cloud Computing and DevOps project demonstrating containerization, Kubernetes orchestration, Infrastructure as Code (IaC), automated CI validation, monitoring, and recovery procedures using free-first tools.

## Project Overview

This project demonstrates how an application can be containerized with Docker, deployed to Kubernetes, and monitored using Prometheus, Blackbox Exporter, and Grafana.

The project uses Minikube in GitHub Codespaces to simulate cloud-native infrastructure workflows without requiring paid cloud resources.

**Environment:** Local Kubernetes lab
**Deployment:** Minikube
**Application replicas:** 2
**CI:** GitHub Actions
**Infrastructure automation:** Terraform with the Kubernetes provider

## Architecture

```text
                 GitHub Repository
                        |
                 GitHub Actions
             Terraform Validation
                 Docker Build
                        |
                  Docker Image
                        |
                 Kubernetes
                   Minikube
                        |
             Enterprise Application
                (2 Replicas)
                        |
                ClusterIP Service
                        |
                 Blackbox Exporter
                        |
                    Prometheus
                        |
                     Grafana
```

The Blackbox Exporter probes the application endpoint. Prometheus scrapes the exporter metrics, and Grafana queries Prometheus to visualize monitoring data.

## Technologies Used

- **Docker:** Application containerization and image building.
- **Kubernetes:** Application orchestration and deployment.
- **Minikube:** Local Kubernetes cluster.
- **Terraform:** Infrastructure configuration using the Kubernetes provider.
- **GitHub Actions:** Automated Terraform validation and Docker image build.
- **Prometheus:** Metrics collection.
- **Blackbox Exporter:** HTTP endpoint availability monitoring.
- **Grafana:** Monitoring dashboards and visualization.
- **Git and GitHub:** Version control and source hosting.
- **YAML and Bash:** Infrastructure manifests and recovery automation.

## Key Features

- Kubernetes deployment with two application replicas.
- ClusterIP Service for internal application access.
- Separate application and monitoring namespaces.
- Docker health check and non-root container execution.
- Kubernetes resource requests and limits.
- Prometheus HTTP availability probing through Blackbox Exporter.
- Grafana dashboard for monitoring metrics.
- Terraform-managed Kubernetes ConfigMap.
- Kubernetes backup manifests and a recovery script.
- GitHub Actions workflow for Terraform validation and Docker image building.
- Free-first implementation designed to avoid unnecessary cloud charges.

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   └── index.html
├── docs/
│   └── architecture/
│       └── project-overview.md
├── k8s/
│   ├── deployment.yaml
│   ├── monitoring.yaml
│   └── namespace.yaml
├── screenshots/
├── scripts/
│   └── restore-kubernetes-backup.sh
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── backups/
├── Dockerfile
├── prometheus.yml
├── requirements.txt
└── README.md
```

## Validation and Testing

The following checks were performed in the local environment:

- Verified that the Minikube node reached the Ready state.
- Confirmed that both application replicas were running and ready.
- Verified that Prometheus, Grafana, and Blackbox Exporter were running.
- Confirmed a successful HTTP probe with `probe_success = 1`.
- Verified that the application endpoint returned HTTP 200.
- Built and ran the Docker image and confirmed that its health check passed.
- Applied the Terraform configuration to create a Kubernetes ConfigMap.
- Ran Terraform validation and confirmed that a subsequent plan reported no changes.
- Validated the Kubernetes backup and recovery manifests with dry-run checks.
- Validated the recovery script syntax.
- Confirmed that the GitHub Actions workflow successfully validated Terraform and built the Docker image.

The recovery procedure has been validated, but a complete recovery drill has not yet been performed.

### Example Prometheus Query

```promql
probe_success{job="blackbox-app"}
```

A value of `1` indicates a successful probe at the time of observation.

## Screenshots

The repository includes screenshots documenting the Kubernetes deployment and monitoring setup.

| Screenshot | Description |
|---|---|
| `kubernetes-running-pods.png` | Application and monitoring pods |
| `prometheus-probe-success.png` | Successful HTTP availability probe |
| `grafana-monitoring-dashboard.png` | Monitoring dashboard |
| `grafana-probe-query.png` | Grafana probe metric query |

## How to Run Locally

### Prerequisites

- Docker
- Minikube
- kubectl
- Terraform, for the IaC section

### Start Minikube

```bash
minikube start
kubectl get nodes
```

### Deploy the application

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl get pods -n enterprise-dev
```

### Configure monitoring

Review `k8s/monitoring.yaml` and `prometheus.yml` before applying resources. Apply Kubernetes manifests according to their resource definitions; `prometheus.yml` is a Prometheus configuration file, not necessarily a Kubernetes manifest.

### Validate Terraform

From the repository root:

```bash
terraform -chdir=terraform init
terraform -chdir=terraform validate
terraform -chdir=terraform plan
```

The Terraform provider requires access to a compatible Kubernetes cluster and a valid kubeconfig.

### Run the recovery procedure

From the repository root, after ensuring the intended cluster is active:

```bash
bash scripts/restore-kubernetes-backup.sh
```

**Warning:** The recovery script applies Kubernetes resources. Review the backup file and confirm the target cluster before running it.

## Project Scope and Limitations

This is an educational local Kubernetes project. It does not provision production infrastructure on AWS, Azure, or GCP.

The GitHub Actions workflow validates Terraform and builds a Docker image; it does not yet publish the image to a registry or automatically deploy it to a cluster.

The project does not claim production-scale availability, a completed disaster-recovery drill, or a production security audit.

## Future Improvements

- Add automated deployment to a suitable Kubernetes environment.
- Publish versioned container images to a registry.
- Explore cloud deployment when appropriate free-tier resources are available.
- Add alerting rules and notification channels.
- Expand automated application tests.
- Perform and document an end-to-end recovery drill.
- Improve secrets management and production security controls.

## Author

**Sapna Ahamed**
B.E. Computer Science and Engineering | 2027 Graduate

Interested in Cloud Engineering, DevOps, Kubernetes, and Infrastructure as Code.
