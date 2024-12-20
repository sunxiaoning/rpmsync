REL_NOTES="new release"

TEMP_PATH_DOWNLOADING_RPM_REPO=""

export REPO_ORIGIN_SOURCE=${REPO_ORIGIN_SOURCE:-"0"}

REPO_URL_GITHUB="https://github.com/sunxiaoning/rpmsync/releases/download"
REPO_URL_GITEE="https://gitee.com/williamsun/rpmsync/releases/download"

REPO_URL=${REPO_URL:-${REPO_URL_GITHUB}}

AUTH_GH_SH_URL_GITHUB="https://raw.githubusercontent.com/sunxiaoning/ghcli/main/autorun.sh"
AUTH_GH_SH_URL_GITEE="https://gitee.com/williamsun/ghcli/raw/main/autorun.sh"

AUTH_GH_SH_URL=${AUTH_GH_SH_URL:-${AUTH_GH_SH_URL_GITHUB}}

install-rel() {
  build-tar

  TEMP_FILES+=("${TEMP_PATH_BUILD}/${APP_NAME}-${APP_VERSION}.tar.gz")

  auth-gh >/dev/null

  REL_TAG="${APP_NAME}-repo-v${APP_VERSION}"
  REL_TITLE="Release ${APP_NAME} repo v${APP_VERSION}"

  echo "Releasing ${REL_TAG} ..."

  if gh release view "${REL_TAG}" &>/dev/null; then
    echo "Release ${REL_TAG} already exists!"
    return 0
  fi

  gh release create "${REL_TAG}" "${TEMP_PATH_BUILD}/${APP_NAME}-${APP_VERSION}.tar.gz" --title "${REL_TITLE}" --notes "${REL_NOTES}"
}

auth-gh() {
  if [[ "1" == "${REPO_ORIGIN_SOURCE}" ]]; then
    AUTH_GH_SH_URL="${AUTH_GH_SH_URL_GITEE}"
  fi

  /bin/bash -c "$(curl -fsSL ${AUTH_GH_SH_URL})"
}

install-repo() {
  echo "Install ${APP_NAME}-${APP_VERSION} repo..."

  if [[ "1" == "${REPO_ORIGIN_SOURCE}" ]]; then
    REPO_URL="${REPO_URL_GITEE}"
  fi

  APP_REPO_URL="${REPO_URL}/${APP_NAME}-repo-v${APP_VERSION}/${APP_NAME}-${APP_VERSION}.tar.gz"

  if [[ -z "${TEMP_PATH_DOWNLOADING_RPM_REPO}" ]]; then
    TEMP_PATH_DOWNLOADING_RPM_REPO="$(
      rm -rf /tmp/downloading_rpm_repo-* && mktemp -d -t downloading_rpm_repo-XXXXXX || {
        echo 'Error: Failed to create the path for downloading the RPM repository.' >&2
        exit 1
      }
    )"
  fi

  echo "Downloading ${APP_NAME}-${APP_VERSION}.tar.gz from ${APP_REPO_URL}..."

  TEMP_FILES+=("${TEMP_PATH_DOWNLOADING_RPM_REPO}/${APP_NAME}-${APP_VERSION}.tar.gz")

  curl -fsSLo "${TEMP_PATH_DOWNLOADING_RPM_REPO}/${APP_NAME}-${APP_VERSION}.tar.gz" "${APP_REPO_URL}"

  mkdir -p "${REPO_LOCAL_ROOT_PATH}"

  rm -rf "${REPO_LOCAL_ROOT_PATH}/${APP_NAME}/${APP_VERSION}"

  tar -zxvf "${TEMP_PATH_DOWNLOADING_RPM_REPO}/${APP_NAME}-${APP_VERSION}.tar.gz" -C "${REPO_LOCAL_ROOT_PATH}"
}
