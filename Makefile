NAME=cbdocker
VERSION=0.0.0
ARGS=--network=host --build-arg version=$(VERSION)

all:
	docker build $(ARGS) -t $(NAME):$(VERSION) -t $(NAME):latest .
