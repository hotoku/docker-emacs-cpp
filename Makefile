IMAGE := hotoku/emacs-cpp
PLATFORM := linux/amd64

.PHONY: run
run:
	docker run --platform $(PLATFORM) -it --rm -v "$(HOME)/.ssh:/root/.ssh" $(IMAGE)

.PHONY: build
build:
	docker build --platform $(PLATFORM) -t hotoku/emacs-cpp .

