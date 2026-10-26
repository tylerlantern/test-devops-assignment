# Architecture

## AWS

| Component | Resource | Why |
|---|---|---|
| Network | VPC with 2 public subnets in 2 AZs | Simple, and the ALB needs public subnets |
| Cluster | EKS 1.33 with one managed node group (t3.medium, 1–3 nodes) | Managed control plane, less to operate |
| Registry | ECR repository `hello-next` | Private registry close to the cluster |
| Logs | S3 bucket `hello-next-logs`, 30-day expiry | Cheap long-term storage for app logs |

The nodes have S3 access so the application can write logs to the bucket.

## Delivery

CI (GitHub Actions) builds and pushes the image tagged with the commit SHA, then commits the new tag
into `k8s/deployment.yaml`. Argo CD watches `k8s/` and syncs automatically.

To roll back, revert the deploy commit in Git.

## Kubernetes

Two replicas behind a Service, exposed through an ALB Ingress (AWS Load Balancer Controller).
The liveness probe calls `/api/health`.
