
********************
Virtual Environments
********************

On virtual environments
-----------------------

By default, `pip <https://pip.pypa.io/en/stable/>`__ installs Python packages system- or (with ``--user``) user-wide.
This makes them conveniently available, but can lead to version conflicts and more generally to a non-reproducible environment, as package versions will inevitable differ between machines or over time.

.. note::
    A situation where multiple packages depend on different versions of a shared dependencies is called `dependency hell <https://en.wikipedia.org/wiki/Dependency_hell>`__.
    For example, tool A may require version ``< 2.0`` of dependency D, while tool B requires the same package, version ``>= 3.0``.
    You are then forced to choose between tools A and B because you cannot install both alongside each other!
    And if, god forbid, your system also depends on dependency D, but on version ``2.*``, you are forced to abandon both packages.

To avoid dependency hell, packages can instead be installed into self-contained containers called *virtual environments* which are isolated from the system installation.
Multiple virtual environments can easily coexists, which allows one to create designated environments for individual projects that contain all its Python dependencies, both during development and deployment.
Because the package versions in a virtual environment are independent from those required by the system, identical, reproducible environments can be maintained over time and on different machines.

.. note::
    Virtual environments are tied to an existing Python installation, i.e., Python itself is not part of a virtual environment, but only linked.
    Multiple versions of Python can be easily installed with `Pyenv <https://github.com/pyenv/pyenv>`__, which allows virtual environments using different Python versions to coexist.
    Alternatively, `Conda <https://docs.conda.io/en/latest/>`__ provides virtual environment with a wider scope, including the Python installation itself as well as non-Python dependencies such as C libraries.

Create a virtual environment
----------------------------

A Python virtual environment is created like this:

.. code:: bash

    python -m venv ./venv --prompt=my-tool

This will create the directory ``./venv`` (any valid path can be passed), into which directories like ``bin`` and ``lib`` are placed.
Tools installed into the virtual environment that can be executed on the command line are found in ``./venv/bin/``.
Among them, notably, is ``python`` itself:

.. code:: bash

    $ ls -l venv/bin/python
    lrwxrwxrwx 1 stefan stefan 50 Oct  1 13:05 venv/bin/python -> /home/stefan/local/pyenv/versions/3.7.4/bin/python*

Because the Python installation is not part of the virtual environment, ``venv/bin/python`` is only a symlink to the installation used to create the virtual environment (in this example, one managed by  `Pyenv <https://github.com/pyenv/pyenv>`__).
However, by using ``./venv/bin/python`` instead of plain ``python`` to, e.g., run a script, the packages installed in ``./venv`` will be used.

For convenience, the ``Makefile`` provides the command ``make venv`` (which is automatically invoked by commands like ``make install`` if there is no active or local virtual environment yet).

How to work in a virtual environment
------------------------------------

As mentioned, all command line tools installed in a virtual environment can be found in ``./venv/bin/``, including ``python`` itself.
Thus, you can simply call those executables explicitly:

.. code:: bash

    ./venv/bin/python -m pip install black
    ./venv/bin/black my_script.py
    ./venv/bin/python my_script.py

This explicit approach ensures that never accidentally use the system installation, but it can be cumbersome to always type the path, especially outside of the project root.
To make matters easier, you can activate the virtual environment, which adds ``./venv/bin`` to your ``$PATH``, which makes its contents available wherever you are:

.. code:: bash

    $ which python
    /home/stefan/local/pyenv/shims/python
    $ source ./venv/bin/activate
    (my-tool)$ which python
    /home/stefan/work/git/meteoswiss-apn/mch-python-blueprint/venv/bin/python

As long as the virtual environment is active, your prompt will be preceded by its name, e.g., ``(my_tool)`` as a reminder.

.. note::
    If you customize your bash prompt by defining ``$PS1`` in ``~/.bashrc``, make sure not to re-source the latter from inside a virtual environment, because this will remove the indicator ahead of the prompt.
    Your virtual environment will then still be active, but you may will no longer be aware of it.

