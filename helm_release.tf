provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.dev-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.dev-cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.dev-cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "nginx-plus" {
  name       = "nginx-plus"
  repository = "https://reg.foobz.com.au/chartrepo/cnf"
  chart      = "nginx-plus"

  values = [
    "${file("nginx-plus-value.yaml")}"
  ]
}

resource "helm_release" "f5demo-app" {
  name       = "f5demo-app"
  repository = "https://reg.foobz.com.au/chartrepo/cnf"
  chart      = "f5demo"

  values = [
    "${file("f5demo-value.yaml")}"
  ]
}
