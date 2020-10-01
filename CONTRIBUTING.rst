============
Contributing
============

Contributions are welcome, and they are greatly appreciated!
Every little bit helps, and credit will always be given.

You can contribute in many ways:

Types of contributions
----------------------

Report bugs
~~~~~~~~~~~

Report bugs at https://github.com/MeteoSwiss-APN/mch-python-blueprint/issues.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.

Fix bugs
~~~~~~~~

Look through the GitHub issues for bugs.
Anything tagged with "bug" and "help wanted" is open to whoever wants to implement a fix for it.

Implement features
~~~~~~~~~~~~~~~~~~

Look through the GitHub issues for features.
Anything tagged with "enhancement" and "help wanted" is open to whoever wants to implement it.

Write documentation
~~~~~~~~~~~~~~~~~~~

Cookiecutter PyPackage could always use more documentation, whether as part of the official docs, in docstrings, or even on the web in blog posts, articles, and such.

Submit feedback
~~~~~~~~~~~~~~~

The best way to send feedback is to file an issue at https://github.com/MeteoSwiss-APN/mch-python-blueprint/issues.

If you are proposing a new feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, and that contributions are welcome :)

Get started!
------------

Ready to contribute? Here's how to set up `cookiecutter-pypackage` for local development.

1.  Clone the git_ project locally:

    .. code-block:: bash

      $ cd path_for_the_repo
      $ git clone git@github.com:MeteoSwiss-APN/mch-python-blueprint.git
      $ cd mch-python-blueprint

    Then, create a new branch to work on your bugfix or feature:

    .. code-block:: bash

      $ git checkout -b my_bugfix_or_feature

    .. note::
      Working in a separate branch allows you to commit and push without changing the master branch, and to finally create a pull request to merge your changes back into the master.

2.  Create a new virtual environment:

    .. code-block:: bash

      $ python -m venv venv

    In the following steps, we will use the python executable of the virtual environment explicitly (because explicit is better than implicit, as per the `Zen of Python`_ :-) ):

    .. code-block:: bash

      $ ./venv/bin/python -V

    Alternatively, you can activate the virtual environment:

    .. code-block:: bash

      $ source ./venv/bin/activate
      $ python -V

    Once activated, ``python`` defaults to ``./venv/bin/python``, in which case you can omit ``./venv/bin/`` in the following commands.

3.  Install development dependencies:

    .. code-block:: bash

      $ ./venv/bin/python -m pip install -U pip  # update pip
      $ ./venv/bin/python -m pip install -r ./requirements_dev.txt

4.  Activate `pre-commit hooks`_:

    .. code-block:: bash

      $ ./venv/bin/pre-commit install

    .. note::
      Pre-commit hooks are tools such as syntax checkers or code formatters that are run ahead of every commit.
      This ensures high code quality by preventing the code to slowly drift away from best practices.
      They are defined in the file ``.pre-commit-config.yaml``.

    Run the pre-commit hooks over all files (known to git):

      .. code-block:: bash

        $ ./venv/bin/pre-commit run -a

    There should not be any issues -- but if there are, fix them right away!

    .. note::
      The call to ``pre-commit`` with ``-a`` ran the hooks over all files indexed by git.
      By contrast, when the hooks are triggered by a commit, they are only run over the files to be committed.

5.  Next, run the tests with pytest:

    .. code-block:: bash

      $ ./venv/bin/pytest ./tests

    To ensure that your changes are compatible with different python versions, you should also run tox:

    .. code-block:: bash

      $ ./venv/bin/tox

6.  If your contribution is a bug fix or new feature, you may want to add a test to the existing test suite.
    See section `Add a new test`_ below for details.

7.  Commit your changes and push your branch to github:

    .. code-block:: bash

      $ git add .
      $ git commit -m "fixed this or implemented that"

    If any of the pre-commit hooks detects an issue or changes (e.g., formats) the code, the commit is aborted.
    Fix the issue and/or review the changes by the hooks, re-add the respective files and try to commit again.

    .. note::
      Don't wait with committing until you're done!
      Instead, you should make a commit for each coherent change.
      It doesn't matter how many commits you make to your branch; you can just squash them into a single commit when merging the branch back into master.

    After one or more successful commits, you can push your branch to github:

    .. code:: bash

      $ git push origin my_bugfix_or_feature

8.  Once you're done, submit a pull request through the github website of the project.

Pull request guidelines
-----------------------

Before you submit a pull request, check that it meets these guidelines:

1.  The pull request should include tests.

2.  If the pull request adds functionality, the docs should be updated.
    Put your new functionality into a function with a docstring, and add the feature to the list in ``README.rst``.

3.  The pull request should work for the relevant Python versions.
    This can easily be tested with tox.

Add a new test
---------------

When fixing a bug or adding features, it's good practice to add a test to demonstrate your fix or new feature behaves as expected.
These tests should focus on one tiny bit of functionality and prove changes are correct.

To write and run your new test, follow these steps:

1.  Add the new test to `tests/test_bake_project.py`.
    Focus your test on the specific bug or a small part of the new feature.

2.  If you have already made changes to the code, stash your changes and confirm all your changes were stashed:

    .. code-block:: bash

      $ git stash
      $ git stash list

3.  Run your test and confirm that your test fails:

    .. code-block:: bash

      $ ./venv/bin/pytest ./tests

    If your test does not fail, rewrite the test until it fails on the original code.

4.  (Optional) Run the tests with tox to ensure that the code changes work with different Python versions:

    .. code-block:: bash

      $ ./venv/bin/tox

5.  Proceed work on your bug fix or new feature, or restore your changes from the stash.
    To restore your stashed changes and confirm their restoration:

    .. code-block:: bash

      $ git stash pop
      $ git stash list

6.  Rerun your test and confirm that your test passes.
    If it does, congratulations!

7.  Commit your test and -- if you have not already done so -- your code changes.

.. _`Zen of Python`: https://www.python.org/dev/peps/pep-0020/
.. _`pre-commit hooks`: https://pre-commit.com/hooks.html
.. _git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
