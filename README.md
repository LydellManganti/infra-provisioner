# Project Infrastructure Provisioner
This project provisions an AWS infrastructure that accepts traffic from the internet (which are whitelisted), routes to an Application Load Balancer, which is attached to an AutoScalingGroup.
The EC2 instance will hold the service that has permission to get and put object to an S3 Bucket. The EC2 instance will have permission to read and push data to RDS PostgreSQL.

# Pre-requisites to run this installer

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
  - Subnet
  - Route Table

LoadBalancer
  - ApplicationLoadBalancer
  - TargetGroups

EC2
  - AutoScalingGroup
  - EC2 Instance

RDS
  - PostgreSQL

# Makefile
## Lint
## Test
## make provision-vpc
## make provision-alb
## make provision-asg
## make provision-s3
## make provision-rds
## make provision-r53

# Design Decisions
Route 53 - This service is chosen to allow traffic

# High Availability Design
- R53
- AppliationLoadBalancer
- AutoScalingGroup
- RDS Multi AZ

# Security Decisions Implemented as part of automation
- CloudTrail
- Network ACL for Subnets
- RDS Encryption
- S3 Encryption using AES 256
- Security Groups
- VPC AccessLogs

# Security Not part of Automation due to dependency with AWS
- Certificate TLS security
