#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TARGET_DIR=${DIR}/../extracted_keycloak_themes
TMP_FILE=${TARGET_DIR}/tmp.jar
echo "Extract themes to: ${DIR}"

echo "Get theme path from Docker image"
THEME_FILE_PATH=$(MSYS_NO_PATHCONV=1 docker container exec -it koreui-dev-keycloak-1 "/opt/misc/get_theme_path.sh")

echo "Found theme: ${THEME_FILE_PATH}"

rm -rf "${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"


# shellcheck disable=SC2154
# shellcheck disable=SC2086
docker cp "koreui-dev-keycloak-1:${THEME_FILE_PATH}" "${TMP_FILE}"

echo "Unzip tmp file: ${TMP_FILE}"
unzip "$TMP_FILE" -d "$TARGET_DIR"

echo "Remove tmp file"
rm "$TMP_FILE"

echo "Extract finished"
