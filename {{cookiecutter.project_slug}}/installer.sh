#!/bin/bash

### OPTION DEFAULTS ###
ENV_NAME={{cookiecutter.project_slug}}
PYVERSION=3.10
DEV=false
PINNED=false
#GET OPTIONS FROM COMMAND LINE ARGS
while getopts n:v:dph flag
do
    case ${flag} in
        n) ENV_NAME=${OPTARG};;
        v) PYVERSION=${OPTARG};;
        d) DEV=true;;
        p) PINNED=true;;
        h) HELP=true;;
    esac
done

if [ "$HELP" = true ]; then
    echo "Usage: $(basename "$0") [-n <env_name>] [-v <python_version>] [-d] [-p] [-c] [-h]

    With:
    -n Name of the environment
    -v Desired Python version
    -d Dev (editable) installation with additional dependencies.
    -p Pinned installation with fully fixed dependencies.
    -h Print this help message and exit.
    "
    exit 0
fi

echo "Setting up environment for installation"
#SOME PREPARATIONS
eval "$(conda shell.bash hook)"
conda activate

#CREATE ENV
echo "Creating conda environment."
conda create -n ${ENV_NAME} python=${PYVERSION} -y

#INSTALL, FOUR OPTIONS: PINNED/ UNPINNED * DEV/ PROD
if [ "$PINNED" = true ]; then
    echo "Pinned installation."
    if [ "$DEV" = true ]; then
        echo "Dev installation."
        conda env update --name ${ENV_NAME} --file requirements/dev-requirements.txt
    else
        echo "Prod installation"
        conda env update --name ${ENV_NAME} --file requirements/requirements.txt
    fi
else
    echo "unpinned installation"
    conda env update --name ${ENV_NAME} --file requirements/requirements.yml
    if [ "$DEV" = true ]; then
        echo "Dev installation"
        conda env update--name ${ENV_NAME} --file requirements/dev-requirements.yml
    else
        echo "WARNING: Unpinned prod installation!!!"
    fi
fi

conda activate ${ENV_NAME}
#PIP DEPENDENCIES
${CONDA_PREFIX}/bin/python -m pip install -U pip
PIP_REQUIREMENTS=requirements/pip-requirements.in
if [ -f $PIP_REQUIREMENTS ]; then
    echo "pip dependencies"
    ${CONDA_PREFIX}/bin/python -m pip install --requirement ${PIP_REQUIREMENTS}
fi
#INSTALL PACKAGE
echo "Installing package ..."
if [ "$DEV" = true ]; then
    ${CONDA_PREFIX}/bin/python -m pip install --editable .
else
    ${CONDA_PREFIX}/bin/python -m pip install .
fi