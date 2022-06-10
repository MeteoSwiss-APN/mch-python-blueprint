#!/bin/bash

### OPTION DEFAULTS ###
ENV_NAME={{ cookiecutter.project_slug }}
PYVERSION=3.9
PINNED=false
DEV=false
CLEAN=false
#GET OPTIONS FROM COMMAND LINE ARGS
while getopts n:v:p:d:c flag
do
    case "${flag}" in
        n) ENV_NAME=${OPTARG};;
        v) PYVERSION=${OPTARG};;
        p) PINNED=true;;
        d) DEV=true;;
        c) CLEAN=true;;
    esac
done

# APPEND INSTALL OPTIONS FOR INSTALLER.PY
INSTALL_ARGS=--name=${ENV_NAME}\ --pyversion=$PYVERSION
if [ "$PINNED" = true ]
then
    INSTALL_ARGS=${INSTALL_ARGS}\ --pinned
fi
if [ "$DEV" = true ]
then
    INSTALL_ARGS=${INSTALL_ARGS}\ --dev
fi
if [ "$CLEAN" = true ]
then
    INSTALL_ARGS=${INSTALL_ARGS}\ --clean
fi

# INSTALL CONDA EXCECUTABLE IF NOT AVAILABLE
if [[ -v CONDA_EXE ]]
then
    echo "Found a conda executable at: ${CONDA_EXE}"
else
    echo "No conda executable available, fetching Miniconda install script."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    sh Miniconda3-latest-Linux-x86_64.sh
fi

# INSTALLATION OF ENVIRONMENT
# need to source conda.sh in order to have conda
# commands available if base env is not active.
# https://stackoverflow.com/questions/47246350/conda-activate-not-working
CONDA_EXEDIR="$(dirname "$CONDA_EXE")"
source ${CONDA_EXEDIR}/../etc/profile.d/conda.sh
conda activate
# install conda environment
echo Installing conda environment with options $INSTALL_ARGS
python installer.py $INSTALL_ARGS
# install pip only packages
PREFIX=${CONDA_PREFIX}/envs/${ENV_NAME}/bin
if [[ -f requirements/pip-requirements.in ]]; then
    $PREFIX/pip install -r requirements/pip-requirements.in
fi

# INSTALL PACKAGE
# editable if dev installation.
if [ dev = true ]
then
    $PREFIX/pip install -e .
else
    $PREFIX/pip install .
fi