#!/bin/bash
#
# Install miniconda if necessary
#
# - 2022-08 (D. Regenass) Write original script
# - 2022-09 (S. Ruedisuehli) Refactor
#

# Default options
INSTALL_PREFIX=${PWD}

# Eval command line options
while getopts p: flag; do
    case ${flag} in
        p) INSTALL_PREFIX=${OPTARG};;
    esac
done

# Install conda executable if not yet available
if [[ -v CONDA_EXE ]]; then
    echo "Found a conda executable at: ${CONDA_EXE}"
else
    echo "No conda executable available, fetching Miniconda install script"
    wget -O ${INSTALL_PREFIX}/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash ${INSTALL_PREFIX}/miniconda.sh -b -p ${INSTALL_PREFIX}/miniconda
    source ${INSTALL_PREFIX}/miniconda/etc/profile.d/conda.sh
    conda config --set always_yes yes --set changeps1 no
    conda config --add channels conda-forge
    conda init bash
    conda activate
    rm ${INSTALL_PREFIX}/miniconda.sh
fi
