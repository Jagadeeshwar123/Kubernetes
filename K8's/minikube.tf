module "minikube" {
  source = "github.com/scholzj/terraform-aws-minikube"

  aws_region    = "ap-south-1"
  cluster_name  = "roboshop"
  aws_instance_type = "t2.micro"
  ssh_public_key = "C:/Users/Jagad/Downloads/terraform_connect.pub"
  aws_subnet_id = local.public_subnet_ids[0]
  hosted_zone = "jagadeeshwar.com"
  hosted_zone_private = false

  tags = {
    Application = "roboshop"
  }

  addons = [
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/storage-class.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/heapster.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/dashboard.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/external-dns.yaml"
  ]
}