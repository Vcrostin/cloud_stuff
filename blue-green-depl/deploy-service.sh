#!/bin/bash

REGISTRY="cr.yandex"
REPO_ID="crpvjki4829dbb6omp95"
SERVICE_NAME="cloud-hw-3"
VERSION="latest"

# 1. Авторизуемся в YCR
yc container registry configure-docker

# 2. Скачиваем образ
docker pull ${REGISTRY}/${REPO_ID}/${SERVICE_NAME}:${VERSION}

# 3. Останавливаем старый контейнер (если есть)
docker stop ${SERVICE_NAME} || true
docker rm ${SERVICE_NAME} || true

# 4. Запускаем новый
docker run -d \
  --name ${SERVICE_NAME} \
  -p 8000:8000 \
  ${REGISTRY}/${REPO_ID}/${SERVICE_NAME}:${VERSION}

echo "Service deployed: ${VERSION}"
