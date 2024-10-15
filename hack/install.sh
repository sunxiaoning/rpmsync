#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE}")")

. ${SCRIPT_DIR}/env.sh

REL_NOTES="new release"

INSTALL_PATH=/tmp/__rpmrepo-install

export REPO_ORIGIN_SOURCE=${REPO_ORIGIN_SOURCE:-"0"}

REPO_URL_GITHUB="https://github.com/sunxiaoning/rpmsync/releases/download"
REPO_URL_GITEE="https://gitee.com/williamsun/rpmsync/releases/download"

REPO_URL=${REPO_URL:-${REPO_URL_GITHUB}}

AUTH_GH_SH_URL_GITHUB="https://raw.githubusercontent.com/sunxiaoning/ghcli/main/autorun.sh"
AUTH_GH_SH_URL_GITEE="https://gitee.com/williamsun/ghcli/raw/main/autorun.sh"

AUTH_GH_SH_URL=${AUTH_GH_SH_URL:-${AUTH_GH_SH_URL_GITHUB}}

install-rel() {
  auth-gh

  REL_TAG="${APP_NAME}-repo-v${APP_VERSION}"
  REL_TITLE="Release ${APP_NAME} repo v${APP_VERSION}"

  if gh release view "${REL_TAG}" &>/dev/null; then
    echo "Release ${REL_TAG} already exists!"
    return 0
  fi

  gh release create "${REL_TAG}" "${BUILD_PATH}/${APP_NAME}-${APP_VERSION}.tar.gz" --title "${REL_TITLE}" --notes "${REL_NOTES}"

  rm -f "${BUILD_PATH}/${APP_NAME}-${APP_VERSION}.tar.gz"
}

auth-gh() {
  if [[ "1" == "${REPO_ORIGIN_SOURCE}" ]]; then
    AUTH_GH_SH_URL="${AUTH_GH_SH_URL_GITEE}"
  fi

  /bin/bash -c "$(curl -fsSL ${AUTH_GH_SH_URL})"
}

install-relnginx() {
  APP_NAME="${NGINX_APP_NAME}"

  APP_VERSION="${LATEST_NGINX_VERSION}"
  REL_NOTES="released repo ${APP_NAME}-${APP_VERSION}."
  install-rel

  APP_VERSION="1.24.0"
  REL_NOTES="released repo ${APP_NAME}-${APP_VERSION}."
  install-rel

  APP_VERSION="1.22.1"
  REL_NOTES="released repo ${APP_NAME}-${APP_VERSION}."
  install-rel
}

install-relgalera4() {
  APP_NAME="${GALERA4_APP_NAME}"

  APP_VERSION="${LATEST_GALERA_4_VERSION}"
  REL_NOTES="released repo ${APP_NAME}-${APP_VERSION}."
  install-rel

  APP_VERSION="26.4.19"
  REL_NOTES="released repo ${APP_NAME}-${APP_VERSION}."
  install-rel

  APP_NAME="${MYSQL_WSREP_80_APP_NAME}"

  APP_VERSION="${LATEST_MYSQL_WSREP_80_VERSION}"
  REL_NOTES="released repo ${APP_NAME}-${APP_VERSION}."
  install-rel

  APP_VERSION="8.0.37"
  REL_NOTES="released repo ${APP_NAME}-${APP_VERSION}."
  install-rel
}

install-relall() {
  install-relnginx
  install-relgalera4
}

install-repo() {

  if [[ "1" == "${REPO_ORIGIN_SOURCE}" ]]; then
    REPO_URL="${REPO_URL_GITEE}"
  fi

  APP_REPO_URL="${REPO_URL}/${APP_NAME}-repo-v${APP_VERSION}/${APP_NAME}.tar.gz"

  mkdir -p "${INSTALL_PATH}"

  curl -Lo "${INSTALL_PATH}/${APP_NAME}.tar.gz" "${APP_REPO_URL}"
  rm -rf "${REPO_LOCAL_ROOT_PATH}/${APP_NAME}"
  mkdir -p "${REPO_LOCAL_ROOT_PATH}"
  tar -zxvf "${INSTALL_PATH}/${APP_NAME}.tar.gz" -C "${REPO_LOCAL_ROOT_PATH}"
  rm -f "${INSTALL_PATH}/${APP_NAME}.tar.gz"
}

install-reponginx() {
  APP_NAME=nginx
  APP_VERSION="1.0.0"
  install-repo
}

install-repogalera4() {
  APP_NAME=galera-4
  APP_VERSION="1.0.0"
  install-repo

  APP_NAME=mysql-wsrep-8.0
  APP_VERSION="1.0.0"
  install-repo
}

install-repoall() {
  install-reponginx
  install-repogalera4
}

main() {
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
}

main "$@"
