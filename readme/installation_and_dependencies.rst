
*****************************
Installation and dependencies
*****************************

Recap: How to create a new project with a virtual environment
-------------------------------------------------------------

Say we want to create a calculator, starting from the sample code in the Blueprint (``sample_code=3``).
First, we create the repository ``calculator`` on `Github <https://github.com/MeteoSwiss-APN>`__, and then create an empty package of the same name using the blueprint and upload it:

.. code:: bash

    cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint
    # project_slug=calculator
    cd calculator
    make git
    git remote add origin git@github.com:MeteoSwiss-APN/calculator.git
    git push --set-upstream origin master

Then, we create and activate a virtual environment for development:

.. code:: bash

    make install-dev CHAIN=1

Now that we are in a project-specific, pristine Python environment, we are ready to go!

.. note::
    The following examples use the virtual environment explicitly (e.g., ``./venv/bin/python -m pip ...``).
    If you prefer to actiate the virtual environment in order to omit the ``./venv/bin/`` paths, you may do so with ``source ./venv/bin/activate``.

How to install the project and its dependencies
-----------------------------------------------

The most basic command to install your local project along with up-do-date versions of its runtime dependencies is:

.. code:: bash

    python -m pip install .

However, for all the reasons already mentioned you want to run this in a virtual environment.
Furthermore, to ensure reproducibility, you want to use pinned dependencies (if provided by the project).
Those are conventionally provided in the file requirements.txt (which is requirements/run-pinned.txt in the Blueprint).
Let's put it all together:

   .. code:: make

    python -m venv venv
    ./venv/bin/python -m pip install -U pip
    ./venv/bin/python -m pip install -r requirements/run-pinned.txt
    ./venv/bin/python -m pip install .

In Blueprint projects, this can be achieved with a single command:

.. code:: bash

    make venv install
    # or
    make install CHAIN=1

The source files are copied into the virtual environment, which is what you want when installing the package for deployment so you can remove the clone of the repository after installation.
However, this is not suitable for development, when you'd like to see changes to the source files immediately applied without having to rerun ``make venv``.
Therefore, the Makefile provides a second command that installs the package in editable mode, which means that links to (rather than copies of) the source files are installed into the virtual environment:

.. code:: bash

    make install-dev

.. note::
    Add ``CHAIN=1`` to also create the virtual environment if necessary.

This is short for:

   .. code:: make

    ./venv/bin/python -m pip install -r requirements/dev-pinned.txt
    ./venv/bin/python -m pip install -e .
    ./venv/bin/pre-commit install

In addition, this also installs the pinned development dependencies specified in ``requirements/dev-pinned.txt`` (a superset of the pinned runtime dependencies), and activate the pre-commit hooks (more on those later).

How to install a project for deployment
---------------------------------------

A very simple way to installing a project for usage only is with `Pipx <https://github.com/pipxproject/pipx>`__:

.. code:: bash

    pipx install https://github.com/MeteoSwiss-APN/apepi@v0.2.1

With only one line of code, pipx creates a designated virtual environment for the project, installs the project and it's dependencies in there and links the commands provided by the project to a ``bin``-folder that is in ``$PATH`` so the commands are accessible system-wide.
It is a great, handy tool to quickly install and/or test some tools.

However, does have its limitations, among them that it doesn't automatically use pinned dependencies.
While there are ways around that, given that Pipx only replaces a handful of commands during package installation, manual installation is the ultimately more suitable and transparent approach to deploy specific versions of tools.

Let's demonstrate manual installation step-by-step.
First, let's define some temporary variables to make the code examples below better readable:

.. code:: bash

    git_dir=...  # e.g., ~/.local/git
    install_root=...  # e.g., ~/.local/venvs
    bin_dir=...  # e.g., ~/.local/bin
    project=...  # e.g., apepi
    version=...  # e.g., v0.2.1
    command1=...  # e.g.,

First, clone the repository of the project and check out the version to be installed:

.. code:: bash

    git clone git@github.com:MeteoSwiss-APN/${project} ${git_dir}/${project}
    cd ${git_dir}/${project}
    git checkout ${version}

To make sure that everything works as expected, you may want to run the tests and checks (and clean up after them):

.. code:: bash

    make test-check clean-all CHAIN=1

Next, install the package and its (pinned) dependencies into a virtual environment:

.. code:: bash

    venv_dir=${install_root}/venvs/${project}/${version}
    make install CHAIN=1 VENV_DIR=${venv_dir}

If you prefer, you can now remove the clone of the repository (e.g., if it adds too much to your file quota).
However, it may be handy to keep the repositories of installed projects around to more easily update to new versions later.

Now, the project and it's commands are installed, but we still don't have global access to them.
For this, we symlink them to a location that is in the system path (``${PATH}``):

.. code:: bash

    cd ${bin_dir}
    ln -s ${venv_dir}/bin/${command1} ${command1}

In case you install multiple versions of the same commands, just add the version number:

