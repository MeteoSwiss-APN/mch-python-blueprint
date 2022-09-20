
*****************************
On projects and the Blueprint
*****************************

The Python Blueprint
--------------------

The Python Blueprint is a template for Python projects.
Using `cookiecutter <https://github.com/cookiecutter/cookiecutter>`__, a new project can be set up in a minute, including many necessary and useful components to develop proper installable Python tools.
It provides:

-   Separate directories for the source code, tests and documentation.
-   A setup script to properly install the project and the commands it provides, including all its dependencies.
-   Clean separation of the various types of dependencies (runtime, development, setup; pinned and unpinned).
-   Many pre-configured tools that facilitate the development of clean, well-tested Python code following best practices.
-   Simple management of package version numbers.

In short, it provides all the boilerplate that we know deep down is necessary, but that we hardly ever bother with when we start writing a Python script!

Scripts vs. modules vs. packages vs. projects
---------------------------------------------

These terms describe the organizational hierarchy of Python code:

-   **Script**: Colloquial term for a Python code file, usually self-contained and often executed directly from the command line.
-   **Module**: Proper term for any Python code file, be it executable or purely meant to be imported by others.
    Can be imported by other modules by its name to use the variables, functions and/or classes is contains.
-   **Package**: A collection of related modules.
    To turn a directory containing modules into a package, add a file called ``__init__.py``, which may be empty.
    Packages can be nested arbitrarily to create module hierarchies, as long as each nested directory contains a ``__init__.py``.
    Nested packages are also referred to as *subpackages*.
    See also `this article <https://realpython.com/python-modules-packages/>`__ for a detailed description of modules and packages.
-   **Project**: A package together with tests, documentation, an install script, configuration files and development tools.
    A project should contain everything that is necessary to develop and/or install the package and its commands.

.. note::
    Creating an installable project is called `packaging <https://packaging.python.org/tutorials/packaging-projects/>`__, and the resulting packaged project is often also called a *package* -- not to be confused with a package as defined above!
    Usually, it is clear from context whether *package* refers to a collection of modules or to a packaged project.
    To avoid confusion, we will try to avoid the term *package* for the latter and instead call it a *project* or *packaged project* -- except when referring to *installing packages* with pip, the Python *package installer*.

How to get started with the Blueprint
-------------------------------------

The Blueprint resides on `Github <https://github.com/MeteoSwiss-APN/mch-python-blueprint>`__.
To create a new empty project from it, you need to run `Cookiecutter <https://github.com/cookiecutter/cookiecutter>`__ (which is installed on the MeteoSwiss machines at CSCS):

.. code:: console

    $ cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint
    Select sample_code:
    1 - no
    2 - cli
    3 - calculator
    Choose from 1, 2, 3 [1]: 3
    full_name [Monty Python]: Tim the Enchanter
    email [tim.the.enchanter@meteoswiss.ch]: tim.enchanter@meteoswiss.ch
    github_username [tim_the_enchanter]: ttenchanter
    project_name [Flying Circus]: Calculator
    project_slug [calculator]:
    project_short_description [Tim the Enchanter's Calculator]:
    version [0.1.0]:

.. note::
    When working on the Blueprint itself, instead you can point cookiecutter to your local clone of the ``mch-python-blueprint`` repository by passing the path instead of the github URL (or of cause any commit hash).

You will be asked a few questions about your project.
Based on the answers, cookiecutter creates an empty project:

.. code:: console

    $ ls -F calculator/
    AUTHORS.rst       MANIFEST.in  VERSION.txt     setup.py
    CONTRIBUTING.rst  Makefile     docs/           src/
    HISTORY.rst       README.rst   pyproject.toml  tests/
    LICENSE.txt       USAGE.rst    requirements/   tox.ini

It is not entirely empty, though, but contains some sample code and test files:

.. code:: console

    $ tree calculator/{src,tests}
    calculator/src
    └── calculator
        ├── __init__.py
        ├── cli.py
        ├── mutable_number.py
        ├── py.typed
        └── utils.py
    calculator/tests
    └── calculator
        ├── test_cli.py
        ├── test_mutable_number.py
        └── test_utils.py

    2 directories, 8 files

Your answers have even been turned into meta data for the package, which may, for instance, eventually help others find your package on PyPI:

.. code:: console

    $ \grep -A16 '^metadata' calculator/setup.py
    metadata = {
        "name": "calculator",
        "version": "0.1.0",
        "description": "Tim the Enchanter's Calculator",
        "long_description": read_present_files(description_files),
        "author": "Tim the Enchanter",
        "author_email": "tim.enchanter@meteoswiss.ch",
        "url": "https://github.com/ttenchanter/calculator",
        "keywords": "calculator",
        "classifiers": [
            "Development Status :: 2 - Pre-Alpha",
            "Intended Audience :: Developers",
            "Natural Language :: English",
            "Programming Language :: Python :: 3",
            "Programming Language :: Python :: 3.7",
        ],
    }

Cookiecutter and the Blueprint have now served their purpose and will no longer be needed. You can proceed with the instructions given in docs/installation.
