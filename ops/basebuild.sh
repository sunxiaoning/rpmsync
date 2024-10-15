build-tar() {
  echo "Build ${APP_NAME}-${APP_VERSION}.tar.gz ..."

  mkdir -p "${BUILD_PATH}"
  tar -cvzf "${BUILD_PATH}/${APP_NAME}-${APP_VERSION}.tar.gz" -C "${REPO_LOCAL_ROOT_PATH}" "${APP_NAME}/${APP_VERSION}"
}
