#!/bin/bash

set -eu

SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[@]}")")


ZIP_PATH="/tmp/ksef-pdf-generator.zip"

# shellcheck disable=SC1091
source "${SCRIPT_DIR}/config.bash"


if [[ -f "${PDF_GENERATOR_BIN_PATH}" ]]; then
    echo "Generator already installed in: ${PDF_GENERATOR_BIN_PATH}"
    exit 0
fi


wget -O "${ZIP_PATH}" https://github.com/Kamilcuk/ksef-pdf-generator/archive/refs/heads/main.zip

## -o -- override without prompting
unzip -o "${ZIP_PATH}" -d "/tmp"

mkdir -p "${PDF_GENERATOR_PATH}"

mv "/tmp/ksef-pdf-generator-main"/* "${PDF_GENERATOR_PATH}"

cd "${PDF_GENERATOR_PATH}"

npm install
npm run build:exe

echo
echo "Generator installed in: ${PDF_GENERATOR_BIN_PATH}"
