####################################################################################################

_default:
  @just --list

####################################################################################################

# print justfile
@show:
  bat .justfile --language make

####################################################################################################

# edit justfile
@edit:
  micro .justfile

####################################################################################################

# fastq => fasta
@fastqConvert:
  source src/preprocess/fastqConvert.sh

####################################################################################################

# collect scaffolds
collectScaffolds:
  #!/bin/bash
  set -euo pipefail

  # declarations
  source .just.sh

  echo "Building..."
  go build -v -o ${proj}/excalibur/collectScaffolds ${util}/collectScaffolds.go

  # ${exec}/collectScaffolds .justfile

  # source src/preprocess/collectScaffolds.sh

####################################################################################################
