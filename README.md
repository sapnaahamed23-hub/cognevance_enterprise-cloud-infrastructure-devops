
# Enterprise Cloud Infrastructure & DevOps Automation

A hands-on Cloud Computing and DevOps project demonstrating containerized application deployment, Kubernetes orchestration, infrastructure configuration, and application health monitoring using free-first tools.

## Project Overview

This project explores how a cloud-native application can be deployed and monitored using containerization, Kubernetes, and observability tools. It uses a local Minikube cluster to simulate key infrastructure and deployment workflows without requiring paid cloud resources.

## Architecture

```text
                 Containerized Application
                           |
                       Kubernetes
                        Minikube
                           |
                 Enterprise Application
                   (2 Running Replicas)
                           |
                  ClusterIP Service
                           |
                   Blackbox Exporter
                           |
                       Prometheus
                           |
                        Grafana
                    Monitoring Dashboard
```

## Technologies Used

- **Docker** — Application containerization
- **Kubernetes** — Application orchestration and deployment
- **Minikube** — Local Kubernetes cluster
- **kubectl** — Kubernetes resource management
- **Prometheus** — Metrics collection and monitoring
- **Blackbox Exporter** — HTTP endpoint availability probing
- **Grafana** — Monitoring dashboard and visualization
- **YAML** — Infrastructure and Kubernetes configuration
- **Git & GitHub** — Version control and project hosting
- **Terraform** — Infrastructure-as-Code learning and configuration practice

## Key Features

- Kubernetes deployment with two application replicas.
- Kubernetes Service for internal application access.
- Separate namespaces for application and monitoring resources.
- Prometheus configuration for monitoring the application endpoint.
- Blackbox Exporter HTTP probes to check endpoint availability.
- Grafana dashboard for visualizing monitoring metrics.
- Free-first local deployment approach to avoid unnecessary cloud costs.

## Project Structure

```text
.
├── Dockerfile
├── README.md
├── prometheus.yml
└── k8s/
    ├── deployment.yaml
    ├── monitoring.yaml
    └── namespace.yaml
```

## Validation and Testing

The following checks were performed in the local Minikube environment:

- Verified that the Minikube Kubernetes node was Ready.
- Confirmed that both application replicas were Running and Ready.
- Confirmed that Prometheus, Grafana, and Blackbox Exporter pods were Running and Ready.
- Verified that Prometheus successfully scraped the Blackbox Exporter probe.
- Confirmed that the `probe_success` metric returned `1`.
- Checked that the monitored application endpoint returned HTTP status `200`.
- Accessed the application, Prometheus, and Grafana through local port forwarding.

### Example Prometheus Query

```promql
probe_success{job="blackbox-app"}
```

An observed value of `1` indicates that the HTTP probe succeeded at the time of testing.

## Screenshots

Project screenshots documenting the Kubernetes deployment and monitoring setup will be added here.

| Screenshot | Description |
|---|---|
| `kubernetes-running-pods.png` | Application and monitoring pods running in Kubernetes |
| `prometheus-probe-success.png` | Successful Prometheus HTTP probe |
| `grafana-monitoring-dashboard.png` | Grafana monitoring dashboard |
| `grafana-probe-query.png` | Grafana query for the `probe_success` metric |

## How to Run Locally

### Prerequisites

- Docker
- Minikube
- kubectl

### Start the cluster

```bash
minikube start
kubectl get nodes
```

### Deploy the Kubernetes resources

Apply the namespace configuration first:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/monitoring.yaml
```

Apply the Prometheus configuration:

```bash
kubectl apply -f prometheus.yml
```

Check deployment status:

```bash
kubectl get pods -n enterprise-dev
kubectl get pods -n monitoring
kubectl get services -A
```

**Note:** The exact deployment commands may need adjustment if the YAML files define additional resources or if your local configuration differs.

## Project Scope

This is an educational, local Kubernetes project designed to demonstrate core Cloud and DevOps concepts. It does not claim production-scale availability, a public cloud deployment, or a production security audit. Terraform and other infrastructure automation components should be considered implemented only to the extent supported by the files and tests included in this repository.

## Future Improvements

- Add automated CI/CD workflows using GitHub Actions.
- Integrate Terraform validation and infrastructure planning into the workflow.
- Add alerting rules and notification channels.
- Improve secrets management and Kubernetes security.
- Explore deployment to a free-tier cloud environment when suitable.

## Author

**Sapna Ahamed**  
B.E. Computer Science and Engineering | 2027 Graduate  
Interested in Cloud Engineering, DevOps, Kubernetes, and Infrastructure Automation.

