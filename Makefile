.PHONY: help test build clean publish

# Build options
IMAGE_NAME?="rshiny-example"
IMAGE_TAG?="latest"

DOCKER_NO_CACHE?="false"

# Publish options
DOCKER_PUBLISH_NAME?="shmileee/rshiny-example"
DOCKER_PUBLISH_TAG?=$(IMAGE_TAG)

help:  ## Show available commands
	@echo "Available commands:"
	@echo
	@sed -n -E -e 's|^([a-z-]+):.+## (.+)|\1@\2|p' $(MAKEFILE_LIST) | column -s '@' -t

test:  ## Run test commands
	pre-commit run --all-files --verbose --show-diff-on-failure --color always

build:
	docker build -f Dockerfile --no-cache=$(DOCKER_NO_CACHE) \
	-t $(IMAGE_NAME):$(IMAGE_TAG) .

clean:
	-docker rmi $(IMAGE_NAME):$(IMAGE_TAG)

publish:
	docker tag $(IMAGE_NAME):$(IMAGE_TAG) $(DOCKER_PUBLISH_NAME):$(DOCKER_PUBLISH_TAG)
	docker push $(DOCKER_PUBLISH_NAME):$(DOCKER_PUBLISH_TAG)
