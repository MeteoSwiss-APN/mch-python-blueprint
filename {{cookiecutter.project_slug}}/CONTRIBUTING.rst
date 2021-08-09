.. highlight:: shell

============
Contributing
============

Contributions are welcome, and they are greatly appreciated!
Every little bit helps, and credit will always be given.

You can contribute in many ways:


Types of Contributions
----------------------


Report Bugs
^^^^^^^^^^^

Report bugs at https://github.com/MeteoSwiss-APN/{{ cookiecutter.project_slug }}/issues.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.


Fix Bugs
^^^^^^^^

Look through the GitHub issues for bugs.
Anything tagged with "bug" and "help wanted" is open to whoever wants to implement it.


Implement Features
^^^^^^^^^^^^^^^^^^

Look through the GitHub issues for features.
Anything tagged with "enhancement" and "help wanted" is open to whoever wants to implement it.


Write Documentation
^^^^^^^^^^^^^^^^^^^

{{ cookiecutter.project_name }} could always use more documentation, whether as part of the official {{ cookiecutter.project_name }} docs, in docstrings, or even on the web in blog posts, articles, and such.


Submit Feedback
^^^^^^^^^^^^^^^

The best way to send feedback is to file an issue at https://github.com/MeteoSwiss-APN/{{ cookiecutter.project_slug }}/issues.

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, and that contributions are welcome! :)


Get Started!
------------

Ready to contribute? Here's how to set up `{{ cookiecutter.project_slug }}` for local development.

1.  Fork the `{{ cookiecutter.project_slug }}` repo on GitHub.
2.  Clone your fork locally::

        $ git clone git@github.com:your_name_here/{{ cookiecutter.project_slug }}.git

3.  Create a virtual environment and install the development dependencies::

        $ cd {{ cookiecutter.project_slug }}/
        $ make install-dev

    This will create a virtual environment named ``{{ cookiecutter.project_slug }}`` (change with ``VENV_NAME=my_venv``) in ``./venv`` (change with ``VEND_DIR=path/to/venv``) and install the following dependencies:

    -   Build dependencies in ``pyproject.toml``
    -   Runtime dependencies in ``setup.py``
    -   Testing dependencies in ``requirements/test-unpinned.txt``
    -   Development dependencies in ``requirements/dev-unpinned.txt``

    Optionally activate the virtual environment::

        $ source ./venv/bin/activate

    Note however that this is not required for ``make`` commands, which automatically detect and use the virtual environment.

4.  Create a branch for local development::

        $ git checkout -b name-of-your-bugfix-or-feature

    Now you can make your changes locally.

5.  When you're done making changes, format the code with black and check that your changes pass the static code analyses with flake8::

        $ make format
        $ make line

    Next, ensure that the code does what it is supposed to by running the tests with pytest::

        $ make test

    To make sure that your code is compatible with multiple Python version, and that it is properly packageable, run flake8 and pytest within tox::

        $ make test-all

6.  Commit your changes and push your branch to GitHub::

        $ git add .
        $ git commit -m "Your detailed description of your changes."
        $ git push origin name-of-your-bugfix-or-feature

7.  Submit a pull request through the GitHub website.


Pull Request Guidelines
-----------------------

Before you submit a pull request, check that it meets these guidelines:

1. The pull request should include tests.
2. If the pull request adds functionality, the docs should be updated.
   Put your new functionality into a function with a docstring, and add the feature to the list in ``README.rst``.
3. The pull request should work for Python 3.6 and 3.7, and for PyPy.
   Make sure that the tests pass for all supported Python versions.


Tips
----

To run a subset of tests::

    $ pytest tests.test_{{ cookiecutter.project_slug }}


Deploying
---------

A reminder for the maintainers on how to deploy.
Make sure all your changes are committed (including an entry in ``HISTORY.rst``).
Then run::

$ make bump-patch # possible: major, minor, patch
$ git push
$ git push --tags


Project Structure
-----------------

.. list-table:: Structure
   :widths: 25 75
   :header-rows: 1

   * -  File / Directory
     -  Description

   * -  src/
     -  Source folder, with the main package in ``src/{{ cookiecutter.project_slug }}``.
   * -  tests/
     -  Directory containing the tests.
        Pytest collects all tests in files named ``test_*.py``.
   * -  docs/
     -  Directory containing the documentation.

   * -  README.rst
     -  Short documentation of the package, including its features and a quick-start guide.
   * -  CONTRIBUTION.rst
     -  This file.
        Contains all the information you need when you contribute to this project.
   * -  HISTORY.rst
     -  Lists the releases and their new features.
   * -  AUTHORS.rst
     -  Contains information about the lead developer and contributors.
   * -  LICENSE.txt
     -  Project license.
   * -  VERSION.txt
     -  Package version number (incremented by ``bumpversion``).

   * -  Makefile
     -  Build file defining a wide range of commands for cleanup, virtual environments, dependencies, code refinement, testing, etc. (see `make help`).
   * -  pyproject.toml
     -  File governing the build process.
        Contains any build dependencies that are installed before the build is started.
   * -  setup.py
     -  Script specifying how to build the package, containing:
        * Package meta data: name, author, description, keywords, etc.
        * Unpinned runtime dependencies.
        * Source code location.
        * Names and entry points of command line scripts.
   * -  MANIFEST.in
     -  Specifies the files and directories which will be added to the pip package.

   * -  requirements/
     -  Folder with requirements files specifying various types of dependencies.
   * -  requirements/test-unpinned.txt
     -  Unpinned direct testing dependencies.
   * -  requirements/dev-unpinned.txt
     -  Unpinned direct development dependencies.
   * -  requirements/run-pinned.txt
     -  Pinned runtime requirements, covering the whole dependency tree with fixed versions.
   * -  requirements/test-pinned.txt
     -  Pinned testing dependencies, along with runtime dependencies, covering the whole dependency tree with fixed versions.
   * -  requirements/dev-pinned.txt
     -  Pinned development dependencies, along with testing and runtime dependencies, covering the whole dependency tree with fixed versions.

   * -  tox.ini
     -  Configuration file of tox and other testing-related tools like pytest.
   * -  .bumpversion.cfg
     -  Configuration file of ``bumpversion``.


