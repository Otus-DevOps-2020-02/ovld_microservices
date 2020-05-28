.PHONY: help

ifndef DOCKER_PASSWORD
$(error DOCKER_PASSWORD is not set)
endif

USERNAME=ovld

BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
COMMIT = $(shell git rev-parse --short HEAD)

BUILD_FAIL = \e[1;31mBuild FAILED! $<\e[0m
BUILD_WIN = \e[1;32mBuild Successful! $<\e[0m

PUSH_FAIL = \e[1;31mImage Push FAILED! $<\e[0m
PUSH_WIN = \e[1;32mImage Push Successful! $<\e[0m

BUILD = && echo "$(BUILD_WIN)" || echo "$(BUILD_FAIL)"
PUSH  = && echo "$(PUSH_WIN)" || echo "$(PUSH_FAIL)"

login: # -- LOGIN TO DOCKER REGISTRY
	@docker login -u $(USERNAME) -p $(DOCKER_PASSWORD)

mng_build: # -- BUILD ALL MONITORING IMAGES
	@docker build -t $(USERNAME)/prometheus ../monitoring/prometheus/ $(BUILD)
	@docker build -t $(USERNAME)/alertmanager ../monitoring/alertmanager/ $(BUILD)
	@docker build -t $(USERNAME)/mongodb-exporter ../monitoring/mongodb-exporter/ $(BUILD)
	@docker build -t $(USERNAME)/telegraf ../monitoring/telegraf/ $(BUILD)
	@docker build -t $(USERNAME)/grafana ../monitoring/grafana/ $(BUILD)

mng_push: # -- PUSH ALL MONITORING IMAGES
	@docker push $(USERNAME)/prometheus $(PUSH)
	@docker push $(USERNAME)/alertmanager $(PUSH)
	@docker push $(USERNAME)/mongodb-exporter $(PUSH)
	@docker push $(USERNAME)/telegraf $(PUSH)
	@docker push $(USERNAME)/grafana $(PUSH)

mng_up: # -- UP MONITORING IMAGES
	@docker-compose -f docker-compose-monitoring.yml -p monitoring up -d

mng_down: # -- DOWN MONITORING IMAGES
	@docker-compose -f docker-compose-monitoring.yml -p monitoring down

mng_ps:
	@docker-compose -f docker-compose-monitoring.yml -p monitoring ps

svc_build: # -- BUILD ALL APP IMAGES
	@echo $(COMMIT) > ../src/comment/build_info.txt
	@echo $(BRANCH) >> ../src/comment/build_info.txt
	@echo $(COMMIT) > ../src/ui/build_info.txt
	@echo $(BRANCH) >> ../src/ui/build_info.txt
	@echo $(COMMIT) > ../src/post-py/build_info.txt
	@echo $(BRANCH) >> ../src/post-py/build_info.txt

	@docker build -t $(USERNAME)/comment ../src/comment/ $(BUILD)
	@docker build -t $(USERNAME)/post ../src/post-py/ $(BUILD)
	@docker build -t $(USERNAME)/ui ../src/ui/ $(BUILD)

svc_push: # -- PUSH ALL APP IMAGES
	@docker push $(USERNAME)/comment $(PUSH)
	@docker push $(USERNAME)/post $(PUSH)
	@docker push $(USERNAME)/ui $(PUSH)

svc_up: # -- UP APP IMAGES
	@docker-compose -p microservices up -d

svc_down: # -- DOWN APP IMAGES
	@docker-compose -p microservices down

all_up: # -- UP ALL
	@docker-compose -p microservices up -d
	@docker-compose -f docker-compose-monitoring.yml -p monitoring up -d

all_down: # -- DOWN ALL
	@docker-compose -f docker-compose-monitoring.yml -p monitoring down
	@docker-compose -p microservices down

help:
	@grep -P '^[a-zA-Z_-]+:.*#*.*' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
