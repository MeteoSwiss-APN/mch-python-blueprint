
-> `Old README`_ (pre-2020)

.. _`Old README`: readme/readme_old.rst


===========================
MeteoSwiss Python Blueprint
===========================

Cookiecutter_ template for a Python package.

* GitHub repo: https://github.com/MeteoSwiss-APN/mch-python-blueprint/
* Free software: BSD license

.. _Cookiecutter: https://github.com/audreyr/cookiecutter

Features
--------

* Write clean code following best practices like `PEP 8`_
* Auto-format your code consistently with `black`_ and `isort`_
* Prevent common coding mistakes with `flake8`_
* Comprehensively test your code with `pytest`_ and `pytest-cov`_
* Ensure compatibility with multiple Python versions with `tox`_

* Develop in a reproducible environment with `virtualenv`_ + `pip`_ or `pipenv`_
* Properly package your code with `setuptools`_
* Increment the package version number in one with `bumpversion`_
* Install your package and its dependencies in one command with `pipx`_

* Create a documentation with `Sphinx`_
* Add a modern command line interface with `click`_ (optional)

.. _`black`: https://github.com/psf/black
.. _`bumpversion`: https://github.com/c4urself/bump2version
.. _`click`: https://github.com/pallets/click
.. _`flake8`: https://github.com/PyCQA/flake8
.. _`isort`: https://github.com/timothycrosley/isort
.. _`PEP 8`: https://www.python.org/dev/peps/pep-0008/
.. _`pipenv`: https://github.com/pypa/pipenv
.. _`pip`: https://github.com/pypa/pip
.. _`pipx`: https://github.com/pipxproject/pipx
.. _`pytest-cov`: https://github.com/pytest-dev/pytest-cov
.. _`pytest`: https://github.com/pytest-dev/pytest
.. _`setuptools`: https://github.com/pypa/setuptools
.. _`sphinx`: https://github.com/sphinx-doc/sphinx
.. _`tox`: https://github.com/tox-dev/tox
.. _`virtualenv`: https://github.com/pypa/virtualenv


Quickstart
----------


Create a New Package
^^^^^^^^^^^^^^^^^^^^

Check your Python version (we recommend ``>= 3.7``)::

    python --version

You may have to load an environment module, for example::

    module load python/3.7.2

Create a new package using `cookiecutter`_ based this `blueprint`_::

    cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint.git

.. _`blueprint`: https://github.com/MeteoSwiss-APN/mch-python-blueprint.git

If you get an error because cookiecutter is not installed, try this::

    pipx run cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint.git

(For more on pipx, see `Deployment`_.)

.. _`Deployment`: readme/deployment.rst

You will ask be a few questions about you and your project, and an empty package will be created based on the answers.
We will call our package ``great_tool`` in these examples.


Upload It to Github
^^^^^^^^^^^^^^^^^^^

Create a local `git`_ repository for ``great_tool`` and commit all files::

    cd great_tool
    git init
    git add .
    git commit -m 'initial commit'

.. _`git`: https://github.com/git/git

Create a `new repository`_ for your package on the `APN github`_ and upload it::

    git remote add origin git@github.com:MeteoSwiss-APN/great_tool
    git push -u origin master

.. _`new repository`: https://github.com/new
.. _`APN github`: https://github.com/MeteoSwiss-APN


Create a Virtual Environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To avoid `dependency hell`_, develop (and ultimately deploy) your package in its own `virtual environment`_.
We recommend the standard `virtualenv`_ + `pip`_ approach, but note that there are many auxiliary and/or alternative tools such as `pipenv`_ (see `Using Pipenv`_), `poetry`_, `virtualenvwrapper`_, `pip-tools`_, etc..

.. _`Using Pipenv`: readme/using_pipenv.rst

.. _`dependency hell`: https://en.wikipedia.org/wiki/Dependency_hell
.. _`pip-tools`: https://github.com/jazzband/pip-tools
.. _`poetry`: https://github.com/python-poetry/poetry
.. _`virtualenvwrapper`: https://virtualenvwrapper.readthedocs.io/en/latest/
.. _`virtual environment`: https://realpython.com/python-virtual-environments-a-primer/