.. code:: bash

    ln -s ${venv_dir}/bin/${command1} ${command1}-${version}

Finally, to ensure that it worked as planned, test the commands (if only by showing their version):

.. code:: bash

    # Test the command
    cd
    ${command1} --version

Types of dependencies
---------------------

There are two main characteristics by which dependencies are grouped: version specificity and purpose.
In terms of version specificity, we distinguish unpinned and pinned dependencies:

-   **Unpinned dependencies** comprise only top-level dependencies, i.e., only those directly used, but now their dependencies, and their versions are as unrestricted as possible, e.g., a minimum version may be specified in case of a security bugfix or the introduction of a necessary feature.
    They are easy to maintain and facilitate keeping the environment up-to-date, as the newest package versions are always installed.
    On the flip side, envirnonments specified with unpinned dependencies are non-reproducible and thus cannot be guarantieed to work as new package versions may introduce conflicts or bugs.
-   **Pinned dependencies** comprise both direct and indirect dependencies, i.e., the whole dependency tree, with specific version numbers.
    This allows for reproducible environments than are guarantieed to work but will inevitably become outdated.

Pinned and unpinned dependencies are best used in combination: Direct dependencies are specified in unpinned formed and used to create an up-to-date environment that can be thoroughly tested and, once guaranteed to work, is pinned and distributed for used in production.
By periodically repeating this, an environment can be provided that is both up-to-date and guaranteed to work.

In terms of their purpose, the following types of dependencies are generally distinguished:

-   **Runtime dependencies** are required to run a tool, i.e., those packages directly imported in the source code.
-   **Development dependencies** are additional packages that are used during development and testing, such as formatters, linters and testing frameworks.
-   Finally, **setup dependencies** are packages required during installation and therefore must be present beforehand, either by pre-installing them on the target system or by specifying them in *pyproject.toml*, a relatively recent addition to Python packaging that allows for using arbitrary setup frameworks.
    A common setup dependency is Cython, a Python superset that introduces C functionality and code compilation and which is used by, e.g., Cartopy.

How to specify dependencies in Python projects
----------------------------------------------

In Python projects using the standard packaging framework Setuptools, the unpinned runtime dependencies should be specified in the file ``setup.py`` or ``setup.cfg``.
These are used when installing the package with Pip, and should therefore not be pinned by default in case the environment contains other packages with shared dependencies, which would quickly lead into dependency hell.
Other dependency types are commonly specified in so-called requirements files, which are plain text files that contain package names with optional version restrictions.
They can be passed to Pip

.. code:: bash

    ./venv/bin/python -m pip -r requirements.txt

Conventionally, many projects contain a file called ``requirements.txt`` that contains the pinned runtime dependencies.
However, there are no restrictions regarding the number and names of requirement files, or whether they contain pinned or unpinned dependencies.

In the Blueprint, the different types of dependencies are defined in the following files:

-   **pyproject.toml**: Setup requirements (preferentially pinned), installed temporarily during the installation of the project with Pip.
-   **setup.py**: Unpinned runtime dependencies, installed when installing the project with Pip.
-   **requirements/dev-unpinned.txt**: Unpinned development dependencies to be explicitly installed with Pip as described below.
-   **requirements/run-pinned.txt**: Pinned runtime dependencies to be explicitly installed with Pip.
-   **requirements/dev-pinned.txt**: Pinned development and runtime dependencies, i.e., a superset of **run-pinned.txt** to be explicitly installed with Pip.

The file setup.py is a simple Python script that can be adapted to a project as desired.

.. note::
    To guarantee a working environment, manually clone the repository, install the pinned runtime dependencies in your (virtual) environment, and only then install the tool itself.

.. note::
    Instead of managing dependencies manually with requirements files during development, many projects use the third-party tool Pipenv, which naturally distinguishes runtime and development dependencies and automatically handles pinning.
    In addition to dependencies, Pipenv also handles virtual environments, thus rendering direct usage of venv and Pip obsolete.
    However, even projects using Pipenv should still supply the pinned runtime dependencies in a standard requirements file for deployment in order not to make Pipenv an installation dependency.

How can use my project in another project?
------------------------------------------

You may want to add your project as a dependency in another project. There are several ways to accomplish this:

1.  install your project with pip in a virtual environment

    .. code:: bash

        ./venv/bin/python -m pip install git+ssh://git@github.com/MeteoSwiss-APN/yourproject

2.  add your project to the dependencies of another project

   - in the ``setup.py`` file of another project (for runtime dependencies):

        .. code:: bash

            "yourproject@git+ssh://git@github.com/MeteoSwiss-APN/yourproject>=v1.0.0"

   - in a requirements file of another project, e.g. ``requirements/dev-unpinned.txt`` (for unpinned development dependencies):

        .. code:: bash

            yourproject@git+ssh://git@github.com/MeteoSwiss-APN/yourproject


