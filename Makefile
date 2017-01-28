NAME=cbdocker
VERSION=0.0.1
ARGS=--network=host --build-arg version=$(VERSION)

all:
	docker build $(ARGS) -t $(NAME):$(VERSION) -t $(NAME):latest .
