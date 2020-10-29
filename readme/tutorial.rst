
########
Tutorial
########

A step-by-step introduction with examples to the Python blueprint and its components.

**********
Quickstart
**********

To create a new project and start developing, run these commands:

    .. code::

        cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint
        cd <project>
        make format check test CHAIN=1

The cookiecutter command will ask you for some information on you and your project.
In addition, the parameter "sample_code" allows you to choose the amount of sample code to be included:

-   'no': No sample code is provided beyond an empty `main()` function in the `cli.py` file.
    This is useful if you are migrating an existing project into a new Blueprint project.
-   'cli': A basic command line interface based on `click <https://click.palletsprojects.com>`_ is pre-defined, including some basic tests.
    This is useful if you start from scratch but hit the ground running in terms of command line options.
-   'calculator': A fully-functional simple program that performs chained calculations, including a class and tests.
    This is useful to explore the Blueprint and the possibilities offered by `click <https://click.palletsprojects.com>`_.

The three explicit make commands do the following (type `make help` for all commands):

-   `make format`: Run pre-commit hooks over all files, which auto-format the code and perform a few checks.
-   `make check`: Run some linters (flake8, pylint, mypy) over the code, which check it for correctness and best practices.
-   `make test`: Run the unit tests.

Thanks to `CHAIN=1`, the following actions are taken in the beginning:

-   Initialize a git repository and commit all files (`make git`).
-   Create a local virtual environment (`make venv`).
-   Install the runtime and development dependencies into it (`make install-dev`).

If all goes well, you are ready to work on your code!

*****************************
On projects and the Blueprint
*****************************

What is the *Python Blueprint*?
-------------------------------

The *Python Blueprint* is a template for Python projects.
Using `cookiecutter`_, a new project can be set up in a minute, including many necessary and useful components to develop proper installable Python tools.
It provides:

-   Separate directories for the source code, tests and documentation.
-   A setup script to properly install the project and the commands it provides, including all its dependencies.
-   A Makefile that provides a range commands to easily set up and install the project for development or production, to run various types of tests, etc.
-   Clean separation of the various types of dependencies (runtime, development, setup; pinned and unpinned).
-   Many pre-configured tools that facilitate the development of clean, well-tested Python code following best practices.
-   Simple management of package version numbers.

In short, it provides all the boilerplate that we know deep down is necessary, but that we hardly ever bother with when we start writing a Python script!

What is the difference between scripts, modules, packages and projects?
-----------------------------------------------------------------------

These terms describe the organizational hierarchy of Python code:

-   **Script**: Colloquial term for a Python code file, usually self-contained and often executed directly from the command line.
-   **Module**: Proper term for any Python code file, be it executable or purely meant to be imported by others.
    Can be imported by other modules by its name to use the variables, functions and/or classes is contains.
-   **Package**: A collection of related modules.
    To turn a directory containing modules into a package, add a file called ``__init__.py``, which may be empty.
    Packages can be nested arbitrarily to create module hierarchies, as long as each nested directory contains a ``__init__.py``.
    Nested packages are also referred to as *subpackages*.
    See also `this article <https://realpython.com/python-modules-packages/>`_ for a detailed description of modules and packages.
-   **Project**: A package together with tests, documentation, an install script, configuration files and development tools.
    A project should contain everything that is necessary to develop and/or install the package and its commands.

    .. note::
        Creating an installable project is called `packaging <https://packaging.python.org/tutorials/packaging-projects/>`_, and the resulting packaged project is often also called a *package* -- not to be confused with a package as defined above!
        Usually, it is clear from context whether *package* refers to a collection of modules or to a packaged project.
        To avoid confusion, we will try to avoid the term *package* for the latter and instead call it a *project* or *packaged project* -- except when referring to *installing packages* with pip, the Python *package installer*.

How do I get started with the Blueprint?
----------------------------------------

