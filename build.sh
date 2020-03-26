#!/bin/bash

PROGNAME=$(basename $0)
VERSION="${PROGNAME} v1.0"
echo
echo ${VERSION}
echo

CURRENT_DIR=`pwd -P`
PROJECT_NAME="soc-empty"
SIMPLICITY_STUDIO_SCRIPT_ABS_DIR="/c/SiliconLabs/SimplicityStudio/v4/developer/scripting"
SIMPLICITY_STUDIO_ADAPTER_PACKS_DIR="/c/SiliconLabs/SimplicityStudio/v4/developer/adapter_packs"
WORKSPACE_DIR="${USERPROFILE}/SimplicityStudio/v4_workspace"
COMMANDER="${SIMPLICITY_STUDIO_ADAPTER_PACKS_DIR}/commander/commander.exe"
GNU_DIR="GNU_ARM_v7.2.1"

GBL_FILE="bootloader-storage-spiflash/${GNU_DIR}/bootloader-storage-spiflash-combined.s37"
APP_FW_S37="${PROJECT_NAME}/${GNU_DIR}/${PROJECT_NAME}.s37"
APP_FW_PLUS_GBL_S37="${PROJECT_NAME}/${GNU_DIR}/${PROJECT_NAME}_gbl.s37"

function ErrorMsg() {
  echo
  echo "Error occurred. Try again!"
  echo
  exit 1
}

echo bash "${SIMPLICITY_STUDIO_SCRIPT_ABS_DIR}/runScript.sh" -data "${WORKSPACE_DIR}" "${CURRENT_DIR}/scripts/BuildExistingProject_v2.py" ${PROJECT_NAME}
bash "${SIMPLICITY_STUDIO_SCRIPT_ABS_DIR}/runScript.sh" -data "${WORKSPACE_DIR}" "${CURRENT_DIR}/scripts/BuildExistingProject_v2.py" ${PROJECT_NAME}
if [ $? -ne 0 ]; then
  ErrorMsg
fi

echo "${COMMANDER}" convert "${GBL_FILE}" "${APP_FW_S37}" --outfile "${APP_FW_PLUS_GBL_S37}"
"${COMMANDER}" convert "${GBL_FILE}" "${APP_FW_S37}" --outfile "${APP_FW_PLUS_GBL_S37}"
if [ $? -ne 0 ]; then
  ErrorMsg
fi

echo
echo Binaries have been generated in ${CURRENT_DIR}/${PROJECT_NAME}
