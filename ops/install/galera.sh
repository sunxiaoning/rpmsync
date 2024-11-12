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

install-repogalera4() {
  APP_NAME=galera-4

  APP_VERSION="${LATEST_GALERA_4_VERSION}"
  install-repo

  APP_VERSION="26.4.19"
  install-repo

  APP_NAME="${MYSQL_WSREP_80_APP_NAME}"

  APP_VERSION="${LATEST_MYSQL_WSREP_80_VERSION}"
  install-repo

  APP_VERSION="8.0.37"
  install-repo
}
