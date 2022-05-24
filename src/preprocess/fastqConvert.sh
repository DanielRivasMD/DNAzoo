#!/bin/bash
# set -euo pipefail

####################################################################################################

# config
source "${HOME}/Factorem/DNAzoo/src/config/config.sh"

####################################################################################################

for ƒ in $(command ls "${fastqDir}" )
do

  # log
  echo "${ƒ}"

  # decompress, convert & recompress
  gzip --keep --decompress "${fastqDir}/${ƒ}" | \
  awk -f "${utilDir}/fastqConvert.awk" - | \
  gzip - > "${fastaDir}/${ƒ/fastq/fasta}"

done

####################################################################################################
