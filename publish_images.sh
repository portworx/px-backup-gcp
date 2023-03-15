PX_VERSION=2.12.0
STORK_VERSION=2.12.0
KUBE_VERSION=v1.21.10
GCR_REPO=portworx-public
DEPLOYER_MINOR_VERSION=2.12.0
DEPLOYER_PATCH_VERSION=2.12.0

BASE_DEST_PATH=gcr.io/${GCR_REPO}
PRODUCT_NAME=px-backup
SCHEMA_VERSION=2.4.0

echo "Using the following versions:"
echo "    PX: ${PX_VERSION}"
echo "    stork: ${STORK_VERSION}"
echo "    Kubernetes: ${KUBE_VERSION}"
echo ""
echo "Pushing to ${BASE_DEST_PATH}/${PRODUCT_NAME}"

publish_image () {
  source_path=$1
  image_tag=$SCHEMA_VERSION
  destination_image=$3

  echo "======================================================================"
  echo "Pulling ${source_path} and tagging with the following: "
  echo "       ${BASE_DEST_PATH}/${destination_image}:${DEPLOYER_MINOR_VERSION}"
  echo "       ${BASE_DEST_PATH}/${destination_image}:${DEPLOYER_PATCH_VERSION}"
  echo "       ${BASE_DEST_PATH}/${destination_image}:${image_tag}"
  echo "======================================================================"
  tag_and_push $source_path ${BASE_DEST_PATH}/${destination_image}:${DEPLOYER_MINOR_VERSION}
  tag_and_push $source_path ${BASE_DEST_PATH}/${destination_image}:${DEPLOYER_PATCH_VERSION}
  tag_and_push $source_path ${BASE_DEST_PATH}/${destination_image}:${image_tag}
}

tag_and_push () {
  docker pull $1
  docker tag $1 $2
  docker push $2
}
pxcentral-onprem-ui-frontend 2.4.0
pxcentral-onprem-ui-backend 2.4.0
pxcentral-onprem-ui-lhbackend 2.4.0
busybox 1.31
pxcentral-onprem-api 2.4.0
pxcentral-onprem-post-setup 2.4.0
postgresql 11.18.0-debian-11-r34
keycloak 16.1.1
keycloak-login-theme 2.2.0
mysql 5.7.41
px-backup 2.4.0
mongodb 5.0.14-debian-11-r27
kopiaexecutor 1.2.4
STORK_SOURCE=openstorage/stork:${STORK_VERSION}
publish_image ${STORK_SOURCE} ${STORK_VERSION} ${PRODUCT_NAME}/stork

SCHEDULER_SOURCE=k8s.gcr.io/kube-scheduler-amd64:${KUBE_VERSION}
publish_image ${SCHEDULER_SOURCE} ${KUBE_VERSION} ${PRODUCT_NAME}/kube-scheduler-amd64

CONTROLLER_MANAGER_SOURCE=k8s.gcr.io/kube-controller-manager-amd64:${KUBE_VERSION}
publish_image ${CONTROLLER_MANAGER_SOURCE} ${KUBE_VERSION} ${PRODUCT_NAME}/kube-controller-manager-amd64

PXCENTRAL_ONPREM_API_TAG=2.4.0
PXCENTRAL_ONPREM_API=portworx/pxcentral-onprem-api:${PXCENTRAL_ONPREM_API_TAG}
publish_image ${PXCENTRAL_ONPREM_API} ${PXCENTRAL_ONPREM_API_TAG} ${PRODUCT_NAME}/pxcentral-onprem-api

PXCENTRAL_ONPREM_UI_FRONTEND_TAG=2.4.0
PXCENTRAL_ONPREM_UI_FRONTEND=portworx/pxcentral-onprem-ui-frontend:${PXCENTRAL_ONPREM_UI_FRONTEND_TAG}
publish_image ${PXCENTRAL_ONPREM_UI_FRONTEND} ${PXCENTRAL_ONPREM_UI_FRONTEND_TAG} ${PRODUCT_NAME}/pxcentral-onprem-ui-frontend

PXCENTRAL_ONPREM_UI_BACKEND_TAG=2.4.0
PXCENTRAL_ONPREM_UI_BACKEND=portworx/pxcentral-onprem-ui-backend:${PXCENTRAL_ONPREM_UI_BACKEND_TAG}
publish_image ${PXCENTRAL_ONPREM_UI_BACKEND} ${PXCENTRAL_ONPREM_UI_BACKEND_TAG} ${PRODUCT_NAME}/pxcentral-onprem-ui-backend

PXCENTRAL_ONPREM_UI_LHBACKEND_TAG=2.4.0
PXCENTRAL_ONPREM_UI_LHBACKEND=portworx/pxcentral-onprem-ui-lhbackend:${PXCENTRAL_ONPREM_UI_LHBACKEND_TAG}
publish_image ${PXCENTRAL_ONPREM_UI_LHBACKEND} ${PXCENTRAL_ONPREM_UI_LHBACKEND_TAG} ${PRODUCT_NAME}/pxcentral-onprem-ui-lhbackend

PXCENTRAL_ONPREM_POST_SETUP_TAG=2.4.0
PXCENTRAL_ONPREM_POST_SETUP=portworx/pxcentral-onprem-post-setup:${PXCENTRAL_ONPREM_POST_SETUP_TAG}
publish_image ${PXCENTRAL_ONPREM_POST_SETUP} ${PXCENTRAL_ONPREM_POST_SETUP_TAG} ${PRODUCT_NAME}/pxcentral-onprem-post-setup

