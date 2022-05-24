#!/bin/bash
set -euo pipefail

####################################################################################################
# run docker with high memory

# retrieve fields
docker run \
  --rm \
  --volume ~/Factorem/DNAzoo/uploads:/uploads \
  --env JAVA_TOOLS_OPTIONS-"-Xms2G" enasequence/webin-cli \
    -context=genome \
    -fields

####################################################################################################
