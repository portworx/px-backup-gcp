STORK_VERSION=24.3.3
KUBE_VERSION=v1.25.1
GCR_REPO=portworx-public
DEPLOYER_MINOR_VERSION=2.7
DEPLOYER_PATCH_VERSION=2.7.3

BASE_DEST_PATH=gcr.io/${GCR_REPO}
PRODUCT_NAME=px-backup
SCHEMA_VERSION=2.7.3

echo "Using the following versions:"
echo "    PX: ${PX_VERSION}"
echo "    stork: ${STORK_VERSION}"
echo "    Kubernetes: ${KUBE_VERSION}"
echo ""
echo "Pushing to ${BASE_DEST_PATH}/${PRODUCT_NAME}"

publish_image () {
  source_path=$1
  image_tag=$2
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
STORK_SOURCE=openstorage/stork:${STORK_VERSION}
publish_image ${STORK_SOURCE} ${STORK_VERSION} ${PRODUCT_NAME}/stork

SCHEDULER_SOURCE=k8s.gcr.io/kube-scheduler-amd64:${KUBE_VERSION}
publish_image ${SCHEDULER_SOURCE} ${KUBE_VERSION} ${PRODUCT_NAME}/kube-scheduler-amd64

CONTROLLER_MANAGER_SOURCE=k8s.gcr.io/kube-controller-manager-amd64:${KUBE_VERSION}
publish_image ${CONTROLLER_MANAGER_SOURCE} ${KUBE_VERSION} ${PRODUCT_NAME}/kube-controller-manager-amd64

PXCENTRAL_ONPREM_API_TAG=2.7.3
PXCENTRAL_ONPREM_API=portworx/pxcentral-onprem-api:${PXCENTRAL_ONPREM_API_TAG}
publish_image ${PXCENTRAL_ONPREM_API} ${PXCENTRAL_ONPREM_API_TAG} ${PRODUCT_NAME}/pxcentral-onprem-api

PXCENTRAL_ONPREM_UI_FRONTEND_TAG=2.7.3
PXCENTRAL_ONPREM_UI_FRONTEND=portworx/pxcentral-onprem-ui-frontend:${PXCENTRAL_ONPREM_UI_FRONTEND_TAG}
publish_image ${PXCENTRAL_ONPREM_UI_FRONTEND} ${PXCENTRAL_ONPREM_UI_FRONTEND_TAG} ${PRODUCT_NAME}/pxcentral-onprem-ui-frontend

PXCENTRAL_ONPREM_UI_BACKEND_TAG=2.7.3
PXCENTRAL_ONPREM_UI_BACKEND=portworx/pxcentral-onprem-ui-backend:${PXCENTRAL_ONPREM_UI_BACKEND_TAG}
publish_image ${PXCENTRAL_ONPREM_UI_BACKEND} ${PXCENTRAL_ONPREM_UI_BACKEND_TAG} ${PRODUCT_NAME}/pxcentral-onprem-ui-backend

PXCENTRAL_ONPREM_UI_LHBACKEND_TAG=2.7.3
PXCENTRAL_ONPREM_UI_LHBACKEND=portworx/pxcentral-onprem-ui-lhbackend:${PXCENTRAL_ONPREM_UI_LHBACKEND_TAG}
publish_image ${PXCENTRAL_ONPREM_UI_LHBACKEND} ${PXCENTRAL_ONPREM_UI_LHBACKEND_TAG} ${PRODUCT_NAME}/pxcentral-onprem-ui-lhbackend

PXCENTRAL_ONPREM_POST_SETUP_TAG=2.7.3
PXCENTRAL_ONPREM_POST_SETUP=portworx/pxcentral-onprem-post-setup:${PXCENTRAL_ONPREM_POST_SETUP_TAG}
publish_image ${PXCENTRAL_ONPREM_POST_SETUP} ${PXCENTRAL_ONPREM_POST_SETUP_TAG} ${PRODUCT_NAME}/pxcentral-onprem-post-setup

POSTGRESQL_TAG=11.19.0-debian-11-r1
POSTGRESQL=portworx/postgresql:${POSTGRESQL_TAG}
publish_image ${POSTGRESQL} ${POSTGRESQL_TAG} ${PRODUCT_NAME}/postgresql

KEYCLOAK_TAG=21.1.2
KEYCLOAK=portworx/keycloak:${KEYCLOAK_TAG}
publish_image ${KEYCLOAK} ${KEYCLOAK_TAG} ${PRODUCT_NAME}/keycloak

KEYCLOAK_LOGIN_THEME_TAG=2.2.0
KEYCLOAK_LOGIN_THEME=portworx/keycloak-login-theme:${KEYCLOAK_LOGIN_THEME_TAG}
publish_image ${KEYCLOAK_LOGIN_THEME} ${KEYCLOAK_LOGIN_THEME_TAG} ${PRODUCT_NAME}/keycloak-login-theme

BUSYBOX_TAG=1.35.0
BUSYBOX=portworx/busybox:${BUSYBOX_TAG}
publish_image ${BUSYBOX} ${BUSYBOX_TAG} ${PRODUCT_NAME}/busybox

MYSQL_TAG=8.0.37
MYSQL=portworx/mysql:${MYSQL_TAG}
publish_image ${MYSQL} ${MYSQL_TAG} ${PRODUCT_NAME}/mysql

PX_BACKUP_TAG=2.7.3
PX_BACKUP=portworx/px-backup:${PX_BACKUP_TAG}
publish_image ${PX_BACKUP} ${PX_BACKUP_TAG} ${PRODUCT_NAME}/px-backup

KOPIAEXECUTOR_TAG=1.2.14
KOPIAEXECUTOR=portworx/kopiaexecutor:${KOPIAEXECUTOR_TAG}
publish_image ${KOPIAEXECUTOR} ${KOPIAEXECUTOR_TAG} ${PRODUCT_NAME}/kopiaexecutor

MONGODB_TAG=6.0.13-debian-11-r21
MONGODB=portworx/mongodb:${MONGODB_TAG}
publish_image ${MONGODB} ${MONGODB_TAG} ${PRODUCT_NAME}/mongodb

MONGODB_TAG=7.0.14-debian-12-r0
MONGODB=portworx/mongodb:${MONGODB_TAG}
publish_image ${MONGODB} ${MONGODB_TAG} ${PRODUCT_NAME}/mongodb

PRE_UPGRADE_HOOK_TAG=2.7.3
PRE_UPGRADE_HOOK=portworx/pxcentral-onprem-pre-upgrade:${PRE_UPGRADE_HOOK_TAG}
publish_image ${PRE_UPGRADE_HOOK} ${PRE_UPGRADE_HOOK_TAG} ${PRODUCT_NAME}/pxcentral-onprem-pre-upgrade

MYSQL_INIT_TAG=1.35.0
MYSQL_INIT=portworx/busybox:${MYSQL_INIT_TAG}
publish_image ${MYSQL_INIT} ${MYSQL_INIT_TAG} ${PRODUCT_NAME}/busybox

PXBACKUP_PROMETHEUS_TAG=v2.53.0
PXBACKUP_PROMETHEUS=portworx/prometheus:${PXBACKUP_PROMETHEUS_TAG}
publish_image ${PXBACKUP_PROMETHEUS} ${PXBACKUP_PROMETHEUS_TAG} ${PRODUCT_NAME}/prometheus

PXBACKUP_ALERTMANAGER_TAG=v0.26.0
PXBACKUP_ALERTMANAGER=portworx/alertmanager:${PXBACKUP_ALERTMANAGER_TAG}
publish_image ${PXBACKUP_ALERTMANAGER} ${PXBACKUP_ALERTMANAGER_TAG} ${PRODUCT_NAME}/alertmanager

PXBACKUP_PROMETHEUS_OPERATOR_TAG=v0.75.0
PXBACKUP_PROMETHEUS_OPERATOR=portworx/prometheus-operator:${PXBACKUP_PROMETHEUS_OPERATOR_TAG}
publish_image ${PXBACKUP_PROMETHEUS_OPERATOR} ${PXBACKUP_PROMETHEUS_OPERATOR_TAG} ${PRODUCT_NAME}/prometheus-operator

PXBACKUP_PROMETHEUS_CONFIG_RELOADER_TAG=v0.75.0
PXBACKUP_PROMETHEUS_CONFIG_RELOADER=portworx/prometheus-config-reloader:${PXBACKUP_PROMETHEUS_CONFIG_RELOADER_TAG}
publish_image ${PXBACKUP_PROMETHEUS_CONFIG_RELOADER} ${PXBACKUP_PROMETHEUS_CONFIG_RELOADER_TAG} ${PRODUCT_NAME}/prometheus-config-reloader