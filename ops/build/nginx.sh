build-tarnginx() {
  APP_NAME="${NGINX_APP_NAME}"

  APP_VERSION="${LATEST_NGINX_VERSION}"
  build-tar

  APP_VERSION="1.24.0"
  build-tar

  APP_VERSION="1.22.1"
  build-tar
}
