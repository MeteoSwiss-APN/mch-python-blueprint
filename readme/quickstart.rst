
**********
Quickstart
**********

Create a new project
--------------------

To create a new project and start developing, run these commands:

.. code::

    cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint
    cd <project>
    make format check test CHAIN=1

The cookiecutter command will ask you for some information on you and your project.
The parameter "sample_code" allows you to choose the amount of sample code to be included:

-   'no': No sample code is provided beyond an empty `main()` function in the `cli.py` file.
    This is useful if you are migrating an existing project into a new Blueprint project.
-   'cli': A basic command line interface based on `click <https://click.palletsprojects.com>`__ is pre-defined, including some basic tests.
    This is useful if you start from scratch but hit the ground running in terms of command line options.
-   'calculator': A fully-functional simple program that performs chained calculations, including a class and tests.
    This is useful to explore the Blueprint and the possibilities offered by `click <https://click.palletsprojects.com>`__.

The three explicit make commands do the following (type `make help` for all commands):

-   `make format`: Run pre-commit hooks over all files, which auto-format the code and perform a few checks.
-   `make check`: Run some linters (flake8, pylint, mypy) over the code, which check it for correctness and best practices.
-   `make test`: Run the unit tests.

Thanks to `CHAIN=1`, the following actions are taken in the beginning:

-   Initialize a git repository and commit all files (`make git`).
-   Create a local virtual environment (`make venv`).
-   Install the runtime and development dependencies into it (`make install-dev`).

If all goes well, you are ready to work on your code!

Install a project
-----------------

To install a certain version of a project, follow these steps:

.. code:: bash

    git_dir=...  # e.g., ~/.local/git
    venvs_dir=...  # e.g., ~/.local/venvs
    bin_dir=...  # e.g., ~/.local/bin
    project=...  # e.g., apepi
    version=...  # e.g., v0.2.1
    command1=...  # e.g.,

    # Clone the git repository and check out the target version
    git clone git@github.com:MeteoSwiss-APN/${project} ${git_dir}/${project}
    cd ${git_dir}/${project}
    git checkout ${version}

    # Run the tests and checks (and clean up after them)
    make test-check clean-all CHAIN=1

    # Install the package and its (pinned) dependencies into a virtual env
    venv_dir=${install_root}/venvs/${project}/${version}
    make install CHAIN=1 VENV_DIR=${venv_dir}

    # Make the project's command(s) available system-wide
    cd ${bin_dir}
    ln -s ${venv_dir}/bin/${command1} ${command1}
    # repeat for all commands

    # Test the commands
    cd
    ${command1} --version
    # ...
