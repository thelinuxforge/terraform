Before targeting a resource, review the plan:

terraform plan -target=aws_instance.web
terraform apply -target=aws_instance.web


For targeted destruction:

terraform plan -destroy -target=aws_instance.web
terraform destroy -target=aws_instance.web