SHELL := /bin/bash
.DEFAULT_GOAL := usage

RED        := \033[0;31m
GREEN      := \033[0;32m
CYAN       := \033[0;36m
YELLOW     := \033[1;33m
NC         := \033[0m # No Colour

usage:
	@printf "\n\n$(YELLOW)Usage:$(NC)\n\n"
	@printf "$(GREEN)DEVELOPMENT$(NC)\n"
	@printf "$(GREEN)==================================================================$(NC)\n"
	@printf "$(YELLOW)make virtual-env    $(GREEN)# Install python modules in Virtual Environment\n"
	@printf "\n\n"
	@printf "$(GREEN)TESTING$(NC)\n"
	@printf "$(GREEN)==================================================================$(NC)\n"
	@printf "$(YELLOW)make check-syntax   $(GREEN)# Run syntax-check for this project\n"
	@printf "$(YELLOW)make lint           $(GREEN)# Run ansible-lint for this project\n"
	@printf "\n\n"
	@printf "$(GREEN)DEPLOYMENTS $(NC)\n"
	@printf "$(GREEN)==================================================================$(NC)\n"
	@printf "$(YELLOW)make vpc            $(GREEN)# Provision VPC Resources with InternetGateway $(NC)\n"
	@printf "$(YELLOW)make s3             $(GREEN)# Provision S3 Bucket Resource used by Application $(NC)\n"
	@printf "$(YELLOW)make load-balancer  $(GREEN)# Provision Application LoadBalancer $(NC)\n"
	@printf "$(YELLOW)make auto-scaling   $(GREEN)# Provision AutoScalingGroup $(NC)\n"
	@printf "$(YELLOW)make rds-postgresql $(GREEN)# Provision RDS PostgresQL $(NC)\n"
	@printf "$(YELLOW)make all            $(GREEN)# Provision all Resources\n"
	@printf "\n\n"

virtual-env:
		virtualenv --python=/usr/bin/python venv; \
    source venv/bin/activate; \
		pip install -r requirements.txt;

check-syntax:
	source venv/bin/activate; \
	ansible-playbook -i inventory/local --syntax-check playbook-all.yml --check -vvv;
	@printf "\n$(CYAN)check-syntax Successful!\n\n"

lint:
	source venv/bin/activate; \
	ansible-lint -x 701 playbook-all.yml;
	@printf "\n$(CYAN)Lint Successful!\n\n"

vpc:
	source venv/bin/activate; \
	ansible-playbook -i inventory/local playbook-vpc.yml -vvv;

s3:
	source venv/bin/activate; \
  ansible-playbook -i inventory/local playbook-s3.yml -vvv;

load-balancer:
	source venv/bin/activate; \
	ansible-playbook -i inventory/local playbook-load-balancer.yml -vvv;

auto-scaling:
	source venv/bin/activate; \
	ansible-playbook -i inventory/local playbook-auto-scaling-group.yml -vvv;

rds-postgresql:
	source venv/bin/activate; \
	ansible-playbook -i inventory/local playbook-rds-postgresql.yml -vvv;

all:
	source venv/bin/activate; \
	ansible-playbook -i inventory/local playbook-all.yml -vvv;
