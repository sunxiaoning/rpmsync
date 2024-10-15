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