Managing dependencies
---------------------

Most projects make use of, and thus depend on, external libraries, be it at runtime (e.g., ``numpy``), during testing (e.g., ``pytest``), while developing code (e.g., ``black``).
These dependencies are specified in different files, depending on the dependency type (runtime vs. development) and the degree to which the package versions are restricted (unpinned vs. pinned; see below).

The dependencies in the following files are managed by hand:

 *  ``pyproject.toml``:
    Build dependencies, i.e., packages that must be installed prior to building the package (based on ``setup.py``), like ``Cython`` to use C-style features.
 *  ``setup.cfg``:
    Unpinned direct runtime dependencies, i.e., packages imported in the code.
    Installed while building the package with, e.g., ``make install``.
 *  ``requirements/test-unpinned.txt``:
    Unpinned direct testing dependencies, i.e., packages used during testing.
    Separate from other development dependencies because one may want to test the package on a given system prior to installation without changing it.
 *  ``requirements/dev-unpinned.txt``:
    Unpinned direct development dependencies, i.e., packages used during development (in addition to the testing dependencies).

The following files, by contrast, and created with ``pip freeze`` after installing the respective packages:

 *  ``requirements/run-pinned.txt``:
     Pinned runtime requirements, covering the whole dependency tree with fixed versions.
 *  ``requirements/test-pinned.txt``:
     Pinned testing dependencies, along with runtime dependencies, covering the whole dependency tree with fixed versions.
 *  ``requirements/dev-pinned.txt``:
     Pinned development dependencies, along with testing and runtime dependencies, covering the whole dependency tree with fixed versions.

For instance, the runtime dependencies can be pinned as follows::

    $ make install
    $ ./venv/bin/python -m pip freeze >requirements/run-pinned.txt

Note that the quasi-standard `pip requirements file`_ ``requirements.txt`` is called ``requirements/run-pinned.txt``.
The dependencies specified in a requirements file are installed with ``pip install -r <requirements file>``.

Unpinned and pinned dependencies have specific characteristics, advantages, and drawbacks:

* Unpinned dependencies encompass only packages which are used directly, and their version numbers are restricted as little as possible.
  This facilitates keeping the setup up-to-date, but at the danger of breaking due to newly introduced bugs or incompatibilities.
  Many packages can usually be specified without any version restrictions.
  Sometimes, however, certain versions of packages may be incompatible, specific versions may be buggy, or certain features may only have been introduced with in a specific version; in these cases, the version number can be restricted with the comparison operators ``>=``, ``==``, etc.
  If possible, the version should be specified without an upper bound lest the setup eventually become out-of-date.

* Pinned dependencies encompass the whole dependency tree, including all dependencies of dependencies, all with fixed version numbers (``==``).
  This guarantees a working setup, but makes it hard to keep dependencies up-to-date.
  (Note that non-Python dependencies like C libraries need to be managed separately, i.e., one must ensure that their versions are compatible with a given setup.)

We specify unpinned top-level dependencies by hand.
Based on these, we can install an up-to-date setup comprised of the most recent package versions.
Once we have tested this setup thoroughly and ensured that it works, we can pin it.
By repeating this occasionally, we can provide a working up-to-date setup.

.. _`pip requirements file`: https://pip.readthedocs.io/en/1.1/requirements.html


How to provide executable scripts
---------------------------------

By default, a single executable script called {{ cookiecutter.project_slug }} is provided.
It is created when the package is installed.
When you call it the main function in ``src/{{ cookiecutter.project_slug }}/cli.py`` is called.

How many scripts that are created, their names and which functions are called can be configured in the ``setup.py`` file as an option to the ``setup()`` function call as follows::

    ...
    scripts = [
        "{{ cookiecutter.project_slug }}={{ cookiecutter.project_slug }}.cli:main",
    ]

    setup(
        ...
        entry_points={"console_scripts": scripts},
        ...
    )

The left-hand side of each definition specifies the name of the executable, the right-hand side the module and function that is called on execution.
When the package is installed, a executable script is created in the Python's bin folder with the name ``{{ cookiecutter.project_slug }}``.
In the above case, when a user calls ``{{ cookiecutter.project_slug }}``, the function ``main`` in the file ``src/{{ cookiecutter.project_slug }}/cli.py`` is called.
