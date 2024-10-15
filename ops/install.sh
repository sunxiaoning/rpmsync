. ${CONTEXT_DIR}/ops/baseinstall.sh

. ${CONTEXT_DIR}/ops/install/galera.sh

. ${CONTEXT_DIR}/ops/install/nginx.sh

install-relall() {
  install-relnginx
  install-relgalera4
}

install-repoall() {
  install-reponginx
  install-repogalera4
}
