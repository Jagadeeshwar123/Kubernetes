
# resource "aws_internet_gateway" "main" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "sample-internet-gateway"
#     Terraform="true"
#     Environment="DEV"
#   }
# }

# resource "aws_vpc" "main" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"
#   enable_dns_support = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "sample-vpc"
#     Terraform="true"
#     Environment="DEV"
#   }
# }

# resource "aws_subnet" "public_subnet" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "sample-public-subnet"
#     Terraform="true"
#     Environment="DEV"
#   }
# }

# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.main.id

#  route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main.id
#   }
#   tags = {
#     Name = "sample-public-rt"
#     Terraform="true"
#     Environment="DEV"
#   }
# }

# resource "aws_route_table_association" "public" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_route_table.id
# }

# resource "aws_subnet" "private_subnet" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.11.0/24"

#   tags = {
#     Name = "sample-private-subnet"
#     Terraform="true"
#     Environment="DEV"
#   }
# }

# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "sample-private-rt"
#     Terraform="true"
#     Environment="DEV"
#   }
# }

# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.private_route_table.id
# }

# resource "aws_subnet" "database_subnet" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.21.0/24"

#   tags = {
#     Name = "sample-database-subnet"
#     Terraform="true"
#     Environment="DEV"
#   }
# }

# resource "aws_route_table" "database_route_table" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "sample-database-rt"
#     Terraform="true"
#     Environment="DEV"
#   }
# }

# resource "aws_route_table_association" "database" {
#   subnet_id      = aws_subnet.database_subnet.id
#   route_table_id = aws_route_table.database_route_table.id
# }

# resource "aws_eip" "nat" {
#   domain   = "vpc"
# }

# resource "aws_nat_gateway" "gateway" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public_subnet.id

#   tags = {
#     Name = "gw NAT"
#   }
# }

# resource "aws_route" "private" {
#   route_table_id            = aws_route_table.private_route_table.id
#   destination_cidr_block    = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.gateway.id
# #   depends_on = [ aws_route_table.private ]
# }

# resource "aws_route" "database" {
#   route_table_id            = aws_route_table.database_route_table.id
#   destination_cidr_block    = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.gateway.id
# #   depends_on = [ aws_route_table.private ]
# }



module "this" {
    source = "git::https://github.com/tf-docker-k8/terraform-aws-vpc.git"
    project_name = var.project_name
    vpc_cidr=var.vpc_cidr
    vpc_tags=var.common_tags
    igw_tags=var.common_tags

    public_subnet_cidr=var.public_subnet_cidr
    public_subnet_tags=var.common_tags
    public_route_table_tags = var.common_tags
    eip_tags=var.common_tags
    nat_gateway_tags=var.common_tags

    private_subnet_cidr=var.private_subnet_cidr
    private_subnet_tags=var.common_tags
    private_route_table_tags=var.common_tags

    database_subnet_cidr=var.database_subnet_cidr
    database_subnet_tags=var.common_tags
    database_route_table_tags=var.common_tags

    db_subnet_group_tags=var.common_tags
}