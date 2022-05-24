#!/bin/bash
set -euo pipefail

####################################################################################################
# run docker with high memory

# webin cli help
docker run \
  --rm \
  --volume ~/Factorem/DNAzoo/uploads:/uploads \
  --env JAVA_TOOLS_OPTIONS-"-Xms2G" enasequence/webin-cli \
    -help

####################################################################################################
