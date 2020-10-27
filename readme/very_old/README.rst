===========================
MeteoSwiss Python Blueprint
===========================

Cookiecutter_ template for a Python package.

* GitHub repo: https://github.com/MeteoSwiss-APN/mch-python-blueprint/
* Free software: BSD license

Features
--------

* Testing setup with ``python setup.py test`` and ``pytest``
* Tox_ testing: Setup to easily test for multiple Python versions
* Sphinx_ docs: Documentation ready for generation with, for example, ReadTheDocs_
* Bumpversion_: Pre-configured version bumping with a single command
* Auto-release to PyPI_ when you push a new tag to master (optional)
* Command line interface using Click (optional)

Quickstart
----------

At CSCS, you can load the Python module with following command. It will load the Python environment
and the needed script to start a new project, e.g.:

    .. code-block:: bash

        source ~owm/.python_3.7  # on kesch/escha

Generate a Python package project:

    .. code-block:: bash

        cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint.git

Then:

* Create a repo and put it there

    * Move to your project folder (``cd you_project``)
    * Create localy a repository (``git init``)
    * Add and commit the current content (``git add .`` and ``git commit``)
    * Create an empty repository with the same name on `Github`_
    * Set the remote repository to Github (``git remote add origin git@github.com:MeteoSwiss-APN/new_repo``)
    * Push the content of the local repository to Github (``git push -u origin master``)

* Create a virtual Python environment for your project (see `virtual environments at CSCS`_)
* Install the dev requirements into a virtualenv. (``pipenv install --dev``)
* Release your package by pushing a new tag to master.
* Adapt the `requirements.txt` and `Pipfile` files to specify the packages you will need for your project and their versions. For more info see the `pip docs for requirements files`_.
* Type ``make help`` to learn what make can do for you with your project, e.g.

    * check python style with ``make lint``
    * run unit tests with ``make test``
    * check code coverage with ``make coverage``
    * create Sphinx HTML documentation with ``make docs``
    * install the package to the active Python's site-packages with ``make install``

  and many more!

* Type ``make docs``, and learn more on your project.

.. _Bumpversion: https://github.com/peritus/bumpversion
.. _Cookiecutter: https://github.com/audreyr/cookiecutter
.. _Github: https://github.com/new
.. _PyPI: https://pypi.org
.. _ReadTheDocs: https://readthedocs.org
.. _Sphinx: https://github.com/sphinx-doc/sphinx
.. _Tox: https://github.com/tox-dev/tox
.. _`pip docs for requirements files`: https://pip.pypa.io/en/stable/user_guide/#requirements-files
.. _`virtual environments at CSCS`: venvs_cscs_old.rst
