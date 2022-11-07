***********************
FAQ and Troubleshooting
***********************

**Q:** Copier fails with a :code:`plumbumError` or something else that I can not make sense of, what on earth is this?

**A:** We don't know. But you probably have a good chance of fixing the issue by installing a recent version of git
(:code:`module load git`) on CSCS machines.


**Q:** After installing my package, I get import errors, when I try to run, test or lint. Why?

**A:** If you get lots of them, did you install your package with pip (add -e if you need an editable installation for development)?

.. code-block::

    conda activate <package_env>
    cd </package/root/directory>
    pip install --no-deps .

If yes, are you sure you didn't miss any dependencies in :code:`requirements/requirements.yml` or
:code:`requirements/dev-requirements.yml`?


**Q:** Running pre-commit on GH actions is nice, but can I run checkers locally and maybe even during development
(i.e. before committing)?

**A:** Sure! If you want the pre-commit hooks to run automatically on every local commit, you can set up pre-commit locally.

.. code-block::

    conda activate <dev-package_env>
    cd </package/root/directory>
    pre-commit install

If you prefer to run pre-commit independent of committing, you can run the hooks over all files by
navigating to your package root directory and typing :code:`pre-commit run --all-files`.


**Q:** Yes OK, but I prefer to run my favorite formatter/ linter/ tool in isolation. Can I do that?

**A:** Absolutely, these are standard Python tools. Make sure you are in the dev environment and then check the respective docs
on how to run the tools from the command line.


**Q:** Typing is very non-pythonic, I don't want to and I do not type my code. Still mypy is complaining, can I switch it off somehow?

**A:** Yes, the easiest way is to remove the corresponding hook in :code:`.pre-commit-config.yaml`. It's then cleaner to also remove the
mypy section in :code:`pyproject.toml`. Of course you can do the same with any of the linters and formatters, but we strongly
encourage you to keep the linters and formatters and use ignore or exclude statements in your source code. This way you know, where
the weaknesses of your code are.


**Q:** Linters and formatters behave differently locally and on the Github actions server.

**A:** First, if possible, update your environment and dev-environment locally. Issues might diverge over time. Then, if you run the
checkers and linters locally, make sure they use the settings defined in :code:`pyproject.toml`. If this doesn't help or if it is
unclear, where the problems arise, report your findings and open an issue.
