#!/bin/bash
#
# Create conda environment with pinned or unpinned run and/or dev requirements
#
# - 2022-08 (D. Regenass) Write original script
# - 2022-09 (S. Ruedisuehli) Refactor; add some options
#

# Default options
ENV_NAME={{cookiecutter.project_slug}}
PYVERSION=3.10
DEV=false
PINNED=false
FORCE=false
CONDA=conda

help="Usage: $(basename "${0}") [-n NAME] [-p VER] [-d] [-p] [-c] [-f] [-c CMD] [-h]

Options:
 -n NAME    Name of the environment [default: ${ENV_NAME}]
 -p VER     Desired Python version [default: ${PYVERSION}]
 -d         Dev (editable) installation with additional dependencies
 -p         Pinned installation with fully fixed dependencies
 -f         Force overwrite of existing env (otherwise interactive)
 -c CMD     Conda command [default: ${CONDA}]
 -h         Print this help message and exit
"

# Eval command line options
while getopts n:v:dph flag; do
    case ${flag} in
        n) ENV_NAME=${OPTARG};;
        p) PYVERSION=${OPTARG};;
        d) DEV=true;;
        p) PINNED=true;;
        f) FORCE=true;;
        c) CONDA=${OPTARG};;
        h) HELP=true;;
    esac
done

if ${HELP}; then
    echo "${help}"
    exit 0
fi

echo "Setting up environment for installation"
eval "$(conda shell.bash hook)"  # NOT ${CONDA} (doesn't work with mamba)
conda activate  # NOT ${CONDA}

# Create new env; pass -f to overwriting any existing one
echo "Creating ${CONDA} environment"
${CONDA} create -n ${ENV_NAME} $(${FORCE} && echo --yes)
${CONDA} install -n ${ENV_NAME} python=${PYVERSION} --yes

# Install requirements in new env
if ${PINNED}; then
    echo "Pinned installation"
    if ! ${DEV}; then
        echo "Prod installation"
        ${CONDA} env update --name ${ENV_NAME} --file requirements/environment.yml
    else
        echo "Dev installation"
        ${CONDA} env update --name ${ENV_NAME} --file requirements/dev-environment.yml
    fi
else
    echo "Unpinned installation"
    ${CONDA} env update --name ${ENV_NAME} --file requirements/requirements.yml
    if ! ${DEV}; then
        echo "WARNING: Unpinned prod installation!!!" >&2
    else
        echo "Dev installation"
        ${CONDA} env update --name ${ENV_NAME} --file requirements/dev-requirements.yml
    fi
fi
