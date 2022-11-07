********************************
CI / CD (Jenkins and GH Actions)
********************************

The philosophy behind the default CI/CD setup that comes with the blueprint is that it is impossible to merge to the main branch without
running tests, formatters and linters. Two main frameworks are available: On the one hand, the invocation of pre-commit on a Github
actions workflow should check your unpinned environments on a Github actions server. This is important as it ensures that you do not run into compatibility
issues with the most recent versions of the packages in your dependency tree. On the other hand, the Jenkins pipeline tests production installations (pinned, non editable)
on CSCS machines. This is only required for packages that go into production.


GH Actions workflow
-------------------
Upon merges to the main branch (and in pull requests), your package is built, formatted, checked and tested on a Github actions server.
You can check what is done in the workflow in :code:`.github/workflows/pre-commit.yml`.


Jenkins
-------
If your code is going into production, it must be tested on CSCS machines with Jenkins. There are templates available in the `jenkins/` folder.
Contact DevOps to help you set up the Jenkins pipeline and to connect Jenkins to your repository.


A word on tox
-------------
Tox is a framework to automatically test multiple environments. If you plan to deploy your package (public) on Pypy or conda, it is a
good idea to adapt your GH actions workflow to make tox run pre-commit for different Python versions. This will ensure that users
downloading your package have some flexibility in package and Python versions. If you are at this point, you are probably experienced
enough to set up GH actions accordingly.

Tell me more: What does tox do?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Tox <https://github.com/tox-dev/tox>`__ is an automation framework to run arbitrary commands in isolated virtual environments.
In addition to running tools like the linters flake8, mypy or pylint that check the correctness of the code, tox can also easily be set up to run unit tests (e.g., with pytest) against multiple installed Python versions (e.g., 3.7, 3.8, 3.9) to ensure broad compatibility.

.. note::
    While less critical for end-user applications, ensuring compatibility with multiple Python versions is crucial for libraries that are used in other applications.


The fact that tox runs the tools isolated in virtual environments has the advantage that it also tests whether the project is properly installable.
For instance, if some necessary data files are not listed in MANIFEST.in and thus not copied alongside the code, this won't be detected when tests are run directly in the working directory, but tox will fail because those files will be missing.
On the flip side, creating the virtual environment and installing the dependencies (or at least verifying that they are installed) introduces some overhead, which means that running fast unit tests may take significantly longer if run with tox.
