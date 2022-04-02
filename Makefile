
all: init clean validate plan dev_deploy

init:
	@echo Init
	terraform init

clean:
	@echo Clean
	terraform destroy --auto-approve -var bucket_s3_env=dev

validate:
	@echo Validate
	terraform validate

plan:
	@echo Plan
	terraform plan

apply:
	@echo Apply Dev
	terraform apply --auto-approve -var bucket_s3_env=dev

