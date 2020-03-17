#!/bin/bash

#######################################################
# builder script for tealium-apple-builder
#######################################################

set -e

# set build path to do work in
BUILD_PATH="build"

# parameters passed by run script build phase
TARGET_NAME="$1"
PROJECT_PATH="$2"
DEVICE_TYPE="$3"
SIMULATOR_TYPE="$4"
CONFIGURATION="$5" # Release or Debug
FRAMEWORK="TealiumCrashReporteriOS.framework"
FRAMEWORK_NAME="TealiumCrashReporteriOS"


# recursion avoidance
if [[ $MASTER_SCRIPT_RUNNING ]]
then
exit 0
fi
set -u
export MASTER_SCRIPT_RUNNING=1

echo "Starting build script ${TARGET_NAME}..."

# the script assumes you have tealium-apple-builder and tealium-ios repos at the same directory level
OUTPUT_FOLDER="${PROJECT_DIR}/"            # Builder_Dynamic/../../tealium-ios

echo "Output folder: ${OUTPUT_FOLDER}"
echo "Project directory: ${PROJECT_DIR}"
echo "Project path: ${PROJECT_PATH}"

mkdir -p "${BUILD_PATH}"

# build for devices
xcodebuild -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk "${DEVICE_TYPE}"
# build for simulator
xcodebuild -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk "${SIMULATOR_TYPE}" ONLY_ACTIVE_ARCH=NO

# remove old framework and dSYMs
rm -rf "${OUTPUT_FOLDER}/${FRAMEWORK}"

# copy built framework into output folder. (Note: copying either simulator or device build is needed for lipo.)
cp -r "${BUILD_PATH}/${CONFIGURATION}-${DEVICE_TYPE}/${FRAMEWORK}" "${OUTPUT_FOLDER}/${FRAMEWORK}"

# create the fat framework
lipo -create -output "${OUTPUT_FOLDER}/${FRAMEWORK}/${FRAMEWORK_NAME}" \
    "${BUILD_PATH}/${CONFIGURATION}-${DEVICE_TYPE}/${FRAMEWORK}/${FRAMEWORK_NAME}" \
    "${BUILD_PATH}/${CONFIGURATION}-${SIMULATOR_TYPE}/${FRAMEWORK}/${FRAMEWORK_NAME}" \

echo "Zipping framework for distribution"
zip ${PROJECT_DIR}/"TealiumCrashReporteriOS.framework.zip" ${PROJECT_DIR}/"TealiumCrashReporteriOS.framework"

# copy Swift module mappings for the simulator
if [ -d "${BUILD_PATH}/${CONFIGURATION}-${DEVICE_TYPE}/${FRAMEWORK}/Modules/${FRAMEWORK_NAME}.swiftmodule" ]; then
cp -r "${BUILD_PATH}/${CONFIGURATION}-${DEVICE_TYPE}/${FRAMEWORK}/Modules/${FRAMEWORK_NAME}.swiftmodule/" "${OUTPUT_FOLDER}/${FRAMEWORK}/Modules/${FRAMEWORK_NAME}.swiftmodule"
fi

echo "Builder script done building."
