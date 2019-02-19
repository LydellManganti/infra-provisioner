# Project Infrastructure Provisioner

This project provisions an AWS infrastructure that accepts traffic from the internet (which are whitelisted), routes to an Application Load Balancer and to an EC2 instance.

The EC2 instance will hold the service which has permissions to get and put objects to an S3 Bucket. The EC2 instance will also have permission to read and push data to RDS PostgreSQL.

## Pre-requisites
- `make` and `python` are installed.
- aws credentials and config are setup

# Quick Start

Run `make` at the base folder. This will display Makefile targets that can be executed.

Inline-style:
![alt text](https://github.com/LydellManganti/infra-provisioner/raw/master/assets/makefile.jpg)

### DEVELOPMENT
`make virtual-env` - This will create a virtual environment `venv` and install python modules required by this project.

### TESTING
`make check-syntax` - This will run a syntax check across Ansible playbooks/roles.
`make lint` - This will run ansible-lint across Ansible playbooks/roles.

### DEPLOYMENTS
|Command              | Description                                                                            |
| --------------------|:--------------------------------------------------------------------------------------:|
|`make vpc`           | Creates the VPC resource including Internet Gateway, Subnets, RouteTables, Network ACL.|
|`make s3`            | Creates S3 Bucket needed by the Application.                                           |
|`make load-balancer` | Creates a Load balancer in front of the Web App.                                       |
|`make auto-scaling`  | Creates Autoscaling group on 2 Availability Zones.                                     |
|`make rds-postgresql`| Creates an RDS PostgreSQL with option for Multi AZ.                                    |
|`make r53`           | Creates an alias for the load-balancer                                                 |
|`make all`           | Creates all the resources in order of dependency.                                      |

# Tools Used
The below tools are used for this project
- Ansible - Used to orchestrate resource deployment.
- Python - Used to create Ansible custom module, eg. `cloudformation_validate` that is not available out of the box.
- make - Used to simplify Ansible tasks into single command.
- Cloudformation - Used to create resources in aws. This allow drift detection and dependency of resources.

# Features
- Creates EC2 KeyPair automatically and store in SSM Parameter Store.
- Use SSM Parameter Store for Secrets (DB Password).
- Use Cloudformation to deploy/update stacks.
- Use virtualenv to isolate project dependencies.
- Ansible code best practice by using ansible-lint.

# Design Decisions
- VPC S3 Endpoint - allow S3 access within aws network.
- Public Subnets - Allow internet traffic to Web Application.
- Private Subnet - Restrict DB Access to the Web Application only, and block external access.
- AutoScalingGroup - enable high availability on Web Application.
- S3 Encryption - encrypt objects at rest.
- VPC Flowlogs - audit inbound/outbound traffic to vpc.
- S3 Accesslogs - audit S3 requests made to the bucket.
- SecurityGroup - enable least privilege to resources.