All your actions, like installing or upgrading packages, will now be confined to the virtual environment.

Once you're done working on the project, you can deactivate the virtual environment by typing:

.. code:: bash

    deactivate

(This will run ``./venv/bin/deactivate``, the complement of ``./venv/bin/activate``.)

Your bash prompt will no longer be preceded by ``(my-tool)``, and ``which python`` will again point you to the system installation.

Where to put your virtual environments
--------------------------------------

From a technical perspective, it's totally up to you where to put your virtual environments.
They are self-contained, so there is no reason to put them inside the project you're working on, you only need to remember where you put it.

Because each project should have its own virtual environment, it is customary during development to put the respective virtual environment into the project root in a directory with a generic name like ``venv`` (as in the examples above) which is also added to ``.gitignore``.
This layout is used both in this document and in the projects created with the Blueprint (e.g., by the ``make venv*`` commands defined in ``Makefile``).

However, a virtual environment can quickly grow in size to dozens or even hundreds of megabytes.
While small by today's standards, this size may still become a problem on systems with a strict and relatively small quota, like the home folders at CSCS.
In that case, you may want to either work on ``$SCRATCH`` entirely, or at least move the virtual environments there.
They can easily be created on ``$SCRATCH`` and symlinked to the respective project in ``$HOME`` so the workflow does not change.

Alternatives to ``venv+pip``
----------------------------

Venv is the built-in virtual environment tool in Python 3, and in combination with the Python package installer Pip -- thus ``venv+pip`` -- provides all the functionality to work with virtual environments.
However, there is a range of alternative thid-party tools which provide different approaches, interfaces and/or additional functionality:

-   **Virtualenv**: This package is essentially identical to ``venv``, but has been around longer (since Python 2) and is a third-party module that is not shipped with the standard library.
    Many manuals thus refer to ``virtualenv`` and ``virtualenv+pip`` as the standard approach.
    If you only use Python 3, just replace ``venv`` with ``virtualenv``.

-   **Virtualenvwrapper**: It's all in the name: This third-party tool is a wrapper of ``virtualenv`` providing an alternative interface.
    Virtual environments are stored in a central location which the user does not need to remember, and can be created, activated, and removed from anywhere in the system using their name.
    To install Packages within a virtual environment, you will still have to use ``pip`` explicitly.

-   **Pipenv**: This third-party tool aims to combine and abstract both the creation of virtual environments and the installation of packages therein.
    It uses ``virtualenv+pip`` under the hood and thus essentially constitutes a wrapper for the standard solution.
    It is often (somewhat erroneously) referred to as the officially recommended tool (and may someday become that), and is generally regarded as convenient and beginner-friendly.
    If you prefer ``pipenv`` over ``venv+pip`` for development, see below how to handle dependencies (``Pipfile`` vs. ``requirements/*.txt`` etc.).

-   **Conda**: Often used in science, ``conda`` (*Anaconda* or *Miniconda*) is another solution that handles both virtual environments as well as the packages therein, similar to ``pipenv``.
    In contrast to all aforementioned tools, however, it does not restrict itself to Python packages, but is a full-fletched language-agnostic package manager that can also handle Python itself as well as non-Python dependencies like C-libraries.
    Conda environments thus provide a substantially higher degree of isolation from the system environment than conventional Python virtual environments.
    On the flip side, because Conda uses its own package repositories (as opposed to the PyPI), some packages can occasionally be outdated.

In addition, some other tools often come up in the context of virtual environments:

-   **Pyenv**: A tool to install multiple versions of Python (no root required) and switch between them.
    It even allows one to use a certain Python version inside a certain directory (and its subdirectories), which for examples makes it possible to develop different projects with different Python versions.

-   **Pipx**: A tool to install Python command lines applications with a single command.
    It installs each application package and all its dependencies into a designated virtual environment.
    More details and examples are provided below.
