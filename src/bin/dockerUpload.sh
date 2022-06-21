#!/bin/bash
# set -euo pipefail

####################################################################################################
# run docker with high memory

# test
docker run \
  --rm \
  --volume ~/Factorem/DNAzoo/uploads:/uploads \
  --env JAVA_TOOLS_OPTIONS-"-Xms8G" enasequence/webin-cli \
    -context=genome \
    -userName=Webin-62042 \
    -passwordFile=uploads/.password.txt \
    -outputDir=uploads/report \
    -test \
    -validate \
    -manifest=uploads/manifest/MacropusEugenii

####################################################################################################
