#!/bin/bash

### OPTION DEFAULTS ###
INSTALL_PREFIX=$PWD
#GET OPTIONS FROM COMMAND LINE ARGS
while getopts p: flag
do
    case ${flag} in
        p) INSTALL_PREFIX=${OPTARG};;
    esac
done

# INSTALL CONDA EXCECUTABLE IF NOT AVAILABLE
if [[ -v CONDA_EXE ]]
then
    echo "Found a conda executable at: ${CONDA_EXE}"
else
    echo "No conda executable available, fetching Miniconda install script."
    wget -O {$INSTALL_PREFIX}/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash miniconda.sh -b -p $WORKSPACE/miniconda
    source ${CONDA_EXEDIR}/../etc/profile.d/conda.sh
    conda config --set always_yes yes --set changeps1 no
    conda config --add channels conda-forge
    conda init bash
    conda activate
    rm miniconda.sh
fi