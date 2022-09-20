
##############
Python at CSCS
##############

How to set up and use Python at CSCS.

All development should be conducted in (project-specific) virtual environments, hence only a bare-bones Python installation is provided that only includes Python, Pip, and Pipx.


Set Up Environment
==================

On tsa/arolla
-------------

Add the following commands to your `.bashrc`:

.. code:: bash

    # Load pristine Python environment
    source "/users/osm/.opr_setup_dir"
    source "${OPR_SETUP_DIR}/.python_base"
    unset PYTHONPATH

    # Access installed Python tools
    export PYTHONUSERBASE="/apps/mch/msopr/osm/python/"
    export PATH="${PYTHONUSERBASE}/bin:${PATH}"

    # Access installed tools (Python and others)
    export PATH="/users/osm/bin:${PATH}"

.. note::
    Unsetting `${PYTHONPATH}` is not strictly necessary, but good practice to ensure that virtual environments are isolated from the system environment.

.. note::
    The Python tools are installed in `/apps/mch/msopr/osm/python/bin/`.
    A wider range of standard tools is installed in `/users/osm/bin/`, including links to the Python tools in the former path.
    So depending on your needs (whether you only need the Python tools or other tools as well) you may use either of both paths.

This changes the environment as follows (as of late November 2020):

.. code:: console

    $ module list
    Currently Loaded Modulefiles:
      1) slurm/20.02.5

    $ source "/users/osm/.opr_setup_dir"

    $ source "${OPR_SETUP_DIR}/.python_base"

    $ module list
    Currently Loaded Modulefiles:
      1) slurm/20.02.5                 10) scalapack/2.0.2-gompi-2019b
      2) gcccore/.8.3.0                11) foss/.2019b
      3) zlib/.1.2.11-gcccore-8.3.0    12) PrgEnv-gnu/19.2-nocuda
      4) binutils/.2.32-gcccore-8.3.0  13) bzip2/.1.0.8
      5) gcc/8.3.0                     14) ncurses/.6.1
      6) openmpi/4.0.2-gcc-8.3.0       15) libreadline/.8.0
      7) openblas/0.3.7-gcc-8.3.0      16) python/3.7.4
      8) gompi/.2019b                  17) geos/3.7.2-foss-2019b
      9) fftw/3.3.8-gompi-2019b        18) proj/6.1.1-foss-2019b

.. note::
    If cookiecutter is not available after setting up this environment, install it with pipx, which should now be available:

    .. code:: bash

        pipx install cookiecutter
        cookiecutter -V

    If pipx is not available either, get in touch with `OSM <mailto:osm@meteoswiss.ch>`__ and, in the meantime, install it manually into a temporary virtual environment:

    .. code:: bash

        python -m venv venvs/cookiecutter
        venvs/cookiecutter/bin/python -m pip install cookiecutter
        venv/cookiecutter/bin/cookiecutter -V

