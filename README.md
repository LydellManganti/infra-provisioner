# Project Infrastructure Provisioner
This project provisions an AWS infrastructure that accepts traffic from the internet (which are whitelisted), routes to an Application Load Balancer, which is attached to an AutoScalingGroup.
The EC2 instance will hold the service that has permission to get and put object to an S3 Bucket. The EC2 instance will have permission to read and push data to RDS PostgreSQL.

# Quick Start
Run `make` at the base folder. This will display Makefile targets that can be executed.


# Machine Setup
## Tools
### Python 2.7
### VirtualEnv
- Ansible
- Boto3
- BotoCore
### Makefile

## Domain Name

# Resources
R53
  - RecordSet

VPC
  - Internet Gateway
  - S3 Endpoint
  - Public Subnet for Application
  - Private Subnet for RDS to block external access
  - Route Table

LoadBalancer
  - ApplicationLoadBalancer
  - TargetGroups

EC2
  - AutoScalingGroup
  - EC2 Instance
  - IAM Role for Instance Profile

RDS
  - PostgreSQL

# Design Decisions
- S3 Endpoint
- Public/Private Subnets
- VPC Flowlogs
- S3 AccessLogs
- S3 Encryption
- RDS Encryption
- SecurityGroup - Least privilege
- Cloudwatch
- CloudTrail
- R53

# Makefile
## make virtual-env
## make check-syntax
## make lint
## make vpc
## make load-balancer
## make auto-scaling
## make provision-s3
## make provision-rds
## make provision-r53

# Design Decisions
Route 53 - This service is chosen to allow traffic

# High Availability Design
- R53
- AppliationLoadBalancer
- AutoScalingGroup
- RDS

# Security Decisions Implemented as part of automation
- CloudTrail
- Network ACL for Subnets
- RDS Encryption
- S3 Encryption using AES 256
- Security Groups
- VPC AccessLogs

# Security Not part of Automation due to dependency with AWS
- Certificate TLS security
