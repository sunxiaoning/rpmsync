. ${CONTEXT_DIR}/ops/basebuild.sh

. ${CONTEXT_DIR}/ops/build/galera.sh

. ${CONTEXT_DIR}/ops/build/nginx.sh

build-tarall() {
  build-tarnginx
  build-targalera4
}
