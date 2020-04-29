TERRAFORM_COMMAND ?= terraform
ANSIBLE_C0MMAND ?= ansible-playbook
SSH_KEY ?= $(HOME)/.ssh/id_rsa
init:
	$(TERRAFORM_COMMAND) init
plan: init
	$(TERRAFORM_COMMAND) plan
apply: init
	$(TERRAFORM_COMMAND) apply -auto-approve; $(TERRAFORM_COMMAND) output ipv4 >> hosts
destroy: init
	$(TERRAFORM_COMMAND) destroy
ansible: apply
	@ANSIBLE_HOST_KEY_CHECKING=False $(ANSIBLE_C0MMAND) --private-key $(SSH_KEY) -i hosts nfdump-nfsen.yml
deploy: ansible
