#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

SOURCE_HOST='https://pwr.edu.pl'
SOURCE_PAGE='/uczelnia/informacje-ogolne/materialy-promocyjne/logotyp'

WORKSPACE=$(mktemp --directory --tmpdir='.' tmp.sources.XXXXX)
OUTPUT_DIR='template-PWr'

MYSZKA_URL='https://kmim.wm.pwr.edu.pl/myszka/logotyp/nowy_szablon_maly.tar.xz'


#
# Check required binaries are available
#
TOOLS=( curl loffice unzip tar xz )

for TOOL in "${TOOLS[@]}"; do
    if ! ( command -v "${TOOL}" &> /dev/null ); then
        echo 'Please install necessary dependencies before proceeding.'
        exit 1
    fi
done


#
# Get list of template files
#
SOURCE_URL="${SOURCE_HOST}/${SOURCE_PAGE}"

FILES=( $(curl "${SOURCE_URL}" \
          | grep -Eo 'href="(.+\.pot)"' \
          | grep '2017-03' \
          | cut -d '"' -f 2) )


#
# Process each template
#
pushd "${WORKSPACE}"

for FILE in "${FILES[@]}"; do
    FILE_NAME=$(basename "${FILE}")
    FILE_URL="${SOURCE_HOST}/${FILE}"

    #
    # Fetch the template
    #
    if ! [ -f "${FILE_NAME}" ]; then
        curl -LJO "${FILE_URL}"
    fi

    #
    # Convert the template to Microsoft Office XML format
    #
    loffice --headless --convert-to pptx "${FILE_NAME}"

    #
    # Extract the template files
    #
    unzip -o "${FILE_NAME/.pot/.pptx}" 'ppt/media/*' -d "${FILE_NAME%.pot}"
done

popd


#
# Fetch better HR excellence icon
#
pushd "${WORKSPACE}"

MYSZKA_NAME=$(basename "${MYSZKA_URL}")

if ! [ -f "${MYSZKA_NAME}" ]; then
    curl -LJO "${MYSZKA_URL}"
fi

tar --extract --file "${MYSZKA_NAME}" --verbose 'tex/latex/pwr/'

popd


#
# Save the background files
#
mkdir -p "${OUTPUT_DIR}"

cp "${WORKSPACE}/prezentacja_v1_2017-03_pl/ppt/media/image1.png" "${OUTPUT_DIR}/title-v1-pl.png"
cp "${WORKSPACE}/prezentacja_v1_2017-03_pl/ppt/media/image7.png" "${OUTPUT_DIR}/content-v1-pl.png"

cp "${WORKSPACE}/prezentacja_v1_2017-03_en/ppt/media/image1.png" "${OUTPUT_DIR}/title-v1-en.png"
cp "${WORKSPACE}/prezentacja_v1_2017-03_en/ppt/media/image7.png" "${OUTPUT_DIR}/content-v1-en.png"

cp "${WORKSPACE}/prezentacja_v2_2017-03_pl/ppt/media/image1.png" "${OUTPUT_DIR}/title-v2-pl.png"
cp "${WORKSPACE}/prezentacja_v2_2017-03_pl/ppt/media/image5.png" "${OUTPUT_DIR}/content-v2-pl.png"

cp "${WORKSPACE}/prezentacja_v2_2017-03_en/ppt/media/image1.png" "${OUTPUT_DIR}/title-v2-en.png"
cp "${WORKSPACE}/prezentacja_v2_2017-03_en/ppt/media/image5.png" "${OUTPUT_DIR}/content-v2-en.png"

cp "${WORKSPACE}/tex/latex/pwr/Hr_p1.pdf" "${OUTPUT_DIR}/hr-excellence-v1.pdf"
cp "${WORKSPACE}/tex/latex/pwr/Hr_p2.pdf" "${OUTPUT_DIR}/hr-excellence-v2.pdf"
