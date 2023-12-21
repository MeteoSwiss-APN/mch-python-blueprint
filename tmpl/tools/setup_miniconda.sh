#!/bin/bash
#
# Install miniconda if necessary


if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
  echo "Please simply call the script instead of sourcing it!"
  return
fi

# Default options
INSTALL_PREFIX=${PWD}
USER_INSTALL=false

# here the conda version is fixed, the sha256 hash has to be set accordingly
MINICONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-py310_23.9.0-0-Linux-x86_64.sh
SHA256=b272a5f843762f0a18f6b70a162cd554a43a06adcd6f5a2102840e41907fffe5


# Eval command line options
while getopts p:u  flag; do
    case ${flag} in
        p) INSTALL_PREFIX=${OPTARG};;
        u) USER_INSTALL=true;;
    esac
done

# Install conda executable if not yet available
if [[ -f $CONDA_EXE ]]; then
    echo "Found a conda executable at: ${CONDA_EXE}"
else
    echo "No conda executable available, fetching Miniconda install script"
    wget -O ${INSTALL_PREFIX}/miniconda.sh ${MINICONDA_URL}
    echo "${SHA256}  ${INSTALL_PREFIX}/miniconda.sh" | sha256sum --check || exit 1
    bash ${INSTALL_PREFIX}/miniconda.sh -b -p ${INSTALL_PREFIX}/miniconda
    source ${INSTALL_PREFIX}/miniconda/etc/profile.d/conda.sh
    conda config --set always_yes yes --set changeps1 no
    conda config --add channels conda-forge
    if ${USER_INSTALL}; then
      conda init bash
    else
      # this is a workaround as plain --no-user is not working as it should
      conda init bash --no-user --install --system
    fi
    conda activate
    rm ${INSTALL_PREFIX}/miniconda.sh
fi
