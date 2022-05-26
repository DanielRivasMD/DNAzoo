#!/bin/bash
# set -euo pipefail

####################################################################################################

# config
source "${HOME}/Factorem/DNAzoo/src/config/config.sh"

####################################################################################################

for file in $( command ls "${assemblyDir}" )
do

  # log
  echo "${file}"

  # decompress, convert & recompress
  zmore "${assemblyDir}/${file}" | \
  awk -f "${utilDir}/collectScaffolds.awk" - | \
  gzip - > "${chrList}/${file/.fasta/}"

done

####################################################################################################
