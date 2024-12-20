REPO_LOCAL_ROOT_PATH=/opt/rpmrepo
TEMP_PATH_BUILD=""

NGINX_APP_NAME="nginx"

GALERA4_APP_NAME="galera-4"
MYSQL_WSREP_80_APP_NAME="mysql-wsrep-8.0"

APP_NAME=${APP_NAME-${NGINX_APP_NAME}}

LATEST_NGINX_VERSION="1.26.2"

LATEST_GALERA_4_VERSION="26.4.20"
LATEST_MYSQL_WSREP_80_VERSION="8.0.39"

APP_VERSION=${APP_VERSION:-${LATEST_NGINX_VERSION}}
