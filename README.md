## This module build following resources
1. VPC
2. Public and Private Subnets
3. VPC endpoint for S3
4. Internet Gateway
5. NAT Gateway
6. Route tables for Private and Public subnets
7. Security groups for Public and Private instances
7. A load balancer in front of web server.
8. Target groups regarding the load balancer
9. An EC2 instance for web server in public subnet and an application server in private subnet.
10. Two S3 Buckets.

### Building using Terraform
To build the infrastucture, run terraform file as:
    terraform apply -var-file = "./tfvars/dev.tfvars"
        or
    terraform apply -var-file = "./tfvars/prod.tfvars"

### TFVars
Pass the variable in tfvars according to the environment. For variables in Dev environment, pass the related variables on dev.tfvars file and accordingly.

### Backend
This module configures a remote S3 bucket for storing terraform state files. Configure the remote S3 bucket on variables.tf file.
