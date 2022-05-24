#!/bin/bash
# set -euo pipefail

####################################################################################################

# config
source "${HOME}/Factorem/DNAzoo/src/config/config.sh"

####################################################################################################

for file in $( command ls "${fastqDir}" )
do

  # log
  echo "${file}"

  # decompress, convert & recompress
  gzip --keep --decompress "${fastqDir}/${file}" | \
  awk -f "${utilDir}/fastqConvert.awk" - | \
  gzip - > "${fastaDir}/${file/fastq/fasta}"

done

####################################################################################################
