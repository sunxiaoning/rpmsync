install-relnginx() {
  build-tarnginx

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

install-reponginx() {
  APP_NAME=nginx

  APP_VERSION="${LATEST_NGINX_VERSION}"
  install-repo

  APP_VERSION="1.24.0"
  install-repo

  APP_VERSION="1.22.1"

  install-repo
}
