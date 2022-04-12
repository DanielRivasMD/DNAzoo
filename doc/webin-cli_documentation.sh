#!/bin/bash
set -euo pipefail

####################################################################################################

-context=TYPE                           Submission type: genome, transcriptome, sequence, reads, taxrefset
-manifest=FILE                          Manifest text file containing file and metadata fields.
-userName, -username=USER               Webin submission account name or e-mail address.
-password=PASSWORD                      Webin submission account password.
-passwordFile=FILE                      File containing the Webin submission account password.
-passwordEnv=VAR                        Environment variable containing the Webin submission account password.
-inputDir, -inputdir=DIRECTORY          Root directory for the files declared in the manifest file. By default the current working directory is used as the input directory.
-outputDir, -outputdir=DIRECTORY        Root directory for any output files written in <context>/<name>/<validate,process,submit> directory structure. By default the manifest file directory is used as the output directory. The <name> is the unique name from the manifest file. The validation reports are written in the <validate> sub-directory.
-centerName, -centername=CENTER         Mandatory center name for broker accounts.
-validate                               Validate files without uploading or submitting them.
-quick                                  Validates submitted read files (BAM, CRAM, Fastq) within a fixed time period (5 minutes). All CRAM reference sequence md5 checksums are always validated. When this option is used files may only be partially validated and may fail post-submission processing.
-submit                                 Validate, upload and submit files.
-test                                   Use the test submission service.
-ascp                                   Use Aspera (if Aspera Cli is available) instead of FTP when uploading files. The path to the installed "ascp" program must be in the PATH variable.
-help                                   Show this help message and exit.
-fields                                 Show manifest fields for all contexts or for the given -context.
-version                                Print version information and exit.

####################################################################################################
