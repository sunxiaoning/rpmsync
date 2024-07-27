init:
	@echo "Init env ..."
	hack/init.sh

prepare:
	@echo "Prepare workspace ..."
	hack/prepare.sh

build-tar:
	@echo "Build-repotar ..."
	hack/build.sh tar

build-tarnginx:
	@echo "Build nginx repo tar ..."
	hack/build.sh tarnginx

build-targalera4:
	@echo "Build galera4 repo tar ..."
	hack/build.sh targalera4

build-tarall:
	@echo "Build all tar ..."
	hack/build.sh tarall

install-rel: build-tar
	@echo "Install repo release ..."
	hack/install.sh rel

install-relnginx: build-tarnginx
	@echo "Install nginx repo release ..."
	hack/install.sh relnginx

install-relgalera4: build-targalera4
	@echo "Install galera4 repo release ..."
	hack/install.sh relgalera4

install-relall: build-tarall
	@echo "Install all repo rel release ..."
	hack/install.sh relall

install-repo:
	@echo "Install repo ..."
	hack/install.sh repo

install-reponginx:
	@echo "Install nginx repo ..."
	hack/install.sh reponginx

install-repogalera4:
	@echo "Install galera4 repo ..."
	hack/install.sh repogalera4

install-repoall:
	@echo "Install all repo ..."
	hack/install.sh repoall

