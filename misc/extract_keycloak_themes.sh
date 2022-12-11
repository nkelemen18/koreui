#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TARGET_DIR=${DIR}/../themes/extracted_keycloak_themes
echo "Extract themes to: ${DIR}"

rm -rf "${TARGET_DIR}"
mkdir -p "${DIR}/../themes/"

# shellcheck disable=SC2154
# shellcheck disable=SC2086
docker cp $jar koreui-dev-keycloak-1:/opt/keycloak/lib/lib/main/org.keycloak.keycloak-themes-20.0.1.jar "${TARGET_DIR}"
echo "Extract finished"
