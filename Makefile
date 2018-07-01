SELFOSS_VERSION=2.18
TAG=$(SELFOSS_VERSION)-1
DOCKER_IMAGE_NAME=spyseth/docker-selfoss

build:
	docker build \
		--build-arg SELFOSS_VERSION=${SELFOSS_VERSION} \
		-t $(DOCKER_IMAGE_NAME):$(TAG) \
		-t $(DOCKER_IMAGE_NAME):latest .

push:
	docker push $(DOCKER_IMAGE_NAME):$(TAG)
	docker push $(DOCKER_IMAGE_NAME):latest

test:
	docker run -it --rm -p 8000:80 spyseth/docker-selfoss:latest
