#!/usr/bin/env bash
set -euo pipefail

BACKUP_FILE="terraform/backups/enterprise-dev-recovery.yaml"
NAMESPACE="enterprise-dev"

if [[ ! -f "$BACKUP_FILE" ]]; then
  echo "ERROR: Backup file not found: $BACKUP_FILE" >&2
  exit 1
fi

echo "Validating backup without changing resources..."
kubectl apply --dry-run=server -f "$BACKUP_FILE"

echo "Applying recovery configuration..."
kubectl apply -f "$BACKUP_FILE"

echo "Waiting for application rollout..."
kubectl rollout status deployment/enterprise-cloud-app \
  -n "$NAMESPACE" --timeout=120s

echo "Recovery completed."
kubectl get deployment,service,configmap -n "$NAMESPACE"
