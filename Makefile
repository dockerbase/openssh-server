NAME = dockerbase/openssh-server
VERSION = 1.1

.PHONY: all build test tag_latest release ssh

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

test:
	#env NAME=$(NAME) VERSION=$(VERSION) ./test/runner.sh
	docker run -it --rm $(NAME):$(VERSION) echo hello world!

run:
	docker run --name $(subst /,-,$(NAME)) --restart=always -t --cidfile cidfile -d $(NAME):$(VERSION) /sbin/runit

start:
	docker start `cat cidfile`

stop:
	docker stop -t 10 `cat cidfile`

rm:
	docker rm `cat cidfile`
	rm -fr cidfile

version:
	docker run -it --rm $(NAME):$(VERSION) sh -c " lsb_release -d ; git --version ; ssh -V " | tee COMPONENTS
	dos2unix COMPONENTS
	sed -i -e 's/^/    /' COMPONENTS
	sed -i -e '/^### Components & Versions/q' README.md
	echo >> README.md
	cat COMPONENTS >> README.md
	rm COMPONENTS

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	#@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

ssh:
	chmod 600 build/insecure_key
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
		if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
		IP=$$(docker inspect $$ID | grep IPAddr | sed 's/.*: "//; s/".*//') && \
		echo "SSHing into $$IP" && \
		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i build/insecure_key root@$$IP

enter:
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
                if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
                PID=$$(docker inspect --format {{.State.Pid}} $$ID) && \
                SHELL=/bin/bash sudo -E build/bin/nsenter --target $$PID --mount --uts --ipc --net --pid