POSTGRESQL_TAG=11.18.0-debian-11-r34
POSTGRESQL=portworx/postgresql:${POSTGRESQL_TAG}
publish_image ${POSTGRESQL} ${POSTGRESQL_TAG} ${PRODUCT_NAME}/postgresql

KEYCLOAK_TAG=16.1.1
KEYCLOAK=portworx/keycloak:${KEYCLOAK_TAG}
publish_image ${KEYCLOAK} ${KEYCLOAK_TAG} ${PRODUCT_NAME}/keycloak

KEYCLOAK_LOGIN_THEME_TAG=2.2.0
KEYCLOAK_LOGIN_THEME=portworx/keycloak-login-theme:${KEYCLOAK_LOGIN_THEME_TAG}
publish_image ${KEYCLOAK_LOGIN_THEME} ${KEYCLOAK_LOGIN_THEME_TAG} ${PRODUCT_NAME}/keycloak-login-theme

BUSYBOX_TAG=1.31
BUSYBOX=portworx/busybox:${BUSYBOX_TAG}
publish_image ${BUSYBOX} ${BUSYBOX_TAG} ${PRODUCT_NAME}/busybox

MYSQL_TAG=5.7.41
MYSQL=portworx/mysql:${MYSQL_TAG}
publish_image ${MYSQL} ${MYSQL_TAG} ${PRODUCT_NAME}/mysql

PX_BACKUP_TAG=2.4.0
PX_BACKUP=portworx/px-backup:${PX_BACKUP_TAG}
publish_image ${PX_BACKUP} ${PX_BACKUP_TAG} ${PRODUCT_NAME}/px-backup

MONGODB_TAG=5.0.14-debian-11-r27
MONGODB=portworx/mongodb:${MONGODB_TAG}
publish_image ${MONGODB} ${MONGODB_TAG} ${PRODUCT_NAME}/mongodb

PX_ELS_TAG=2.0.1
PX_ELS=portworx/px-els:${PX_ELS_TAG}
publish_image ${PX_ELS} ${PX_ELS_TAG} ${PRODUCT_NAME}/px-els

CORTEX_TAG=v1.1.0
CORTEX=portworx/cortex:${CORTEX_TAG}
publish_image ${CORTEX} ${CORTEX_TAG} ${PRODUCT_NAME}/cortex

CASSANDRA_TAG=3.11.6-debian-10-r153
CASSANDRA=portworx/cassandra:${CASSANDRA_TAG}
publish_image ${CASSANDRA} ${CASSANDRA_TAG} ${PRODUCT_NAME}/cassandra

NGINX_TAG=1.21.6
NGINX=portworx/nginx:${NGINX_TAG}
publish_image ${NGINX} ${NGINX_TAG} ${PRODUCT_NAME}/nginx

CONSUL_TAG=1.9.5-debian-10-r18
CONSUL=portworx/consul:${CONSUL_TAG}
publish_image ${CONSUL} ${CONSUL_TAG} ${PRODUCT_NAME}/consul

GO_DNSMASQ_TAG=release-1.0.7
GO_DNSMASQ=portworx/go-dnsmasq:${GO_DNSMASQ_TAG}
publish_image ${GO_DNSMASQ} ${GO_DNSMASQ_TAG} ${PRODUCT_NAME}/go-dnsmasq

GRAFANA_TAG=7.1.3
GRAFANA=portworx/grafana:${GRAFANA_TAG}
publish_image ${GRAFANA} ${GRAFANA_TAG} ${PRODUCT_NAME}/grafana

PROMETHEUS_TAG=v2.29.1
PROMETHEUS=portworx/prometheus:${PROMETHEUS_TAG}
publish_image ${PROMETHEUS} ${PROMETHEUS_TAG} ${PRODUCT_NAME}/prometheus

PROMETHEUS_CONFIG_RELOADER_TAG=v0.50.0
PROMETHEUS_CONFIG_RELOADER=portworx/prometheus-config-reloader:${PROMETHEUS_CONFIG_RELOADER_TAG}
publish_image ${PROMETHEUS_CONFIG_RELOADER} ${PROMETHEUS_CONFIG_RELOADER_TAG} ${PRODUCT_NAME}/prometheus-config-reloader

PROMETHEUS_OPERATOR_TAG=v0.50.0
PROMETHEUS_OPERATOR=portworx/prometheus-operator:${PROMETHEUS_OPERATOR_TAG}
publish_image ${PROMETHEUS_OPERATOR} ${PROMETHEUS_OPERATOR_TAG} ${PRODUCT_NAME}/prometheus-operator

MEMCACHED_EXPORTER_TAG=v0.9.0
MEMCACHED_EXPORTER=portworx/memcached-exporter:${MEMCACHED_EXPORTER_TAG}
publish_image ${MEMCACHED_EXPORTER} ${MEMCACHED_EXPORTER_TAG} ${PRODUCT_NAME}/memcached-exporter

MEMCACHED_TAG=1.6.15-alpine
MEMCACHED=portworx/memcached:${MEMCACHED_TAG}
publish_image ${MEMCACHED} ${MEMCACHED_TAG} ${PRODUCT_NAME}/memcached