Because each project should have its own virtual environment, a common practice is to place the directory (which we will name ``venv``) in the project root: ``great_tool/venv/``.
Just make sure never to accidentally commit it to your git repository!
To prevent this, add the name of the directory to your ``.gitignore`` file -- common names like ``venv`` are already in there.
Wherever you place it, make sure that you remember its location and that there is enough disk space available (``100M-1G``) -- so at CSCS, you may want to work on ``$SCRATCH`` rather than in your ``$HOME``.

If your not still there, enter your package root and initialize a new empty virtual environment::

    cd great_tool
    python -m virtualenv venv

In order to work in the virtual environment, you must activate it::

    source venv/bin/activate

Your bash prompt should now be prefixed with ``(venv)`` (or with whatever you passed with `--prompt`_).
Running ``which python`` will show that your active Python executable resides in ``venv``, and so will all packages that you subsequently install with pip (e.g., ``python -m pip install ipython``).

Note that you don't need to stay in your project folder -- as long as the virtual environment is active, you can use all packages you've installed in it, and even install and/or remove them!

Once you're done working on your project, you can leave the virtual environment by typing ``deactivate``.
To remove the environment -- for instance if it contains many packages you don't need anymore -- you can simply delete it: ``rm -rf venv``.

.. _`--prompt`: https://virtualenv.pypa.io/en/stable/reference/#cmdoption-prompt


Install Your Tool and Its Dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To run your tool while developing it, you best install it into your virtual environment in `editable mode`_::

    cd great_tool               # if you're still already there
    source ./venv/bin/activate  # if it's not still active
    pip install -e .

.. _`editable mode`: https://pip.pypa.io/en/stable/reference/pip_install/#editable-installs

This will install your tool as ``venv/bin/great-tool``, but use the source files in ``src/great_tool/`` (rather than copy them to a place like ``venv/lib/great_tool/``) -- so if you make changes to your code, they will immediately take effect.

You may have noticed that additional packages required by ``great_tool`` have already been installed alongside it.
But how did ``pip`` know about them -- and how did it find your source files in the first place?
All this is specified in the script ``setup.py`` and its configuration file ``setup.cfg`` -- including its dependencies.

Not all dependencies are equal, however, and some additional packages that we'll need to work on the code are specified elsewhere and thus not yet available.
Generally, we must distinguish different types of dependencies:

* runtime dependencies, which comprise all packages that are required to use ``great_tool``, e.g., ``click`` or ``numpy``;
* testing dependencies, which comprise all additional packages required to run the tests, e.g., ``pytest``; and
* development dependencies, which are only used while working on the code, e.g., ``ipython`` or ``black``.

Runtime and testing dependencies are necessary to install the package and test that it works -- this is why they are specified in ``setup.cfg`` and have already been installed.
Development dependencies, on the other hand, are unnecessary to install and use a package, which is the primary concern of ``setup.py`` and ``setup.cfg``.
(In addition, they are also more subject to personal preferences -- for instance, some developers may prefer ``pipenv`` over ``virtualenv+pip``.)
Instead, they are specified in ``requirements-dev-unfrozen.txt``, and we can install them as follows::

    pip install -r requirements-dev-unfrozen.txt

Now we're good to go!


A Note on Dependencies and Versions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are two ways of specifying dependencies:

* directly used packages only (top-level dependencies), with enough restrictions on version numbers to prevent conflicts, but no more; and
* all packages, including dependencies of dependencies, with pinned version numbers.

The former approach makes it easy to keep dependencies up-to-date, but comes at the risk of newly introduced conflicts; while the latter approach ensures reproducibility, but makes it difficult to update dependencies to newer versions.

To get the best of both worlds, it is customary to provide both, which provides users of a tool with a reproducible environment garantueed to work, while allowing developers to update those pinned dependencies based after making sure the tool works in an up-to-date environment created on the basis of unpinned top-level dependencies.

We specify the dependencies of ``great_tool`` as follows:

+-------------------------------+-------------------+-----------+-------------------+
| file                          | dependencies      | pinned    | creation          |
+===============================+===================+===========+===================+
| setup.cfg                     | runtime & testing | no        | manually          |
+-------------------------------+-------------------+-----------+-------------------+
| requirements.txt              | runtime & testing | yes       | ``pip freeze``    |
+-------------------------------+-------------------+-----------+-------------------+
| requirements-dev-unfrozen.txt | development       | no        | manually          |
+-------------------------------+-------------------+-----------+-------------------+
| requirements-dev.txt          | all               | yes       | ``pip freeze``    |
+-------------------------------+-------------------+-----------+-------------------+
