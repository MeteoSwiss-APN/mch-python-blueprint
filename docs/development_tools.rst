
*****************
Development Tools
*****************

What development tools come with the Blueprint?
-----------------------------------------------

The blueprint provides a variety of tools that assist in development:

-   Frameworks:

    -   `pre-commit <https://github.com/pre-commit/pre-commit>`__: Framework for managing git pre-commit hooks.
    -   `Github Actions <https://github.com/features/actions>`__: Automated triggering of actions upon Github events (like push, merge, etc.)
    -   `tox <https://github.com/tox-dev/tox>`__: Automation framework to run arbitrary commands -- e.g., pytest, mypy, pylint etc. -- in isolated virtual environments and easily test a Python program against multiple installed Python versions.
    -   `pytest <https://github.com/pytest-dev/pytest>`__: Unit testing framework suitable for very small, but also bigger tests.

-   Formatters:

    -   `black <https://github.com/psf/black>`__: The "uncompromising" (i.e., minimally configurable) code formatter that auto-formats Python code in accordance with `PEP 8 <https://www.python.org/dev/peps/pep-0008/>`__ and best practices with the goal to minimize diffs between code changes.
    -   `isort <https://github.com/PyCQA/isort>`__: Auto-formatter that sorts and groups Python import statements.

-   `Linters <https://en.wikipedia.org/wiki/Lint_(software)>`__:

    -   `flake8 <https://github.com/PyCQA/flake8>`__: Wrapper of static code analysis tools checking Python code for `errors <https://github.com/PyCQA/pyflakes>`__, `style <https://github.com/PyCQA/pycodestyle>`__ and `complexity <https://github.com/PyCQA/mccabe>`__.
    -   `mypy <https://github.com/python/mypy>`__: Static type checker relying on `type hints <https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html>`__ introduced in Python 3.6.
    -   `pydocstyle <https://github.com/PyCQA/pydocstyle>`__: Static checker for correctness and completeness of docstrings.
    -   `pylint <https://github.com/PyCQA/pylint>`__: Static code analysis tool (linter) checking for errors, standard compliance, code smells etc.

-   Various:

    -   `codespell <https://github.com/codespell-project/codespell>`__: Spell checker aimed at detecting common misspellings in code.

How are these tools supposed to be run?
---------------------------------------

All tools can be invoked via the command line, either via a framework they are embedded in (we recommend *pre-commit*), or directly.
All formatters and linters listed above as well as pytest are run through Github actions and pre-commit upon pushes to the main branch.
You can of course customize the corresponding plan (*.github/workflows/precommit.yml*) and the configuration of *pre-commit* (*.pre-commit-config.yaml*), but you should not remove checks
excessively. Additionally, builds and tests for production software must be run through the Jenkins CI/CD framework to guarantee
that the builds are running on CSCS machines. Plans for builds on pull requests to the main as well as for nightly builds are
included in the `jenkins/` folder. These builds and tests cover exclusively pinned non-editable installations. Contact DevOps for
the setup of your Jenkins pipeline if you need one (i.e. if your code goes into operation).

Where do I customize linters, checkers, GH workflows, etc.
----------------------------------------------------------

First, with great power comes great responsibility. Adapt linter settings carefully. One idea of the blueprint is to enforce coding standards throughout
APN to make the life of DevOps and OSM easier. Clearly, this idea is sabotaged if everyone uses their favorite linter settings, pre-commit hooks, etc..
The settings for the linters and checkers are set in *pyproject.toml* in the corresponding tools sections. Pre-commit hooks (what is run through
pre-commit) is controlled in *.pre-commit-config.yaml*. Finally the jenkins plan and the plans in *.github/workflows* control the CI/CD pipelines.


What do I need to know about versioning?
----------------------------------------

You can increase the version number in `pyproject.toml`. Version numbers are crucial to identify versions of a software, for instance to determine whether a certain feature or bugfix is present.
There are different version number schemes suitable for different project complexities, release schedules etc.

A popular approach is `semantic versioning <https://semver.org/>`__ (often *semver*) with version numbers ``X.Y.Z`` composed of three components: *major*, *minor* and *patch*.
An increase in a specific component conveys the scope of change from the previous version:

