
all: init clean validate plan apply

init:
	@echo Init
	cd infra && terraform init

clean:
	@echo Clean
	cd infra && terraform destroy --auto-approve -var bucket_s3_env=dev

validate:
	@echo Validate
	cd infra && terraform validate

plan:
	@echo Plan
	cd infra && terraform plan -var bucket_s3_env=dev

apply:
	@echo Apply Dev
	cd infra && terraform apply --auto-approve -var bucket_s3_env=dev