The Blueprint resides on `Github <https://github.com/MeteoSwiss-APN/mch-python-blueprint>`_.
To create a new empty project from it, you need to run `Cookiecutter <https://github.com/cookiecutter/cookiecutter>`_ (which is installed on the MeteoSwiss machines at CSCS):

    .. code::

        $ cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint
        full_name [Donald Duck]: Mickey Mouse
        email [mickey.mouse@meteoswiss.ch]:
        github_username [mickeymouse]: mmouse
        project_name [Mickey's Tool]: Random Star Wars Generator
        project_slug [random_star_wars_generator]: random_star_wars
        project_short_description [Mickey Mouse's shiny new tool.]: A tool to randomly combine existing story elements to create new Star Wars movies.
        version [0.1.0]:

You will be asked a few questions about your project.
Based on the answers, cookiecutter creates an empty project:

    .. code::

        $ ls -F random_star_wars
        AUTHORS.rst       MANIFEST.in  VERSION.txt     setup.py
        CONTRIBUTING.rst  Makefile     docs/           src/
        HISTORY.rst       README.rst   pyproject.toml  tests/
        LICENSE.txt       USAGE.rst    requirements/   tox.ini

It is not entirely empty, though, but contains some sample code and test files:

    .. code::

        $ tree random_star_wars/{src,tests}
        random_star_wars/src
        └── random_star_wars
            ├── __init__.py
            ├── cli.py
            ├── random_star_wars.py
            └── utils.py
        random_star_wars/tests
        └── random_star_wars
            ├── test_cli.py
            ├── test_random_star_wars.py
            └── test_utils.py

Your answers have even been turned into meta data for the package, which may, for instance, eventually help others find your package on PyPI:

    .. code::

        $ \grep -A16 '^metadata' random_star_wars/setup.py
        metadata = {
            "name": "random_star_wars",
            "version": "0.1.0",
            "description": "A tool to randomly combine existing story elements to create new Star Wars movies.",
            "long_description": "\n\n".join([read_file(f) for f in description_files]),
            "author": "Mickey Mouse",
            "author_email": "mickey.mouse@meteoswiss.ch",
            "url": "https://github.com/mmouse/random_star_wars",
            "keywords": "random_star_wars",
            "classifiers": [
                "Development Status :: 2 - Pre-Alpha",
                "Intended Audience :: Developers",
                "Natural Language :: English",
                "Programming Language :: Python :: 3",
                "Programming Language :: Python :: 3.7",
            ],
        }

Cookiecutter and the Blueprint have now served their purpose and will no longer be needed.

How can I upload my new project to Github?
------------------------------------------

While a project already contains some git-related files like ``.gitignore``, it is not yet a git repository.
So first, you need to activate git in your project directory:

    .. code:: bash

        git init
        git add .
        git commit -m 'initial commit'

For your convenience, the ``Makefile`` defines a command for this:

    .. code:: bash

        make git

In order to upload your project to Github, after `creating a new repository <https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-new-repository>`_, run:

    .. code:: bash

        git remote add origin git+ssh://git@github.com/MeteoSwiss-APN/random_star_wars.git
        git push --set-upstream origin master

From this point on, your project is installable with Pip:

    python -m pip install git+ssh://git@github.com/MeteoSwiss-APN/star_wars_gen.git

    .. note::
        Read the rest of this guide for best practices and tools to install projects for development and deployment.

********************
Virtual Environments
********************

What is a virtual environment?
------------------------------

By default, `pip <https://pip.pypa.io/en/stable/>`_ installs Python packages system- or (with ``--user``) user-wide.
This makes them conveniently available, but can lead to version conflicts and more generally to a non-reproducible environment, as package versions will inevitable differ between machines or over time.

    .. note::
        A situation where multiple packages depend on different versions of a shared dependencies is called `dependency hell <https://en.wikipedia.org/wiki/Dependency_hell>`_.
        For example, tool A may require version ``< 2.0`` of dependency D, while tool B requires the same package, version ``>= 3.0``.
        You are then forced to choose between tools A and B because you cannot install both alongside each other!
        And if, god forbid, your system also depends on dependency D, but on version ``2.*``, you are forced to abandon both packages.

To avoid dependency hell, packages can instead be installed into self-contained containers called *virtual environments* which are isolated from the system installation.
Multiple virtual environments can easily coexists, which allows one to create designated environments for individual projects that contain all its Python dependencies, both during development and deployment.
Because the package versions in a virtual environment are independent from those required by the system, identical, reproducible environments can be maintained over time and on different machines.

    .. note::
        Virtual environments are tied to an existing Python installation, i.e., Python itself is not part of a virtual environment, but only linked.
        Multiple versions of Python can be easily installed with `Pyenv <https://github.com/pyenv/pyenv>`_, which allows virtual environments using different Python versions to coexist.
        Alternatively, `Conda <https://docs.conda.io/en/latest/>`_ provides virtual environment with a wider scope, including the Python installation itself as well as non-Python dependencies such as C libraries.

How can I create a virtual environment?
---------------------------------------

A Python virtual environment is created like this:

    .. code:: bash

        python -m venv ./venv --prompt=my-tool

This will create the directory ``./venv`` (any valid path can be passed), into which directories like ``bin`` and ``lib`` are placed.
Tools installed into the virtual environment that can be executed on the command line are found in ``./venv/bin/``.
Among them, notably, is ``python`` itself:

    .. code::
        $ ls -l venv/bin/python
        lrwxrwxrwx 1 stefan stefan 50 Oct  1 13:05 venv/bin/python -> /home/stefan/local/pyenv/versions/3.7.4/bin/python*

Because the Python installation is not part of the virtual environment, ``venv/bin/python`` is only a symlink to the installation used to create the virtual environment (in this example, one managed by  `Pyenv <https://github.com/pyenv/pyenv>`_).
However, by using ``./venv/bin/python`` instead of plain ``python`` to, e.g., run a script, the packages installed in ``./venv`` will be used.

For convenience, the ``Makefile`` provides the command ``make venv`` (which is automatically invoked by commands like ``make install`` if there is no active or local virtual environment yet).

How do I work in a virtual environment?
---------------------------------------

As mentioned, all command line tools installed in a virtual environment can be found in ``./venv/bin/``, including ``python`` itself.
Thus, you can simply call those executables explicitly:

    .. code:: bash

        ./venv/bin/python -m pip install black
        ./venv/bin/black my_script.py
        ./venv/bin/python my_script.py

This explicit approach ensures that never accidentally use the system installation, but it can be cumbersome to always type the path, especially outside of the project root.
To make matters easier, you can activate the virtual environment, which adds ``./venv/bin`` to your ``$PATH``, which makes its contents available wherever you are:

    .. code::

        $ which python
        /home/stefan/local/pyenv/shims/python
        $ source ./venv/bin/activate
        (my-tool)$ which python
        /home/stefan/work/git/meteoswiss-apn/mch-python-blueprint/venv/bin/python

As long as the virtual environment is active, your prompt will be preceded by its name, e.g., ``(my_tool)`` as a reminder.

    .. note::
        If you customize your bash prompt by defining ``$PS1`` in ``~/.bashrc``, make sure not to re-source the latter from inside a virtual environment, because this will remove the indicator ahead of the prompt.
        Your virtual environment will then still be active, but you may will no longer be aware of it.

All your actions, like installing or upgrading packages, will now be confined to the virtual environment.

Once you're done working on the project, you can deactivate the virtual environment by typing:

    .. code:: bash

        deactivate

(This will run ``./venv/bin/deactivate``, the equivalent of ``./venv/bin/activate``.)

Your bash prompt will no longer be preceded by ``(my-tool)``, and ``which python`` will again point you to the system installation.

Where shall I put my virtual environments?
------------------------------------------

That's up to you!
The virtual environments are self-contained, so there is no reason to put them inside the project you're working on, you only need to remember where you put it.

Because each project should have its own virtual environment, it is customary during development to put the respective virtual environment into the project root in a directory with a generic name like ``venv`` (as in the examples above) which is also added to ``.gitignore``.
This layout is used both in this document and in the projects created with the Blueprint (e.g., by the ``make venv*`` commands defined in ``Makefile``).

However, a virtual environment can quickly grow in size to dozens or even hundreds of megabytes.
While small by today's standards, this size may still become a problem on systems with a strict and relatively small quota, like the home folders at CSCS.
In that case, you may want to either work on ``$SCRATCH`` entirely, or at least move the virtual environments there.
They can easily be created on ``$SCRATCH`` and symlinked to the respective project in ``$HOME`` so the workflow does not change.

Are there alternatives to ``venv+pip``?
---------------------------------------

Venv is the built-in virtual environment tool in Python 3, and in combination with the Python package installer Pip -- thus ``venv+pip`` -- provides all the functionality to work with virtual environments.
However, there is a range of alternative thid-party tools which provide different approaches, interfaces and/or additional functionality:

-   **Virtualenv**: This package is essentially identical to ``venv``, but has been around longer (since Python 2) and is a third-party module that is not shipped with the standard library.
    Many manuals thus refer to ``virtualenv`` and ``virtualenv+pip`` as the standard approach.
    If you only use Python 3, just replace ``venv`` with ``virtualenv``.

-   **Virtualenvwrapper**: It's all in the name: This third-party tool is a wrapper of ``virtualenv`` providing an alternative interface.
    Virtual environments are stored in a central location which the user does not need to remember, and can be created, activated, and removed from anywhere in the system using their name.
    To install Packages within a virtual environment, you will still have to use ``pip`` explicitly.

-   **Pipenv**: This third-party tool aims to combine and abstract both the creation of virtual environments and the installation of packages therein.
    It uses ``virtualenv+pip`` under the hood and thus essentially constitutes a wrapper for the standard solution.
    It is often (somewhat erroneously) referred to as the officially recommended tool (and may someday become that), and is generally regarded as convenient and beginner-friendly.
    If you prefer ``pipenv`` over ``venv+pip`` for development, see below how to handle dependencies (``Pipfile`` vs. ``requirements/*.txt`` etc.).

-   **Conda**: Often used in science, ``conda`` (*Anaconda* or *Miniconda*) is another solution that handles both virtual environments as well as the packages therein, similar to ``pipenv``.
    In contrast to all aforementioned tools, however, it does not restrict itself to Python packages, but is a full-fletched language-agnostic package manager that can also handle Python itself as well as non-Python dependencies like C-libraries.
    Conda environments thus provide a substantially higher degree of isolation from the system environment than conventional Python virtual environments.
    On the flip side, because Conda uses its own package repositories (as opposed to the PyPI), some packages can occasionally be outdated.

In addition, some other tools often come up in the context of virtual environments:

-   **Pyenv**: A tool to install multiple versions of Python (no root required) and switch between them.
    It even allows one to use a certain Python version inside a certain directory (and its subdirectories), which for examples makes it possible to develop different projects with different Python versions.

-   **Pipx**: A tool to install Python command lines applications with a single command.
    It installs each application package and all its dependencies into a designated virtual environment.
    More details and examples are provided below.

*****************************
Installation and Dependencies
*****************************

Recap: How to create a new project with a virtual environment
-------------------------------------------------------------

Say we want to develop the command line application `chain_calc <https://github.com/MeteoSwiss-APN/chain_calc>`_ that performs sequential calculations.
First, we create the repository ``chain_calc`` on `Github <https://github.com/MeteoSwiss-APN>`_, and then create an empty package of the same name using the blueprint and upload it:

    .. code:: bash

        cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint
        cd chain_calc
        make git
        git remote add origin git+ssh://git@github.com/MeteoSwiss-APN/chain_calc.git
        git push --set-upstream origin master

Then, we create and activate a virtual environment for development:

    .. code:: bash

        python -m venv ./venv --prompt=chain_calc

Now that we are in a project-specific, pristine Python environment, we are ready to go!

    .. note::
        The following examples use the virtual environment explicitly (e.g., ``./venv/bin/python -m pip ...``).
        If you prefer to actiate the virtual environment in order to omit the ``./venv/bin/`` paths, you may do so with ``source ./venv/bin/activate``.

Please summarize how I can  install my project and manage its dependencies!
---------------------------------------------------------------------------

To install your project along with up-do-date versions of its runtime dependencies, run

    .. code:: bash

        make install

which is short for

    .. code:: bash

        make venv
        venv/bin/python -m pip install .

This installs a copy of your project along with its runtime dependencies into the virtual environment
If you change the code, you have to run ``make install`` again, so this approach is only suitable to install the project for production.

During development, instead run

    .. code:: bash

        make install-dev

which is short for

    .. code:: bash

        make venv
        venv/bin/python -m pip install -e .
        venv/bin/python -m pip install -r requirements/test-unpinned.txt
        venv/bin/python -m pip install -r requirements/dev-unpinned.txt

This installs your project in editable mode into the virtual environment, along with its runtime, test and development dependencies.
Changes in the code are immediately reflected in the virtual environment, so this approach is suitable during development.

.. TODO clean up requirements files and use pinned dependencies by default

To install pre-defined pinned versions of your package and its runtime dependencies:

    .. code:: bash

        python -m pip install -r requirements/setup.txt
        python -m pip install -r requirements/run-pinned.txt

To install pre-defined pinned versions of your package and its runtime and development dependencies:

    .. code:: bash

        python -m pip install -r requirements/setup.txt
        python -m pip install -r requirements/dev-pinned.txt


What types of dependencies are there?
-------------------------------------

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

How are dependencies specified in Python projects?
--------------------------------------------------

In Python projects using the standard packaging framework Setuptools, the unpinned runtime dependencies should be specified in the file ``setup.py`` or ``setup.cfg``.
Other dependency types are commonly specified in so-called requirements files, which are plain text files containing package names with optional version restrictions that can be passed to Pip.
Conventionally, many projects contain a single file called ``requirements.txt`` that contains the pinned runtime dependencies.
However, there are no restrictions regarding the number and names of requirement files, or whether they contain pinned or unpinned dependencies.
For instance, there may be separate files for pinned and/or unpinned development dependencies.
Dependencies specified in requirements files are installed with Pip as follows:

    .. code:: bash

        ./venv/bin/python -m pip -r requirements.txt

In the Blueprint, the dependencies are defined in the following files:

-   **pyproject.toml**: Setup requirements (preferentially pinned), installed temporarily during the installation of the project with Pip.
-   **setup.py**: Unpinned runtime dependencies, installed when installing the project with Pip, unless a *requirements.txt* file is present (see below).
-   **requirements/dev-unpinned.txt**: Unpinned development dependencies to be explicitly installed with Pip as described below.
-   **requirements/run-pinned.txt**: Pinned runtime dependencies to be explicitly installed with Pip, or during the installation of the project if soft-linked to *requirements.txt* (see below).
-   **requirements/dev-pinned.txt**: Pinned development and runtime dependencies, i.e., a superset of **run-pinned.txt** to be explicitly installed with Pip.

The file *setup.py* is a simple Python script that can be adapted to a project as desired.
That in the Blueprint will try to use dependencies specified in a ``requirements.txt`` file and only default to the unpinned dependencies specified in ``setup.py`` if that fails.
Pinned runtime dependencies will be used during installation by soft-linking them:

    .. code:: bash

        ln -s requirements/run_pinned.txt requirements.txt

This guarantees a working environment.
The environment can then easily be updated by temporarily removing the soft-link:

    .. code:: bash

        rm requirements.txt
        ./venv/bin/python -m pip install .
        ./venv/bin/python -m pip freeze > requirements/run_pinned.txt
        ln -s requirements/run_pinned.txt requirements.txt

    .. note::
        Instead of managing dependencies manually with requirements files, many projects use the third-party tool Pipenv, which naturally distinguishes runtime and development dependencies and automatically handles pinning.
        In addition to dependencies, Pipenv also handles virtual environments, thus rendering direct usage of venv and Pip obsolete.

How can I manage my dependencies with Pipenv instead of ``venv+pip``?
---------------------------------------------------------------------

`Pipenv <https://github.com/pypa/pipenv>`_ is a tool to manage both virtual environments and package installation via a unified interface.
Instead of one or more requirements files, Pipenv unifies all dependencies in a single file called `Pipfile <https://github.com/pypa/pipfile>`_, which contains unpinned runtime and development dependencies.
It is managed by Pipenv but can also be edited manually.
When pinning dependencies (called *locking*), Pipenv creates the file *Pipfile.lock* (which should not be edited manually).

Pipfile contains separate sections for development and runtime dependencies.
It is advantageous, however, not to specify the unpinned runtime dependencies in Pipfile, but instead to leave them in *setup.py* and specifying the project itself in editable form as the sole runtime dependency with

    .. code:: bash

        pipenv install -e .

This prevents Pipenv from becoming a setup dependency of the project and allows developers to switch between Pipenv and venv+pip with minimal effort.

    .. note::
        Even though requirements files and pipfiles can in principle coexist in a project, it is advisable that all developers collaborating on a project use either venv+pip or Pipenv to prevent inconsistencies in dependencies between the two approaches.

Because Pipenv manages virtual environments, it should be installed externally to the project.
A simple way to install Pipenv user-wide is with `Pipx <https://github.com/pipxproject/pipx>`_:

    .. code:: bash

        pipx install pipenv

This installs Pipenv and its dependencies into a designated virtual environment and makes the command ``pipenv`` available user-wide (see `Deployment <deployment.rst>`_).

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
            You may run into trouble with some packages that do not have a nominally stable release yet, notably the (well-established) auto-formatter `Black <https://github.com/psf/black>`_ that is also a default development dependency of the Blueprint:

                .. code::

                    ERROR: Could not find a version that matches black ...
                    Skipped pre-versions: 18.3a0, 18.3a0, 18.3a1, ...

            The problem is that Pipenv by default does not install pre-release versions unless explicitly told to, even if there is no stable version.
            There is currently `no clean solution to this <https://github.com/pypa/pipenv/issues/1760>`_, only imperfect workarounds:

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

Even if you use Pipenv during development, you should still provide a requirements.txt file containing the pinned runtime dependencies to allow for reproducible builds.
It can be produced with:

    .. code:: bash

        pipenv lock --keep-outdated -r > requirements.txt

    .. note::

        The flag ``keep-outdated`` is crucial for reproducible builds because without it, ``pipenv lock`` updates the dependencies to the newest versions.

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

*****************
Development Tools
*****************

What development tools come with the Blueprint?
-----------------------------------------------

The blueprint provides a variety of tools that assist in development:

-   Frameworks:

    -   `pre-commit <https://github.com/pre-commit/pre-commit>`_: Framework for managing git pre-commit hooks.
    -   `tox <https://github.com/tox-dev/tox>`_: Automation framework to run arbitrary commands -- e.g., pytest, mypy, pylint etc. -- in isolated virtual environments and easily test a Python program against multiple installed Python versions.
    -   `pytest <https://github.com/pytest-dev/pytest>`_: Unit testing framework suitable for very small, but also bigger tests.

-   Formatters:

    -   `black <https://github.com/psf/black>`_: The "uncompromising" (i.e., minimally configurable) code formatter that auto-formats Python code in accordance with `PEP 8 <https://www.python.org/dev/peps/pep-0008/>`_ and best practices with the goal to minimize diffs between code changes.
    -   `isort <https://github.com/PyCQA/isort>`_: Auto-formatter that that sorts and groups Python import statements.

-   `Linters <https://en.wikipedia.org/wiki/Lint_(software)>`_:

    -   `flake8 <https://github.com/PyCQA/flake8>`_: Wrapper of static code analysis tools checking Python code for `errors <https://github.com/PyCQA/pyflakes>`_, `style <https://github.com/PyCQA/pycodestyle>`_ and `complexity <https://github.com/PyCQA/mccabe>`_.
    -   `mypy <https://github.com/python/mypy>`_: Static type checker relying on `type hints <https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html>`_ introduced in Python 3.6.
    -   `pydocstyle <https://github.com/PyCQA/pydocstyle>`_: Static checker for correctness and completeness of docstrings.
    -   `pylint <https://github.com/PyCQA/pylint>`_: Static code analysis tool (linter) checking for errors, standard compliance, code smells etc.

-   Various:

    -   `bumpversion <https://github.com/c4urself/bump2version>`_: Utility to increment the version number across a whole project.
    -   `codespell <https://github.com/codespell-project/codespell>`_: Spell checker aimed at detecting common misspellings in code.

How are these tools supposed to be run?
---------------------------------------

-   All tools can be invoked via commands defined in the Makefile, but may also be run manually, either via a framework (*pre-commit* or *tox*) they are embedded in, or directly.

-   **Pre-commit**, once active, is run before every commit, and may also be run manually with ``make format``.
    The following tools are set up as pre-commit hooks: **black**, **isort**, and **pydocstryle**.

-   **Tox** is invoked by the commands ``make check`` and ``make test``.
    The following tools are set up as tox environments: **pytest**, **flake8**, **mypy**, and **pylint**.

-   **Bumpversion** is invoked by the commands ``make bump-{patch,minor,major}``.

-   **Codespell** is invoked by the command ``make spellcheck``.

What do I need to know about versioning?
----------------------------------------

Version numbers are crucial to identify versions of a software, for instance to determine whether a certain feature or bugfix is present.
There are different version number schemes suitable for different project complexities, release schedules etc.

A popular approach is `semantic versioning <https://semver.org/>`_ (often *semver*) with version numbers ``X.Y.Z`` composed of three components: *major*, *minor* and *patch*.
An increase in a specific component conveys the scope of change from the previous version:

-   *major*: incompatible API changes;
-   *minor*: backward-compatible additions of functionality;
-   *patch*: bug fixes.

While the boundaries between these types of changes are `not always clear <https://snarky.ca/why-i-dont-like-semver>`_, this provides a good starting point to versioning a project.

The Blueprint provides the utility `bumpversion <https://github.com/c4urself/bump2version>`_ to easily increment the version number of a project in all files that contain it, and optionally create a git commit and git tag as well.
Its configuration `currently <https://github.com/c4urself/bump2version/issues/42>`_ resides in the file *.bumpversion.cfg*.
By default, it uses semver with three-component version numbers ``X.Y.Z``.
The Makefile defines commands to increment each component:

    .. code:: bash

        make bump-patch
        make bump-minor
        make bump-major

The make commands will ask you for a message to annotate the git tag with.

    .. note::
        For relatively simple projects, two components ``X.Y`` may be enough, with the major component indicating non-compatible (or otherwise major) changes and the minor component indicating backward-compatible feature additions and bug fixes.
        Bumpversion can easily be set up to support this scheme by adapting the regular expression used to parse version numbers and the format template used to write them.

I write beautiful code, I don't need an autoformatter!
------------------------------------------------------

No objection -- but, as the saying goes, beauty is in the eye of the beholder!
This applies to Python code as much as to the world at large.

While its syntax (enforced whitespace) and best practices (`PEP 8 <https://www.python.org/dev/peps/pep-0008/>`_) put some constraints on the formatting of Python code, they leave considerable freedom to the programmer, for example `how to indent long function calls and signatures <https://www.python.org/dev/peps/pep-0008/#indentation>`_:

    .. code:: python

        # Correct:

        # Aligned with opening delimiter.
        foo = long_function_name(var_one, var_two,
                                 var_three, var_four)

        # Add 4 spaces (an extra level of indentation) to distinguish arguments from the rest.
        def long_function_name(
                var_one, var_two, var_three,
                var_four):
            print(var_one)

        # Hanging indents should add a level.
        foo = long_function_name(
            var_one, var_two,
            var_three, var_four)

These examples are not exhaustive, as there are many "standard-compatible" ways how to format such expressions -- plus, in the end, the standard is merely a recommendation.

Of course, most important is not which formatting variant is chosen for a certain type of code (e.g., how much hanging indent), but that this choice is enforced consistently across a given project, for reasons like maximized readability and minimized diffs.
For collaborative projects, this inevitably takes formatting decisions out of the individual programmers' hands -- the goal is not longer to write "beautiful code," but to adhere to a standard.

So why not take these decisions out of all the programmers' hands at once and delegate them to an impartial authority?
This is where auto-formatters enter the stage: Tools that feed on your inconsistently formatted eyesore of a code and, without complaining, turn it into consistently formatted code following a set of rules that can be customized to a given project to varying degrees (depending on the tool).
Instead of worrying or arguing about how the code looks, spend your time thinking about what it does!

    .. note::
        The benefits of adhering to a clearly defined standard also apply to one-person projects, because over time, even these projects tend to become collaborations -- with your past self, who wrote code that you no longer understand, and who used formatting your eyes can no longer bear.
        If you have ever spent an afternoon reformatting all the function calls or signatures in an old script of yours, only to realize that this was in effect a waste of time that would have been better spent actually fixing the script, then you understand one beneficial aspect of formatting standards and auto-formatters even in the absence of (true) collaborators.

There are several popular Python formatters, among them `Autopep8 <https://github.com/hhatto/autopep8>`_, `Yapf <https://github.com/google/yapf>`_ and `Black <https://github.com/psf/black>`_, all with their `strengths and weaknesses <https://www.kevinpeters.net/auto-formatters-for-python>`_.
The Blueprint uses Black because it provides the most freedom of mind due to minimal freedom of choice: By design, it is as unconfigurable as possible, which prevents major discussions over minor formatting choices to be simply migrated from the code itself to the formatter configuration.
Black follows a relatively small number of rules aimed at readability and diff minimization that quickly become intuitive.
Following are a few examples from the `Black README <https://github.com/psf/black>`_:

    .. code:: python

        # in:
        j = [1,
             2,
             3
        ]

        # out:
        j = [1, 2, 3]

..

    .. code:: python

        # in:
        ImportantClass.important_method(exc, limit, lookup_lines, capture_locals, extra_argument)

        # out:
        ImportantClass.important_method(
            exc, limit, lookup_lines, capture_locals, extra_argument
        )

..

    .. code:: python

        # in:
        def very_important_function(template: str, *variables, file: os.PathLike, engine: str, header: bool = True, debug: bool = False):
            """Applies `variables` to the `template` and writes to `file`."""
            with open(file, 'w') as f:
                ...

        # out:
        def very_important_function(
            template: str,
            *variables,
            file: os.PathLike,
            engine: str,
            header: bool = True,
            debug: bool = False,
        ):
            """Applies `variables` to the `template` and writes to `file`."""
            with open(file, "w") as f:
                ...

..

    .. note::
        If you're still sceptical about auto-formatters in general or Black's formatting choices in particular, just try it out for some time.
        Chances are you will get used to the specific formatting choices and come to enjoy the freedom of focusing on what the code does.
        Also, the next time you unearth some script from your distant past, you won't spend an afternoon reformatting it but a mere couple of seconds!

What are pre-commit hooks?
--------------------------

`Pre-commit hooks <https://github.com/git/git/blob/master/templates/hooks--pre-commit.sample>`_ are one type of `giit hooks <https://githooks.com/>`_ -- scripts that are automatically triggered by certain git events.
As their name suggests, pre-commit hooks are executed ahead of commits, which is an ideal time to ensure that the code meets certain standards of quality and correctness, i.e., to apply formatters and linters to the code.
Thanks to the popular `framework <https://pre-commit.com/>`_ with the same name, pre-commit hooks are very easy to set up and manage thanks to many `ready-made hooks <https://pre-commit.com/hooks.html>`_ ranging from `small utilities <https://github.com/pre-commit/pre-commit-hooks>`_ that remove trailing whitespace, check symlinks or sort files to full-fledged linters like `mypy <https://github.com/pre-commit/mirrors-mypy>`_ or `pylint <https://github.com/PyCQA/pylint>`_.

Once pre-commit hooks are active, they are triggered whenever you attempt to commit a change.
The checkers and formatters are applied to the changed lines or files (depending on the tool), and the commit is only completed if all checks are successful.
If any checker finds an issue or makes a change to the code, the commit is aborted and it is up to you to fix any problems and/or review changes before reattempting the commit.
While this may sound cumbersome, that is really not the case if you keep your commits reasonably small -- the whole point of pre-commit hooks is to prevent these minor issues from accumulating over time thanks to frequent micro-cleanups.

The Blueprint provides pre-commit set up with several useful tools which are primarily aimed at code formatting.
In addition to some small checkers and fixers (find debug statements, remove trailing whitespace, check validity of toml/yaml files), these are:

- `black <https://github.com/psf/black>`_ to format the code;
- `isort <https://github.com/PyCQA/isort>`_ to sort and group imports; and
- `pydocstyle <https://github.com/PyCQA/pydocstyle>`_ to check doc strings.

..

    .. note::
        Another good candidate, the spell checker `codespell <https://github.com/codespell-project/codespell>`_, is among the default development dependencies, but is not set up as a pre-commit hook because while it is very useful to find misspellings, it finds too many false positives, which are easy to ignore by eye but not by pre-commit.
        We strongly recommends to occasionally run codespell manually, though, in order to keep misspellings to a minimum.

After creating a new project and installing the development dependencies, pre-commit must be activated:

    .. code:: bash

        ./venv/bin/pre-commit install           # hook into git
        ./venv/bin/pre-commit run --all-files   # run hooks the first time

Note that ``pre-commit install`` is run as part of ``make install-dev``, so if you stick to the Makefile commands, you won't have to activate pre-commit explicitly.

    .. note::
        If you have a good reason to make a commit despite failing pre-commit hooks, you can forego the checks with ``--no-verify``.
        However, this should not be done routinely, but only in exceptional circumstances.

What does tox do?
-----------------

`Tox <https://github.com/tox-dev/tox>`_ is an automation framework to run arbitrary commands in isolated virtual environments.
In addition to running tools like the linters flake8, mypy or pylint that check the correctness of the code, tox can also easily be set up to run unit tests (e.g., with pytest) against multiple installed Python versions (e.g., 3.7, 3.8, 3.9) to ensure broad compatibility.

    .. note::
        While less critical for end-user applications, ensuring compatibility with multiple Python versions is crucial for libraries that are used in other applications.

In the Blueprint, tox manages the following tools:

-   the unit testing framework `pytest <https://github.com/pytest-dev/pytest>`_,
-   the linters (i.e., static code analysis tools) `flake8 <https://github.com/PyCQA/flake8>`_ and `pylint <https://github.com/PyCQA/pylint>`_, and
-   the static type checker `mypy <https://github.com/python/mypy>`_.

The fact that tox runs the tools isolated in virtual environments has the advantage that it also tests whether the project is properly installable.
For instance, if some necessary data files are not listed in MANIFEST.in and thus not copied alongside the code, this won't be detected when tests are run directly in the working directory, but tox will fail because those files will be missing.
On the flip side, creating the virtual environment and installing the dependencies (or at least verifying that they are installed) introduces some overhead, which means that running fast unit tests may take significantly longer if run with tox.

The Makefile provided by the Blueprint takes an intermediate approach: The commands ``make test``, ``make test-fast`` and ``make test-slow`` run the tests directly in the working directory without install overhead, while ``make test-iso`` and ``make test-check`` run them through tox.
The former commands can thus be used during development to frequently test changes, while periodically using the latter commands ensures installability of the project.

What belongs in the file tox.ini?
---------------------------------

As the name suggests, the file tox.ini is the configuration file of tox.
However, a look into the file provided by the Blueprint reveals that it also contains configuration of other tools, some of which are not even managed by tox, such as isort, which is managed by pre-commit.
The reason is that there is no single standard file in which to put configurations of development tools in a Python project.

There are a few files that come close, for instance setup.cfg (which can be used in conjunction with setup.py), but also tox.ini.
Because the Blueprint only uses a plain setup.py script without an accompanying setup.cfg file, but anyway features a tox.ini file for the configuration of tox itself, we put the configuration of all tools that support tox.ini into that file to avoid having a dozen or so tool-specific configuration files.

    .. note::
        The relatively recently introduced pyproject.toml may over time evolve into the central standard place to put tool configurations, but it is not there yet.

Tell me about pytest!
---------------------

See `github page <https://github.com/pytest-dev/pytest>`_ and `documentation <https://docs.pytest.org/en/stable/contents.html>`_.

Tell me about flake8!
---------------------

See `github page <https://github.com/PyCQA/flake8>`_ and `documentation <https://flake8.pycqa.org/en/latest/>`_.

Tell me about pylint!
---------------------

See `github page <https://github.com/PyCQA/pylint>`_ and `documentation <http://pylint.pycqa.org/en/latest/>`_.

Tell me about mypy!
-------------------

See `github page <https://github.com/python/mypy>`_ and `documentation <https://mypy.readthedocs.io/en/stable/>`_.

Why should I want to declare variable types in Python?
------------------------------------------------------

Python is a dynamically typed language where the types of variables do not need to be declared and can indeed change freely.
This is in contrast to statically typed languages like C or Fortran, where the variable types must be declared and cannot change freely.
Dynamic typing makes it very easy to write Python scripts, to reuse functions with custom objects, and so forth.
However, at least some type information is usually necessary, especially in interfaces, e.g., when an argument is expected to be a number, a string or a list.
This information is usually provided in docstrings.
The problem with type information in docstrings is that it cannot be easily verified and is in danger of becoming outdated when an interface changes but the docstring is not adapted accordingly.

To address this issue, Python gradually introduced the concept of type hints, initially as comments but eventually as part of the language.
The `modern type hint syntax <https://www.python.org/dev/peps/pep-0484/>`_ has been introduced in Python 3.5 and is based on `function annotations <https://www.python.org/dev/peps/pep-3107/>`_
The hints can be parsed by external tools like `mypy <http://mypy-lang.org/>`_, which use them together type information derived from variable assignments to perform static type analysis.
This allows them to detect errors such as passing a string to a function that expects a bool, as illustrated in this example (`source <>`_):

    .. code:: python

        # headlines.py

        def headline(text: str, align: bool = True) -> str:
            if align:
                return f"{text.title()}\n{'-' * len(text)}"
            else:
                return f" {text.title()} ".center(50, "o")

        print(headline("python type checking"))
        print(headline("use mypy", align="center"))

..

    .. code:: bash

        $ mypy headlines.py
        headlines.py:10: error: Argument "align" to "headline" has incompatible type "str"; expected "bool"

For more information on type hints, see the `mypy cheat sheet <https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html>`_ and this `RealPython guide <https://realpython.com/python-type-checking/>`_.

    .. note::
        In contrast to statically typed languages, however, the type information is not used at runtime to increase performance, and also won't be used to that end in the future (at least by CPython, the official Python interpreter).
        Type hints are therefore best thought of as testable documentation.

*********************
Recommended Libraries
*********************

How do I add a command line interface to my application?
--------------------------------------------------------

If you develop an application (rather than a library), chances are you want to provide a command line interface.
The Blueprint uses `click <https://click.palletsprojects.com>`_ (“Command Line Interface Creation Kit”), a library for creating command line interfaces in a composable way with as little code as necessary.
It is highly configurable but comes with sensible defaults out of the box.

The command line interface is defined in the file ``src/great_tool/cli.py``.
There, you can specify command line arguments and options, as well as the entry point(s) as specified in ``setup.py``.
A few sensible ones are already pre-defined (--version, --help, --verbose, --dry-run).

For a somewhat more sophisticated command line interface than that provided by default by the blueprint, see the sample application `chain_calc`_.
