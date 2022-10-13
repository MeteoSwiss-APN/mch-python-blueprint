#!/bin/bash
#
# Create conda environment with pinned or unpinned run and/or dev requirements
#
# - 2022-08 (D. Regenass) Write original script
# - 2022-09 (S. Ruedisuehli) Refactor; add some options
#

# Default options
ENV_NAME="{{ cookiecutter.project_slug.replace("_", "-") }}"
PYVERSION=3.10
PINNED=true
DEV=false
EXPORT=false
INSTALL=false
FORCE=false
CONDA=conda
HELP=false

help="Usage: $(basename "${0}") [-n NAME] [-P VER] [-u] [-e] [-d] [-i] [-f] [-m] [-h]

Options:
 -n NAME    Env name (-d adds -dev) [default: ${ENV_NAME}]
 -p VER     Python version [default: ${PYVERSION}]
 -u         Use unpinned requirements (minimal version restrictions)
 -e         Export environment files (requires -u)
 -d         Install additional dev requirements
 -i         Install package itself (editable with -d)
 -f         Force overwrite of existing env
 -m         Use mamba instead of conda
 -h         Print this help message and exit
"

# Eval command line options
while getopts n:p:defhimu flag; do
    case ${flag} in
        n) ENV_NAME=${OPTARG};;
        p) PYVERSION=${OPTARG};;
        d) DEV=true;;
        e) EXPORT=true;;
        f) FORCE=true;;
        h) HELP=true;;
        i) INSTALL=true;;
        m) CONDA=mamba;;
        u) PINNED=false;;
        ?) echo -e "\n${help}" >&2; exit 1;;
    esac
done

# Add -dev to env name if -d is passed
${DEV} && ENV_NAME+="-dev"


if ${HELP}; then
    echo "${help}"
    exit 0
fi

echo "Setting up environment for installation"
eval "$(conda shell.bash hook)" || exit  # NOT ${CONDA} (doesn't work with mamba)
conda activate || exit # NOT ${CONDA} (doesn't work with mamba)

# Create new env; pass -f to overwriting any existing one
echo "Creating ${CONDA} environment"
if ! ${FORCE} && $(eval ${CONDA} info --env | \grep -q "^\<${ENV_NAME}\>"); then
    echo "Conda env already exists: ${ENV_NAME} (overwrite with -f)" >&2
    exit 1
fi
${CONDA} create -n ${ENV_NAME} python=${PYVERSION} --yes || exit

# Install requirements in new env
if ${PINNED}; then
    echo "Pinned installation"
    if ! ${DEV}; then
        echo "Prod installation"
        ${CONDA} env update --name ${ENV_NAME} --file requirements/environment.yml || exit
    else
        echo "Dev installation"
        ${CONDA} env update --name ${ENV_NAME} --file requirements/dev-environment.yml || exit
    fi
else
    echo "Unpinned installation"
    ${CONDA} env update --name ${ENV_NAME} --file requirements/requirements.yml || exit
    if ${EXPORT}; then
        echo "Export pinned prod environment"
        ${CONDA} env export --name ${ENV_NAME} --no-builds > requirements/environment.yml || exit
    fi
    if ! ${DEV}; then
        echo "WARNING: Unpinned prod installation!!!" >&2
    else
        echo "Dev installation"
        ${CONDA} env update --name ${ENV_NAME} --file requirements/dev-requirements.yml || exit
        if ${EXPORT}; then
            echo "Export pinned dev environment"
            ${CONDA} env export --name ${ENV_NAME} --no-builds > requirements/dev-environment.yml || exit
        fi
    fi
fi

# Install package itself if requested
if ${INSTALL}; then
    if ! ${DEV}; then
        echo "Regular package installation"
        ${CONDA} run --name ${ENV_NAME} python -m pip install --no-deps . || exit
    else
        echo "Editable package installation"
        ${CONDA} run --name ${ENV_NAME} python -m pip install --no-deps -e . || exit
    fi
fi
