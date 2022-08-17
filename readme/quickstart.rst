
**********
Quickstart
**********

Prepare your environment
------------------------

Ensure that your active Python version is 3.7 or higher.
The recommended way to manage Python versions is with `Conda <https://docs.conda.io/en/latest/>`__. On CSCS machines it is recommended to install the leaner `Miniconda <https://docs.conda.io/en/latest/miniconda.html>`__, which offers enough functionality for most of our use cases. 

Next, install `Cookiecutter <https://github.com/cookiecutter/cookiecutter>`__.
The recommended way is to set up a conda environment and install it there. Once your package is created you do not need cookiecutter anymore and you can safely delete the generated environment.

.. note::
    Because you only need the `cookiecutter` shell command, on your own computer you may even install it with your system package manager -- something you should never do for packages you need as dependencies, as explained in detail in `Virtual Environments <virtual_environments.rst>`__.

Create a new project
--------------------

To create a new project and start developing, run these commands:

.. code:: shell

    cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint

The cookiecutter command will ask you for some information on you and your project.
The parameter "sample_code" allows you to choose the amount of sample code to be included:

-   'no': No sample code is provided beyond an empty `main()` function in the `cli.py` file.
    This is useful if you are migrating an existing project into a new Blueprint project.
-   'cli': A basic command line interface based on `click <https://click.palletsprojects.com>`__ is pre-defined, including some basic tests.
    This is useful if you start from scratch but hit the ground running in terms of command line options.
-   'calculator': A fully-functional simple program that performs chained calculations, including a class and tests.
    This is useful to explore the Blueprint and the possibilities offered by `click <https://click.palletsprojects.com>`__.


Set up your project
-------------------

Create the repository on MeteoSwiss-APN github. **Attention**: the name here must correspond to the information given to cookiecutter. A .gitignore template is not needed as there is one provided in the blueprint. Go to the repository created by cookiecutter, i.e. your project repository and initialize git with the following sequence of commands:

.. code:: bash

    git init
    git add .
    git commit -m “initial commit”

Then follow the steps on GitHub under the headline “”…or push an existing repository from the command line“ to connect your repository to the remote on GitHub. To install your package, follow the instructions given in `docs/installation.rst` in your project repository.


.. code:: bash

    git_dir=...  # e.g., ~/.local/git
    venvs_dir=...  # e.g., ~/.local/venvs
    bin_dir=...  # e.g., ~/.local/bin
    project=...  # e.g., apepi
    version=...  # e.g., v0.2.1
    command1=...  # e.g.,
