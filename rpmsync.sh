#!/bin/bash
CONTEXT_DIR=$(dirname "$(realpath "${BASH_SOURCE}")")
SCRIPT_NAME=$(basename "$0")

. ${CONTEXT_DIR}/bashutils/basicenv.sh

OPS_SH_DIR="${CONTEXT_DIR}/ops"

. "${CONTEXT_DIR}/ops/env.sh"

. "${OPS_SH_DIR}/build.sh"

. "${OPS_SH_DIR}/install.sh"

trap __terminate INT TERM
trap __cleanup EXIT

TEMP_FILES=()

main() {
  case "${1-}" in
  build-tar)
    build-tar
    ;;
  build-tarnginx)
    build-tarnginx
    ;;
  build-targalera4)
    build-targalera4
    ;;
  build-tarall)
    build-tarall
    ;;
  install-rel)
    install-rel
    ;;
  install-relnginx)
    install-relnginx
    ;;
  install-relgalera4)
    install-relgalera4
    ;;
  install-relall)
    install-relall
    ;;
  install-repo)
    install-repo
    ;;
  install-reponginx)
    install-reponginx
    ;;
  install-repogalera4)
    install-repogalera4
    ;;
  install-repoall)
    install-repoall
    ;;
  *)
    echo "The operation: ${1-} is not supported!"
    exit 1
    ;;
  esac
}

terminate() {
  echo "terminating..."
}

cleanup() {
  if [[ "${#TEMP_FILES[@]}" -gt 0 ]]; then
    echo "Cleaning temp_files...."

    for temp_file in "${TEMP_FILES[@]}"; do
      rm -f "${temp_file}" || true
    done
  fi
}

main "$@"
