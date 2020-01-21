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

1. Fork the `{{ cookiecutter.project_slug }}` repo on GitHub.
2. Clone your fork locally::

    $ git clone git@github.com:your_name_here/{{ cookiecutter.project_slug }}.git

3. Install your local copy into a virtualenv. This is how you set up your fork for local development::

    $ cd {{ cookiecutter.project_slug }}/
    $ python -m virtualenv venv
    $ pip install -r requirements/dev-unpinned.txt

4. Create a branch for local development::

    $ git checkout -b name-of-your-bugfix-or-feature

   Now you can make your changes locally.

5. When you're done making changes, format them with black, check that your changes pass the static code analyses with flake8 and the tests with pytest, including testing other Python versions with tox::

    $ black src
    $ flake8 src tests
    $ pytest
    $ tox  # optional, currently only flake8 and Python 3.7 configured and thus not necessary

6. Commit your changes and push your branch to GitHub::

    $ git add .
    $ git commit -m "Your detailed description of your changes."
    $ git push origin name-of-your-bugfix-or-feature

7. Submit a pull request through the GitHub website.


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

$ bumpversion patch # possible: major / minor / patch
$ git push
$ git push --tags

Jenkins will then deploy to PyPI if tests pass.


Project Structure
-----------------

.. list-table:: Structure
   :widths: 25 75
   :header-rows: 1

   * - File / Directory
     - Description
   * - docs/
     - Directory containing the documentation.
   * - tests/
     - Directory containing the tests.
       The directory structure in this folder is the same as in the source folder (src).
       For each file in the source folder, there is a file with the same name, but, with the prefix ``text_``.
   * - src/
     - Source folder.
   * - AUTHORS.rst
     - Contains information about the lead developer and contributors.
   * - .bumpversion.cfg
     - Configuration file of ``bumpversion``.
       Rewritten and reformatted when ``bumpversion`` runs, therefore the config is not in ``setup.cfg``.
   * - CONTRIBUTION.rst
     - Contains all the information you need when you contribute to this project.
   * - HISTORY.rst
     - Lists the releases and their new features.
   * - LICENSE.txt
     - Project license.
   * - MANIFEST.in
     - Specifies the files and directories which will be added to the pip package.
   * - Makefile
     - Build file for cleaning, creating and releasing packages, for testing and linting code, and for creating the documentation.
   * - README.rst
     - Short documentation about the package.
       It lists features and contains a quick start.
   * - requirements/
     - Requirements files containing dependencies.
   * - requirements/dev-unpinned.txt
     - Unpinned top-level development requirements, including ``{{ cookiecutter.project_slug }}`` in editable mode (and by implication its runtime dependencies).
       Run ``pip install -r requirements/dev-unpinned.txt`` to install the project and the newest versions of its runtime and development dependencies.
   * - requirements/dev-pinned.txt
     - Pinned development requirements, covering the whole dependency tree with fixed versions.
   * - requirements/run-pinned.txt
     - Pinned runtime requirements, covering the whole dependency tree with fixed versions.
       Subset of the pinned development requirements in ``requirements/dev-pinned.txt``.
   * - requirements/setup.txt
     - Packages required to be installed before installing ``{{ cookiecutter.project_slug }}`` and its dependencies.
       For instance, to build ``cartopy`` from source, ``cython`` and ``numpy`` must be pre-installed.
   * - setup.cfg
     - Configuration file containing:

       * package meta data (incl. version number incremented by ``bumpversion``);
       * build specifications (source files, entry points, etc.);
       * unpinned runtime dependencies;
       * configuration of various development tools like ``pytest``, ``flake8``, or ``tox``.

   * - setup.py
     - Script building the package based on the configuration in ``setup.cfg``.
   * - VERSION.txt
     - Package version number (incremented by ``bumpversion``).


Managing dependencies
---------------------

Most projects make use of, and thus depend on, external libraries, be it at runtime (e.g., ``numpy``) or during development (e.g., ``pytest``).
These dependencies are specified in different files, depending on the dependency type (runtime vs. development) and the degree to which the package versions are restricted (unpinned vs. pinned; see below).

The dependencies in the following files are managed by hand:

* ``setup.cfg``: Unpinned top-level runtime dependencies, i.e., packages directly used by the application/library; installed alongside the package/application (e.g., with ``python setup.py install``).
* ``requirements/dev-unpinned.txt``: Unpinned top-level development dependencies, i.e., packages used during development and testing.
* ``requirements/setup.txt``: Setup dependencies, i.e., all packages required before installing the application/package and its dependencies (e.g., building ``cartopy`` from source requires ``cython`` and ``numpy`` to be pre-installed).

The following files, by contrast, and created with ``pip freeze`` after installing the respective packages:

* ``requirements/run-pinned.txt``: Pinned runtime dependencies, i.e., all packages directly or indirectly used by the application/library.
* ``requirements/dev-pinned.txt``: Pinned development dependencies, i.e., all packages directly or indirectly used during development and testing.

For instance, the runtime dependencies can be pinned as follows::

    python -m virtualenv venv
    source venv/bin/activate
    python setup.py install
    pip freeze > requirements/run-pinned.txt

Note that the quasi-standard `pip requirements file`_ ``requirements.txt`` corresponds to ``requirements/run-pinned.txt``.
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

We specify unpinned top-level dependencies.
Based on these, we can install an up-to-date setup comprised of the most recent package versions.
Once we have tested this setup thoroughly and ensured that it works, we can pin it.
By repeating this occasionally, we can provide a working up-to-date setup.

.. _`pip requirements file`: https://pip.readthedocs.io/en/1.1/requirements.html


How to provide executable scripts
---------------------------------

By default, a single executable script called {{ cookiecutter.project_slug }} is provided.
It is created when the package is installed.
When you call it the main function in ``src/{{ cookiecutter.project_slug }}/cli.py`` is called.

How many scripts that are created, their names and which functions are called can be configured in the
``setup.cfg`` file.
The section ``[options.entry_points]`` contains the variable ``console_scripts``, under which one or more entry points can be defined as follows::

    [options.entry_points]
    console_scripts =
        {{ cookiecutter.project_slug }} = {{ cookiecutter.project_slug }}.cli:main

The left-hand side of each definition specifies the name of the executable, the right-hand side the module and function that is called on execution.
When the package is installed, a executable script is created in the Python's bin folder with the name ``{{ cookiecutter.project_slug }}``.
In the above case, when a user calls ``{{ cookiecutter.project_slug }}``, the function ``main`` in the file ``src/{{ cookiecutter.project_slug }}/cli.py`` is called.
