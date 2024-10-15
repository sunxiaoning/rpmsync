#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE}")")

. ${SCRIPT_DIR}/env.sh

build-tar() {
  echo "Build ${APP_NAME}.tar.gz ..."

  mkdir -p "${BUILD_PATH}"
  tar -cvzf "${BUILD_PATH}/${APP_NAME}-${APP_VERSION}.tar.gz" -C "${REPO_LOCAL_ROOT_PATH}" "${APP_NAME}/${APP_VERSION}"
}

build-tarnginx() {
  APP_NAME="${NGINX_APP_NAME}"

  APP_VERSION="${LATEST_NGINX_VERSION}"
  build-tar

  APP_VERSION="1.24.0"
  build-tar

  APP_VERSION="1.22.1"
  build-tar
}

build-targalera4() {
  APP_NAME="${GALERA4_APP_NAME}"

  APP_VERSION="${LATEST_GALERA_4_VERSION}"
  build-tar

  APP_VERSION="26.4.19"
  build-tar

  APP_NAME="${MYSQL_WSREP_80_APP_NAME}"

  APP_VERSION="${LATEST_MYSQL_WSREP_80_VERSION}"
  build-tar

  APP_VERSION="8.0.37"
  build-tar
}

build-tarall() {
  build-tarnginx
  build-targalera4
}

main() {
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
}

main "$@"
