SHELL := /bin/bash
.DEFAULT_GOAL := usage

RED        := \033[0;31m
GREEN      := \033[0;32m
CYAN       := \033[0;36m
YELLOW     := \033[1;33m
NC         := \033[0m # No Colour

usage:
	@printf "\n\n$(YELLOW)Usage:$(NC)\n\n"
	@printf "$(GREEN)TESTING$(NC)\n"
	@printf "$(GREEN)==================================================================$(NC)\n"
	@printf "$(YELLOW)make check-syntax  $(GREEN)# Run syntax-check for this project\n"
	@printf "$(YELLOW)make lint          $(GREEN)# Run ansible-lint for this project\n"
	@printf "\n\n"
	@printf "$(GREEN)DEPLOYMENTS $(NC)\n"
	@printf "$(GREEN)==================================================================$(NC)\n"
	@printf "$(YELLOW)make vpc           $(GREEN)# Provision VPC Resources with InternetGateway $(NC)\n"
	@printf "$(YELLOW)make load-balancer $(GREEN)# Provision Application LoadBalancer $(NC)\n"
	@printf "$(YELLOW)make auto-scaling  $(GREEN)# Provision AutoScalingGroup $(NC)\n"
	@printf "$(YELLOW)make all           $(GREEN)# Provision all Resources\n"
	@printf "                   $(GREEN)  (vpc, loadbalancer, autoscaling, s3, and rds)$(NC)\n"
	@printf "\n\n"

check-syntax:
	ansible-playbook -i inventory/local --syntax-check playbook-all.yml --check -vvv
	@printf "$(CYAN)check-syntax Successful!\n"

lint:
	# Exclude galaxy_info rule because roles are not galaxy roles
	ansible-lint -x 701 playbook-all.yml
	@printf "$(CYAN)Lint Successful!\n"

vpc:
	ansible-playbook -i inventory/local playbook-vpc.yml -vvv

load-balancer:
	ansible-playbook -i inventory/local playbook-load-balancer.yml -vvv

auto-scaling:
	ansible-playbook -i inventory/local playbook-auto-scaling-group.yml -vvv
