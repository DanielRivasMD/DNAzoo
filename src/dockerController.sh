#!/bin/bash
set -euo pipefail

####################################################################################################
# run docker with high memory

# webin cli help
docker run --rm -v ~/Factorem/DNAzoo/uploads:/data -e JAVA_TOOLS_OPTIONS-"-Xms2G" enasequence/webin-cli -help

# retrieve fields
docker run --rm -v ~/Factorem/DNAzoo/uploads:/data -e JAVA_TOOLS_OPTIONS-"-Xms2G" enasequence/webin-cli -context=genome -fields

####################################################################################################
