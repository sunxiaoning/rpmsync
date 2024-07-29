#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

USE_DOCKER=${USE_DOCKER:-"0"}

REPO_ROOT_PATH=/opt/rpmrepo
BUILD_PATH=/tmp/__rpmrepo-build

APP_NAME=nginx
APP_REPO_VERSION="1.0.0"


REL_NOTES="new release"

INSTALL_PATH=/tmp/__rpmrepo-install
REPO_URL="https://github.com/sunxiaoning/rpmsync/releases/download"


install-rel() {
  REL_TAG="${APP_NAME}-repo-v${APP_REPO_VERSION}"
  REL_TITLE="Release ${APP_NAME} repo v${APP_REPO_VERSION}"

  if gh release view "${REL_TAG}" &>/dev/null; then
    echo "Release ${REL_TAG} already exists!"
    exit 0
  fi

  gh release create "${REL_TAG}" "${BUILD_PATH}/${APP_NAME}.tar.gz" --title "${REL_TITLE}" --notes "${REL_NOTES}"
  rm -f "${BUILD_PATH}/${APP_NAME}.tar.gz"
}

install-relnginx() {
  APP_NAME=nginx
  APP_REPO_VERSION="1.0.0"
  REL_NOTES="new release"


  install-rel
}

install-relgalera4() {
  APP_NAME=galera-4
  APP_REPO_VERSION="1.0.0"
  REL_NOTES="new release"
  install-rel

  APP_NAME=mysql-wsrep-8.0
  APP_REPO_VERSION="1.0.0"
  REL_NOTES="new release"
  install-rel
}

install-relall() {
  install-relnginx
  install-relgalera4
}

install-repo() {
  mkdir -p "${INSTALL_PATH}"
  APP_REPO_URL="${REPO_URL}/${APP_NAME}-repo-v${APP_REPO_VERSION}/${APP_NAME}.tar.gz"
  curl -Lo "${INSTALL_PATH}/${APP_NAME}.tar.gz" "${APP_REPO_URL}"
  rm -rf "${REPO_ROOT_PATH}/${APP_NAME}"
  tar -zxvf "${INSTALL_PATH}/${APP_NAME}.tar.gz" -C "${REPO_ROOT_PATH}"
  rm -f "${INSTALL_PATH}/${APP_NAME}.tar.gz"
}

install-reponginx() {
  APP_NAME=nginx
  APP_REPO_VERSION="1.0.0"
  install-repo
}

install-repogalera4() {
  APP_NAME=galera-4
  APP_REPO_VERSION="1.0.0"
  install-repo

  APP_NAME=mysql-wsrep-8.0
  APP_REPO_VERSION="1.0.0"
  install-repo
}

install-repoall() {
  install-reponginx
  install-repogalera4
}



main() {
  if [[ "1" == "${USE_DOCKER}" ]]; then
    echo "Begin to build with docker."
    case "${1-}" in
    rel)
      install-rel-docker
      ;;
    relnginx)
      install-relnginx-docker
      ;;
    relgalera4)
      install-relgalera4-docker
      ;;
    relall)
      install-relall-docker
      ;;
    repo)
      install-repo-docker
      ;;
    reponginx)
      install-reponginx-docker
      ;;
    repogalera4)
      install-repogalera4-docker
      ;;
    repoall)
      install-repoall-docker
      ;;
    *)
      install-relall-docker
      ;;
    esac
  else
    echo "Begin to build in the local environment."
    case "${1-}" in
    rel)
      install-rel
      ;;
    relnginx)
      install-relnginx
      ;;
    relgalera4)
      install-relgalera4
      ;;
    relall)
      install-relall
      ;;
    repo)
      install-repo
      ;;
    reponginx)
      install-reponginx
      ;;
    repogalera4)
      install-repogalera4
      ;;
    repoall)
      install-repoall
      ;;
    *)
      install-relall
      ;;
    esac
  fi
}

main "$@"
