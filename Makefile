DOCKER_HUB_REPO ?= gcr.io/portworx-public/px-backup
DOCKER_HUB_DEPLOYER_IMAGE ?= deployer
# DOCKER_HUB_DEPLOYER_RELEASE_TAG ?= 2.7.0
DOCKER_HUB_DEPLOYER_TAG ?= 2.7.0
MARKETPLACE_TOOLS_TAG ?= latest
GS_BUCKET ?= gs://portworx-public/portworx/portworx-backup
GS_VERSION ?= 2.7.0

DEPLOYER_IMG=$(DOCKER_HUB_REPO)/$(DOCKER_HUB_DEPLOYER_IMAGE):$(DOCKER_HUB_DEPLOYER_TAG)
TESTER_IMAGE ?= $(DOCKER_HUB_REPO)/tester:$(DOCKER_HUB_DEPLOYER_TAG)

.DEFAULT_GOAL=container
WAIT_TIMEOUT ?= 600
container: 
	@echo "Building container: docker build --tag $(DEPLOYER_IMG) -f Dockerfile ."
	docker build --build-arg "MARKETPLACE_TOOLS_TAG=$(MARKETPLACE_TOOLS_TAG)" \
		--tag $(DEPLOYER_IMG) --no-cache -f Dockerfile .

deploy:
	docker push $(DEPLOYER_IMG)
	MARKETPLACE_TOOLS_TAG=$(MARKETPLACE_TOOLS_TAG) mpdev publish \
	  --deployer_image=$(DEPLOYER_IMG) \
	  --gcs_repo=$(GS_BUCKET)/$(GS_VERSION)
install:
	kubectl create ns pxb --dry-run=client -o yaml | kubectl apply -f -
	MARKETPLACE_TOOLS_TAG=$(MARKETPLACE_TOOLS_TAG) mpdev install \
	  --deployer=$(DEPLOYER_IMG) \
	  --parameters='{"name": "pxcentral", "namespace": "pxb", "persistentStorage.storageClassName": "standard","reportingSecret": "ptest"}'
uninstall:
	kubectl -n pxb delete application pxcentral
	kubectl delete namespace pxb
test-container:
	@echo "Building tester container"
	cd apptest/tester && docker build \
	 --platform linux/amd64 \
	--build-arg REGISTRY="/portworx-enterprise" \
	--build-arg TAG="$(DOCKER_HUB_DEPLOYER_TAG)" \
	--tag $(TESTER_IMAGE) --no-cache -f Dockerfile .
	cd ../..

test-deploy:
	docker push $(TESTER_IMAGE)
	cd apptest/tester &&

verify:
	mpdev verify \
	--deployer=$(DEPLOYER_IMG) \
	--wait_timeout=$(WAIT_TIMEOUT)

publish-images:
	./publish_images.sh
helm:
	kubectl create ns pxb
	helm install -n pxb --values=chart/px-central/helm-values.yaml px-central chart/px-central

lint:
	helm lint chart/px-central
# check: lint test-container container test-deploy deploy verify
check: lint container deploy verify
	echo "OK"
wait:
	ns=apptest-iuccwszp
	kubectl get "applications.app.k8s.io/$ns" --namespace="$ns" --output=json
	kubectl get "applications.app.k8s.io/apptest-0p9uo6vs" --namespace="apptest-0p9uo6vs" --output=json
	kubectl get "{}" --namespace="$ns" --selector app.kubernetes.io/name="{}" --output=json
	kubectl -n apptest-zr2wkv50 delete Deployment/pxcentral-post-install-hook Job/pxcentral-post-install-hook
	kubectl -n apptest-zr2wkv50 delete ServiceAccount/default ServiceAccount/px-keycloak-account ServiceAccount/pxcentral-apiserver Role/px-keycloak-role Role/pxcentral-apiserver RoleBinding/px-keycloak-role-binding RoleBinding/pxcentral-apiserver