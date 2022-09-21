#!/bin/bash
#
# Create conda environment with pinned or unpinned run and/or dev requirements
#
# - 2022-08 (D. Regenass) Write original script
# - 2022-09 (S. Ruedisuehli) Refactor; add some options
#

# Default options
ENV_NAME={{ cookiecutter.project_slug.replace("_", "-") }}
PYVERSION=3.10
DEV=false
PINNED=false
INSTALL=false
FORCE=false
CONDA=conda
HELP=false

help="Usage: $(basename "${0}") [-n NAME] [-P VER] [-d] [-p] [-c] [-f] [-c CMD] [-h]

Options:
 -n NAME    Env name (-d adds -dev) [default: ${ENV_NAME}]
 -P VER     Python version [default: ${PYVERSION}]
 -d         Install additional dev requirements
 -p         Use pinned requirements (fixed versions)
 -i         Install package itself (editable with -d)
 -f         Force overwrite of existing env
 -c CMD     Conda command [default: ${CONDA}]
 -h         Print this help message and exit
"

# Eval command line options
while getopts c:n:P:dfhip flag; do
    case ${flag} in
        c) CONDA=${OPTARG};;
        n) ENV_NAME=${OPTARG};;
        P) PYVERSION=${OPTARG};;
        d) DEV=true;;
        f) FORCE=true;;
        h) HELP=true;;
        i) INSTALL=true;;
        p) PINNED=true;;
    esac
done

# Add -dev to env name if -d is passed
${DEV} && ENV_NAME+="-dev"

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

# Install package itself if requested
if ${INSTALL}; then
    if ! ${DEV}; then
        echo "Regular package installation"
        ${CONDA} run --name ${ENV_NAME} python -m pip install --no-deps .
    else
        echo "Editable package installation"
        ${CONDA} run --name ${ENV_NAME} python -m pip install --no-deps -e .
    fi
fi
