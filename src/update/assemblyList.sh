#!/bin/bash
set -euo pipefail

####################################################################################################

# config
source "${HOME}/Factorem/DNAzoo/src/config/config.sh"

####################################################################################################

python3 "${updateDir}/assemblyList.py"

####################################################################################################