-   *major*: incompatible API changes;
-   *minor*: backward-compatible additions of functionality;
-   *patch*: bug fixes.

While the boundaries between these types of changes are `not always clear <https://snarky.ca/why-i-dont-like-semver>`__, this provides a good starting point to versioning a project.

.. note::
    For relatively simple projects, two components ``X.Y`` may be enough, with the major component indicating non-compatible (or otherwise major) changes and the minor component indicating backward-compatible feature additions and bug fixes.

I write beautiful code, I don't need an autoformatter!
------------------------------------------------------

No objection -- but, as the saying goes, beauty is in the eye of the beholder!
This applies to Python code as much as to the world at large.

While its syntax (enforced whitespace) and best practices (`PEP 8 <https://www.python.org/dev/peps/pep-0008/>`__) put some constraints on the formatting of Python code, they leave considerable freedom to the programmer, for example `how to indent long function calls and signatures <https://www.python.org/dev/peps/pep-0008/#indentation>`__:

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

There are several popular Python formatters, among them `Autopep8 <https://github.com/hhatto/autopep8>`__, `Yapf <https://github.com/google/yapf>`__ and `Black <https://github.com/psf/black>`__, all with their `strengths and weaknesses <https://www.kevinpeters.net/auto-formatters-for-python>`__.
The Blueprint uses Black because it provides the most freedom of mind due to minimal freedom of choice: By design, it is as unconfigurable as possible, which prevents major discussions over minor formatting choices to be simply migrated from the code itself to the formatter configuration.
Black follows a relatively small number of rules aimed at readability and diff minimization that quickly become intuitive.
Following are a few examples from the `Black README <https://github.com/psf/black>`__:

.. code:: python

    # in:
    j = [1,
         2,
         3
    ]

    # out:
    j = [1, 2, 3]

.. code:: python

    # in:
    ImportantClass.important_method(exc, limit, lookup_lines, capture_locals, extra_argument)

    # out:
    ImportantClass.important_method(
        exc, limit, lookup_lines, capture_locals, extra_argument
    )

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

.. note::
    If you're still sceptical about auto-formatters in general or Black's formatting choices in particular, just try it out for some time.
    Chances are you will get used to the specific formatting choices and come to enjoy the freedom of focusing on what the code does.
    Also, the next time you unearth some script from your distant past, you won't spend an afternoon reformatting it but a mere couple of seconds!

What are pre-commit hooks?
--------------------------

`Pre-commit hooks <https://github.com/git/git/blob/master/templates/hooks--pre-commit.sample>`__ are one type of `git hooks <https://githooks.com/>`__ -- scripts that are automatically triggered by certain git events.
As their name suggests, pre-commit hooks are executed ahead of commits, which is an ideal time to ensure that the code meets certain standards of quality and correctness, i.e., to apply formatters and linters to the code.
Thanks to the popular `framework <https://pre-commit.com/>`__ with the same name, pre-commit hooks are very easy to set up and manage thanks to many `ready-made hooks <https://pre-commit.com/hooks.html>`__ ranging from `small utilities <https://github.com/pre-commit/pre-commit-hooks>`__ that remove trailing whitespace, check symlinks or sort files to full-fledged linters like `mypy <https://github.com/pre-commit/mirrors-mypy>`__ or `pylint <https://github.com/PyCQA/pylint>`__.

As a default, pre-commit is invoked through Github actions upon merges to the master. You may however find it useful to be able to run pre-commit for your local commits. To do so, you can either run it manually with :code:`pre-commit run --all-files` or you can set it up with :code:`pre-commit install` to run on each and every commit. Once pre-commit hooks are active, they are triggered whenever you attempt to commit a change.
The checkers and formatters are applied to the changed lines or files (depending on the tool), and the commit is only completed if all checks are successful.
If any checker finds an issue or makes a change to the code, the commit is aborted and it is up to you to fix any problems and/or review changes before reattempting the commit.
While this may sound cumbersome, that is really not the case if you keep your commits reasonably small -- the whole point of pre-commit hooks is to prevent these minor issues from accumulating over time thanks to frequent micro-cleanups.

