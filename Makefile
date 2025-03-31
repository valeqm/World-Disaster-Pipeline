SHELL := /bin/bash

.PHONY: all

all:
	docker compose up -d
	sleep 60
	python entrypoint.py
	cd terraform && terraform init
	cd terraform && terraform plan
	cd terraform && terraform apply -auto-approve
