# Makefile for automating nginx-eks-automode setup
AWS_REGION = us-east-1
CLUSTER_NAME = kiran-eks-demo
PROFILE = eks-auto
TF_DIR = terraform-eks
K8S_DIR = k8s-manifests
PROM_GRAFANA_NS = monitoring

.PHONY: all setup init plan apply deploy get-pods port-forward destroy clean

all: apply deploy get-pods

setup:
	aws configure --profile $(PROFILE)

init:
	cd $(TF_DIR) && terraform init

plan:
	cd $(TF_DIR) && terraform plan

apply:
	cd $(TF_DIR) && terraform apply -auto-approve

deploy:
	aws eks update-kubeconfig --name $(CLUSTER_NAME) --region $(AWS_REGION) --profile $(PROFILE)
	kubectl apply -f $(K8S_DIR)/

get-pods:
	kubectl get pods -A

port-forward:
	kubectl port-forward svc/kube-prometheus-stack-grafana 8000:80 -n $(PROM_GRAFANA_NS)

destroy:
	cd $(TF_DIR) && terraform destroy -auto-approve

