.PHONY: get plan apply

all: clean get plan apply

clean:
	rm -rf .terraform


get:
	terraform get

plan:
	terraform plan -out=plan.out -var-file=secrets.tfvars

apply:
	terraform apply -var-file=secrets.tfvars

destroy:
	terraform destroy -var-file=secrets.tfvars