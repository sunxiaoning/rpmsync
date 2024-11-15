build-tar() {
  echo "Build ${APP_NAME}-${APP_VERSION}.tar.gz ..."

  if [[ -z "${TEMP_PATH_BUILD}" ]]; then
    TEMP_PATH_BUILD="$(
      rm -rf /tmp/building_rpm_repo-XXXXXX && mktemp -d -t building_rpm_repo-XXXXXX || {
        echo 'Failed to create the path for building the RPM repository.' >&2
        exit 1
      }
    )"
  fi

  tar -cvzf "${TEMP_PATH_BUILD}/${APP_NAME}-${APP_VERSION}.tar.gz" -C "${REPO_LOCAL_ROOT_PATH}" "${APP_NAME}/${APP_VERSION}"
}
