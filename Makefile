# Makefile
infrastructure:
	terraform -chdir=terraform init
	terraform -chdir=terraform apply

environment:
	ansible-playbook -i ansible/hosts.cfg ansible/install.yml
	ansible-playbook -i ansible/hosts.cfg ansible/config.yml

destroy:
	terraform -chdir=terraform destroy