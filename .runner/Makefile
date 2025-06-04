# .runner/Makefile

GITHUB_PAT ?= $(shell echo $$GITHUB_PAT)

.PHONY: setup remove status

setup:
	@echo "🛠 Bootstrapping GitHub Runner..."
	@GITHUB_PAT=$(GITHUB_PAT) bash bootstrap-runner.sh

remove:
	@echo "🧹 Removing GitHub Runner..."
	cd ~/actions-runner && sudo ./svc.sh stop && ./config.sh remove --token $(GITHUB_PAT)

status:
	systemctl status "actions.runner.SPAMartPARTY-spamwiki-infra.baremetal-runner.service"

