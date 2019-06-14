.. highlight:: shell

============
Contributing
============

Contributions are welcome, and they are greatly appreciated! Every little bit helps, and credit will always be given.

You can contribute in many ways:

Types of Contributions
----------------------

Report Bugs
~~~~~~~~~~~

Report bugs at https://github.com/MeteoSwiss-APN/{{ cookiecutter.project_slug }}/issues.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.

Fix Bugs
~~~~~~~~

Look through the GitHub issues for bugs.
Anything tagged with "bug" and "help wanted" is open to whoever wants to implement it.

Implement Features
~~~~~~~~~~~~~~~~~~

Look through the GitHub issues for features.
Anything tagged with "enhancement" and "help wanted" is open to whoever wants to implement it.

Write Documentation
~~~~~~~~~~~~~~~~~~~

{{ cookiecutter.project_name }} could always use more documentation, whether as part of the official {{ cookiecutter.project_name }} docs, in docstrings, or even on the web in blog posts, articles, and such.

Submit Feedback
~~~~~~~~~~~~~~~

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
    $ pipenv shell
    $ pipenv install --dev

    $ python setup.py develop # or
    $ pip install -e .

4. Create a branch for local development::

    $ git checkout -b name-of-your-bugfix-or-feature

   Now you can make your changes locally.

5. When you're done making changes, format them with yapf, check that your changes pass the static code analyses with flake8 and the tests with pytest, including testing other Python versions with tox::

    $ yapf -ir {{ cookiecutter.project_slug }}
    $ flake8 {{ cookiecutter.project_slug }} tests
    $ pytest
    $ tox  # optional, currently only flake8 and Python 3.7 configured and thus not necessary

   To get yapf, flake8 and tox, just pip install them into your virtualenv (``pipenv install --dev``).

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
   * - docs
     - Directory containing the documentation.
   * - tests
     - Directory containing the tests.
       The directory structure in this folder is the same as in the source folder (src).
       For each file in the source folder, there is a file with the same name, but, with the prefix ``text_``.
   * - src
     - Source folder.
   * - AUTHORS.rst
     - Contains information about the lead developer and contributors.
   * - CONTRIBUTION.rst
     - Contains all the information you need when you contribute to this project.
   * - HISTORY.rst
     - Lists the releases and their new features.
   * - LICENSE
     - License of this project.
   * - MANIFEST.in
     - Specifies the files and directories which will be added to the Pip package.
   * - Makefile
     - Build file for cleaning, creating and releasing packages, for testing and linting code, and for creating the documentation.
   * - Pipefile
     - Contains all development dependencies (pip packages used for development) in the section ``[dev-packages]`` (as few version restrictions as possible), and the application/library itself as the only entry in the section ``[packages]`` (e.g., ``{{ cookiecutter.project_slug }} = {editable=true, path="."}``).
       Production dependencies (pip packages imported in the source code) are listed in ``setup.py``, which is invoked when installing the current spplication.
       The file is used and managed by pipenv, but can also be edited manually.
   * - Pipfile.lock
     - Contains all recursive dependencies with pinned version numbers to create reproducible virtual environments across users and machines.
       The file is managed automatically by pipenv and must not be edited manually.
   * - README.rst
     - Short documentation about the package.
       It lists features and contains a quick start.
   * - setup.cfg
     - Configuration file for different build tools such as bumpversion, bdist, flake8, pytest, and yapf.
   * - setup.py
     - Script used to build the package.
       It specifies most requirements of the library/application (as few version restrictions as possible):
       * production dependencies (variable ``requirements``),
       * setup dependencies (variable ``setup_requirements``), and
       * testing dependencies (variable ``test_requirements``).
       (Only the development dependencies are listed in ``Pipfile`` instead.)
       In addition, the compatible Python verions are specified (should be the same as in the file ``tox.ini``).
       The requirements and Python versions are usually the only things to adapt in this file.
   * - tox.ini
     - A configuration file for tox carring out the test for different Python verions.
       The listed versions should be the same as in the file ``setup.py``.

Managing dependencies
---------------------

Generally, projects make use of other libraries, be it as (production) dependencies (e.g., ``import numpy`` in source code)
Which libraries -- and, but only if necessary, restrictions regarding their versions -- have to be listed in different places in the project:
* Production dependencies, without which the application/library does not work, belong in ``setup.py`` (``setup(..., installl_requires=[<packages>], ...)``), with as few version restrictions as possible.
* Development dependencies, required for development, belong in ``Pipfile`` (under ``[dev-packages]``), with as few version restrictions as possible.
* Setup and test dependencies, required during setup/testing, belong in ``setup.py`` (``setup(..., setup_requires=[<packages>], tests_require=[<packages>], ...)``), with as few version restrictions as possible.
* Pinned dependencies (all recursively required packages with pinned version numbers) are automatically written to ``Pipfile.lock`` (which must not be edited manually).
* Should a ``requirements.txt`` ever be needed (see `pip requirements file`), pipenv can export pinned dependencies in the respective format (``pipenv freeze > requirements.txt``).

Ensure that the needed libraries and their versions listend in the 3 files are the same.
If at all necessary, it is best practice is to list the minimal compatible version of a package (``>=``), rather than a fixed version (``==``).
Fixed versions should be avoided if possible, as they impede keeping dependencies up-to-date.

.. _`pip requirements file`: https://pip.readthedocs.io/en/1.1/requirements.html
.. _`example Pipefile`: https://pipenv.readthedocs.io/en/latest/basics/#example-pipfile-pipfile-lock

{%- if cookiecutter.command_line_interface|lower == 'click' %}
How to provide executable scripts
--------------------------------

By default, a single executable script called {{ cookiecutter.project_slug }} is provided.
It is created when the package is installed.
When you call it the main function in ``src/{{ cookiecutter.project_slug }}/cli.py`` is called.

How many scripts that are created, their names and which functions are called can be configured in the
``setup.py`` file.
The function ``setup`` has a named argument called ``entry_point`` which is a
dictionary with an element ``console_scripts``.
The element is an array of string.
For Example::

    entry_points={
        'console_scripts': [
            '{{ cookiecutter.project_slug }}={{ cookiecutter.project_slug }}.cli:main',
    ],

When the package is installed, a executable script is created in the Python's bin folder with the name ``{{ cookiecutter.project_slug }}``.
If a user calls this script, the function ``main`` in the file ``src/{{ cookiecutter.project_slug }}/cli.py`` is called.
If more scripts should be created, add further entries to array ``console_scripts``.

{%- endif %}
