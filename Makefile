IMAGE := hotoku/emacs-cpp

.PHONY: run
run:
	docker run -it --rm -v $(HOME)/.ssh:/root/.ssh $(IMAGE)

.PHONY: build
build:
	docker build -t hotoku/emacs-cpp .

