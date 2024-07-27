#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

USE_DOCKER=${USE_DOCKER:-"0"}

REPO_ROOT_PATH=/opt/rpmrepo

BUILD_PATH=${REPO_ROOT_PATH}/__build

APP_NAME=nginx

build-tar() {
  echo "Build ${APP_NAME}.tar.gz ..."
  mkdir -p "${BUILD_PATH}"
  tar -cvzf "${BUILD_PATH}/${APP_NAME}.tar.gz" -C ${REPO_ROOT_PATH} ${APP_NAME}
}

build-tarnginx() {
  APP_NAME=nginx
  build-tar
}

build-targalera4() {
  APP_NAME=galera-4
  build-tar

  APP_NAME=mysql-wsrep-8.0
  build-tar
}

build-tarall() {
  build-tarnginx
  build-targalera4
}


main() {
  if [[ "1" == "${USE_DOCKER}" ]]; then
    echo "Begin to build with docker."
    case "${1-}" in
    tar)
      build-tar-docker
      ;;
    tarnginx)
      build-tarnginx-docker
      ;;
    targalera4)
      build-targalera4-docker
      ;;
    tarall)
      build-tarall-docker
      ;;
    *)
      build-tarall-docker
      ;;
    esac
  else
    echo "Begin to build in the local environment."
    case "${1-}" in
    tar)
      build-tar
      ;;
    tarnginx)
      build-tarnginx
      ;;
    targalera4)
      build-targalera4
      ;;
    tarall)
      build-tarall
      ;;
    *)
      build-tarall
      ;;
    esac
  fi
}

main "$@"