How can I manage my dependencies with Pipenv instead of ``venv+pip``?
---------------------------------------------------------------------

`Pipenv <https://github.com/pypa/pipenv>`__ is a tool to manage both virtual environments and package installation via a unified interface.
Instead of one or more requirements files, Pipenv unifies all dependencies in a single file called `Pipfile <https://github.com/pypa/pipfile>`__, which contains unpinned runtime and development dependencies.
It is managed by Pipenv but can also be edited manually.
When pinning dependencies (called *locking*), Pipenv creates the file Pipfile.lock (which should not be edited manually).

Pipfile contains separate sections for development and runtime dependencies.
It is advantageous, however, not to specify the unpinned runtime dependencies in Pipfile, but instead to leave them in setup.py and specifying the project itself in editable form as the sole runtime dependency with

.. code:: bash

    pipenv install -e .

This prevents Pipenv from becoming a setup dependency of the project and allows developers to switch between Pipenv and venv+pip with minimal effort.

Because Pipenv manages virtual environments, it should be installed externally to the project.
A simple way to install Pipenv user-wide is with `Pipx <https://github.com/pipxproject/pipx>`__:

.. code:: bash

    pipx install pipenv

This installs Pipenv and its dependencies into a designated virtual environment and makes the command ``pipenv`` available user-wide (see `Deployment <deployment.rst>`__).

To switch from venv+pip to Pipenv in a Blueprint project, follow these steps:

#.  Leave the unpinned runtime dependencies in setup.py.

#.  Install the local project in editable form:

    .. code:: bash

        pipenv install -e .

    This will create a virtual environment and a Pipfile with the local project as the sole top-level runtime dependency listed in the ``[packages]`` section, install the local project and all dependencies specified in the file setup.py into the virtual environment, and then pin (or *lock*) the dependencies by writing the whole package tree in the virtual environment to the file Pipfile.lock.

    .. note::
        If you look into the Pipfile, it is possible that the package name will be wrongly diagnosed, for example as:

        .. code::

            [packages]
            virtualenv = {editable = true, path = "."}

        instead of:

        .. code::

            [packages]
            random_star_wars = {editable = true, path = "."}

        You can either fix this manually by editing the Pipfile, or just ignore it.

#.  Install the development dependencies:

    .. code:: bash

        pipenv install --dev -r requirements/dev-unpinned.txt

    This will add these packages to the ``[dev-packages]`` section in the Pipfile, install them to the virtual environment, and again pin the dependency tree to Pipfile.lock (whereby the additional development dependencies will be marked as such thanks to ``--dev``).

    .. note::
        You may run into trouble with some packages that do not have a nominally stable release yet, notably the (well-established) auto-formatter `Black <https://github.com/psf/black>`__ that is also a default development dependency of the Blueprint:

        .. code::

            ERROR: Could not find a version that matches black ...
            Skipped pre-versions: 18.3a0, 18.3a0, 18.3a1, ...

        The problem is that Pipenv by default does not install pre-release versions unless explicitly told to, even if there is no stable version.
        There is currently `no clean solution to this <https://github.com/pypa/pipenv/issues/1760>`__, only imperfect workarounds:

        -   The respective package is pinned to a specific version:

            .. code::
                black = "==20.8b1"

            However, this will prevent the package from being updated with ``pipenv update``, and -- more problematically -- will still fail if the package is a sub-dependency of another dependency (e.g., flaks8-black).

        -   Pipenv can be told to globally pre-release versions for all packages with:

            .. code::

                [pipenv]
                allow_prereleases = true

            However, this may cause problems with packages with pre-release versions that are not as stable as the Black pre-releases.

        For some projects, this issue is reason enough not to use Pipenv.

Even if you use Pipenv during development, you should still supply the pinned runtime dependencies in a standard requirements file for deployment in order not to make Pipenv an installation dependency.
They can be produced as follows:

.. code:: bash

    pipenv lock --keep-outdated -r > requirements/run-pinned.txt

.. note::

    The flag ``keep-outdated`` is crucial for reproducible builds because without it, ``pipenv lock`` updates the dependencies to the newest versions before they are written to the requirements file.

To switch the project back from Pipenv to venv+pip, follow these steps:

#.  Assuming you have kept the unpinned runtime dependencies in setup.py, nothing needs to be done about them.
    Otherwise, move them back from the Pipfile section ``[packages]`` into setup.py.

#.  Move the unpinned development dependencies back from the Pipfile section ``[dev-packages]`` into requirements/dev-unpinned.txt.

#.  Unless you want to update your pinned dependencies, transfer those locked by Pipenv into requirements files:

    .. code:: bash

        pipenv lock --keep-outdated -r > requirements/run-pinned.txt
        pipenv lock --keep-outdated -r -d > requirements/dev-pinned.txt

#. Remove the virtual environment and the Pipfiles:

    .. code:: bash

        pipenv --rm
        git rm -f Pipfile{,.lock}
