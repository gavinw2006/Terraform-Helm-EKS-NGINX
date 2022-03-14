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

resource "helm_release" "NGINX-Plus" {
  name       = "NGINX-Plus"
  repository = "https://reg.foobz.com.au/chartrepo/cnf"
  chart      = "nginx-plus"

#  values = [
#    "${file("jenkins-values.yaml")}"
#  ]

  set_sensitive {
    name  = "controller.adminUser"
    value = "admin"
  }
  set_sensitive {
    name = "controller.adminPassword"
    value = "Pa55w0rd!"
  }
  set_sensitive {
    name = "adminPassword"
    value = "Pa55w0rd!"
  }
}
