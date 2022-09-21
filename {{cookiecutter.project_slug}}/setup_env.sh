#!/bin/bash
#
# Create conda environment with pinned or unpinned run and/or dev requirements
#
# - 2022-08 (D. Regenass) Write original script
# - 2022-09 (S. Ruedisuehli) Refactor; add -f
#

# Default options
ENV_NAME={{cookiecutter.project_slug}}
PYVERSION=3.10
DEV=false
PINNED=false
FORCE=false

# Eval command line options
while getopts n:v:dph flag; do
    case ${flag} in
        n) ENV_NAME=${OPTARG};;
        v) PYVERSION=${OPTARG};;
        d) DEV=true;;
        p) PINNED=true;;
        f) FORCE=true;;
        h) HELP=true;;
    esac
done

if ${HELP}; then
    echo "Usage: $(basename "${0}") [-n <env_name>] [-v <python_version>] [-d] [-p] [-c] [-h]

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
eval "$(conda shell.bash hook)"
conda activate

# Create new env; pass -f to overwriting any existing one
echo "Creating conda environment"
conda create -n ${ENV_NAME} python=${PYVERSION} $(${FORCE} && echo --yes)

# Install requirements in new env
if ${PINNED}; then
    echo "Pinned installation"
    if ! ${DEV}; then
        echo "Prod installation"
        conda env update --name ${ENV_NAME} --file requirements/environment.yml
    else
        echo "Dev installation"
        conda env update --name ${ENV_NAME} --file requirements/dev-environment.yml
    fi
else
    echo "Unpinned installation"
    conda env update --name ${ENV_NAME} --file requirements/requirements.yml
    if ! ${DEV}; then
        echo "WARNING: Unpinned prod installation!!!" >&2
    else
        echo "Dev installation"
        conda env update --name ${ENV_NAME} --file requirements/dev-requirements.yml
    fi
fi