The Blueprint provides pre-commit set up with several useful tools which are primarily aimed at code formatting.
In addition to some small checkers and fixers (find debug statements, remove trailing whitespace, check validity of toml/yaml files), these are:

- `black <https://github.com/psf/black>`__ to format the code;
- `isort <https://github.com/PyCQA/isort>`__ to sort and group imports; and
- `pydocstyle <https://github.com/PyCQA/pydocstyle>`__ to check doc strings.

.. note::
    Another good candidate, the spell checker `codespell <https://github.com/codespell-project/codespell>`__, is among the default development dependencies, but is not set up as a pre-commit hook because while it is very useful to find misspellings, it finds too many false positives, which are easy to ignore by eye but not by pre-commit.
    We strongly recommends to occasionally run codespell manually, though, in order to keep misspellings to a minimum.

After creating a new project and installing the development dependencies, pre-commit must be activated:

.. code:: bash

    ./venv/bin/pre-commit install           # hook into git
    ./venv/bin/pre-commit run --all-files   # run hooks the first time


.. note::
    If you have a good reason to make a commit despite failing pre-commit hooks, you can forego the checks with ``--no-verify``.
    However, this should not be done routinely, but only in exceptional circumstances.

Tell me about pytest!
---------------------

See `github page <https://github.com/pytest-dev/pytest>`__ and `documentation <https://docs.pytest.org/en/stable/contents.html>`__.

Tell me about flake8!
---------------------

See `github page <https://github.com/PyCQA/flake8>`__ and `documentation <https://flake8.pycqa.org/en/latest/>`__.

Tell me about pylint!
---------------------

See `github page <https://github.com/PyCQA/pylint>`__ and `documentation <http://pylint.pycqa.org/en/latest/>`__.

Tell me about mypy!
-------------------

See `github page <https://github.com/python/mypy>`__ and `documentation <https://mypy.readthedocs.io/en/stable/>`__.

Why should I want to declare variable types in Python?
------------------------------------------------------

Python is a dynamically typed language where the types of variables do not need to be declared and can indeed change freely.
This is in contrast to statically typed languages like C or Fortran, where the variable types must be declared and cannot change freely.
Dynamic typing makes it very easy to write Python scripts, to reuse functions with custom objects, and so forth.
However, at least some type information is usually necessary, especially in interfaces, e.g., when an argument is expected to be a number, a string or a list.
This information is usually provided in docstrings.
The problem with type information in docstrings is that it cannot be easily verified and is in danger of becoming outdated when an interface changes but the docstring is not adapted accordingly.

To address this issue, Python gradually introduced the concept of type hints, initially as comments but eventually as part of the language.
The `modern type hint syntax <https://www.python.org/dev/peps/pep-0484/>`__ has been introduced in Python 3.5 and is based on `function annotations <https://www.python.org/dev/peps/pep-3107/>`__
The hints can be parsed by external tools like `mypy <http://mypy-lang.org/>`__, which use them together type information derived from variable assignments to perform static type analysis.
This allows them to detect errors such as passing a string to a function that expects a bool, as illustrated in this example (`source <https://realpython.com/python-type-checking/#hello-types>`__):

.. code:: python

    # headlines.py

    def headline(text: str, align: bool = True) -> str:
        if align:
            return f"{text.title()}\n{'-' * len(text)}"
        else:
            return f" {text.title()} ".center(50, "o")

    print(headline("python type checking"))
    print(headline("use mypy", align="center"))

.. code:: bash

    $ mypy headlines.py
    headlines.py:10: error: Argument "align" to "headline" has incompatible type "str"; expected "bool"

For more information on type hints, see the `mypy cheat sheet <https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html>`__ and this `RealPython guide <https://realpython.com/python-type-checking/>`__.

.. note::
    In contrast to statically typed languages, however, the type information is not used at runtime to increase performance, and also won't be used to that end in the future (at least by CPython, the official Python interpreter).
    Type hints are therefore best thought of as testable documentation.
