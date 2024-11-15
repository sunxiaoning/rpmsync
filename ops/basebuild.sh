build-tar() {
  echo "Build ${APP_NAME}-${APP_VERSION}.tar.gz ..."

  if [[ -z "${TEMP_PATH_BUILD}" ]]; then
    TEMP_PATH_BUILD="$(
      mktemp -d -t building_rpm_repo-XXXXXX || {
        echo 'Error: Failed to create building RPM repo path' >&2
        exit 1
      }
    )"
  fi

  tar -cvzf "${TEMP_PATH_BUILD}/${APP_NAME}-${APP_VERSION}.tar.gz" -C "${REPO_LOCAL_ROOT_PATH}" "${APP_NAME}/${APP_VERSION}"
}
