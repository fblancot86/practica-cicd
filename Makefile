
all: init clean validate plan dev_deploy prod_deploy
only_dev: init clean validate plan dev_deploy

init:
	@echo Init
	terraform init

clean:
	@echo Clean
	terraform destroy --auto-approve -var prod_deploy=true

validate:
	@echo Validate
	terraform validate

plan:
	@echo Plan
	terraform plan

dev_deploy:
	@echo Apply Dev
	terraform apply --auto-approve -var prod_deploy=false

prod_deploy:
	@echo Apply Prod
	terraform apply --auto-approve -var prod_deploy=true

