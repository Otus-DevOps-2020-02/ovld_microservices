USERNAME=ovld
TAG := $(shell git rev-parse --short HEAD)

ifndef DOCKER_PASSWORD
$(error DOCKER_PASSWORD is not set)
endif



build:
	@docker build -t $(USERNAME)/$(C):$(TAG) ../monitoring/$(C)/
	@sed 's/TAG.*/TAG=$(TAG)/g' -i .env.example && cp .env.example .env

login:
	@docker login -u $(USERNAME) -p $(DOCKER_PASSWORD)

push:
	@docker push $(USERNAME)/$(C):$(TAG)
