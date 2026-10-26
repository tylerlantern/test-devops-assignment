# hello-next — DevOps Technical Challenge

A Next.js "Hello World" service with a BFF health endpoint, running on AWS EKS and deployed with Argo CD.

## Prerequisites

- Docker and Docker Compose
- Node.js 22
- Terraform >= 1.6 and AWS credentials
- kubectl

## Run locally

```bash
cp .env.example .env
docker compose up --build
```

Open http://localhost:3000. The health check is at http://localhost:3000/api/health.

## Deploy

1. Create the infrastructure:
   ```bash
   cd infra
   terraform init
   terraform apply
   ```
2. Install Argo CD and the application:
   ```bash
   aws eks update-kubeconfig --name hello-next
   kubectl apply -k argocd/
   ```
3. Push to `main`. GitHub Actions builds the image, pushes it to ECR and updates `k8s/deployment.yaml`. Argo CD syncs the change.

## Architecture

```
GitHub ── push ──> GitHub Actions ──> ECR
                        │
                        └─ commit image tag ──> k8s/ ──> Argo CD ──> EKS ──> ALB ──> users
```

See ARCHITECTURE.md for details.
