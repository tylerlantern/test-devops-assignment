// BFF health check used by docker, k8s probes and Argo CD
export function GET() {
  return Response.json({ status: "ok", uptime: process.uptime() });
}
