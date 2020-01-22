
########
Tutorial
########

A step-by-step introduction with examples to the Python blueprint and its components.



On Packages and the Blueprint
=============================


What is this ``Python blueprint``?
----------------------------------

The ``Python blueprint`` is a template for a Python package that includes many necessary and useful components to develop proper Python tools.
It provides:

*   Separate directories for the source code, its tests, and its documentation.
*   A setup script to install the package and its command(s), including all its dependencies.
*   A Makefile that provides many commands to easily set up the package, develop the code, and install it.
*   Clean management of the various types of dependencies (runtime, development, setup).
*   Many pre-configured tools that facilitate the development of clean, well-tested Python code following best practices.
*   Simple management of package version numbers.

In short, it provides all the boilerplate that we know deep down is necessary, but that we hardly ever bother with when developing Python code!


Hold on: What is a package even?
--------------------------------

Some `terminology`_:

*   Module: Each Python file is a module and can be imported by another module to use the functions, classes, etc. it defines.
*   Script: The same as a module, but we generally expect that a script does something when we call it from the command line.
*   Package: A collection of modules that belong together, i.e., any directory containing Python scripts and a file called ``__init__.py``.

However, the term ``package`` is also used to refer to a whole `project`_, i.e., the source code, its tests, and the scripts, configuration files, etc. required to install it -- i.e., everything necessary to develop and install a package in the narrow sense.
That's how we will generally use the term henceforth.

.. _`terminology`: https://realpython.com/python-modules-packages/
.. _`project`: https://packaging.python.org/tutorials/packaging-projects/


Why even bother?
----------------

In short: As with version control, properly packaging a project requires a little more effort which may seem unnecessary in the beginning, but the benefits are real and become apparent quickly!

There is no real need to create whole project packages with all the bells and whistles if all we do is write a simple Python script.
Even if our Python tool consists of multiple modules -- i.e., is a package in the narrow sense -- we can use it without bothering with setup scripts and all that stuff.

However, all this becomes more and move complicated as the code grows, and especially once we want to properly install and share our code.
By turning our project into a proper package (in the wider sense), we can properly bundle our code, its tests, its documentation, and even the tools we use during development.
Once we upload the package to Github or to the `Python Package Index (PyPI)`_, everyone can install it with pip like any other package.

Furthermore, turning all applications we write into proper packages also allows us to isolate them from each other by installing and running each application and its dependencies into a separate virtual environment, which prevents conflicts between incompatible dependences; more on that later.

.. _`Python Package Index (PyPI)`: https://pypi.org/


Alright, how do I get started with the blueprint?
-------------------------------------------------

You find the blueprint `on Github`_, where you may already be if you're reading this.
It is based on the tool `Cookiecutter`_ (which is part of our Python environment at CSCS).
To create a new package, just run this::

    cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint

You will be asked a few questions about yourself and the package you are about to develop::

    $ cookiecutter https://github.com/MeteoSwiss-APN/mch-python-blueprint
    You've downloaded /home/stefan/.cookiecutters/mch-python-blueprint before. Is it okay to delete and re-download it? [yes]: y
    full_name [Donald Duck]: Mickey Mouse
    email [mickey.mouse@meteoswiss.ch]: 
    github_username [mickeymouse]: mmouse 
    project_name [Mickey's Tool]: Random Star Wars Generator
    project_slug [random_star_wars_generator]: star_wars_gen
    project_short_description [Mickey Mouse's shiny new tool.]: A tool to randomly generate more Star Wars movies.
    version [0.1.0]: 

Based on the answers, cookiecutter creates an empty project package::
    
    $ ls star_wars_gen/
    AUTHORS.rst
    CONTRIBUTING.rst
    HISTORY.rst
    LICENSE.txt
    MANIFEST.in
    Makefile
    README.rst
    USAGE.rst
    VERSION.txt
    docs
    requirements
    setup.cfg
    setup.py
    src
    tests

It is not entirely empty, though -- it already contains a few files and some sample code to get you started::

    $ tree star_wars_gen/{src,tests}
    star_wars_gen/src
    └── star_wars_gen
        ├── __init__.py
        ├── cli.py
        ├── star_wars_gen.py
        └── utils.py
    star_wars_gen/tests
    └── star_wars_gen
        ├── test_cli.py
        ├── test_star_wars_gen.py
        └── test_utils.py

Your answers have even been turned into meta data for the package, which may, for instance, eventually help others find your package on PyPI::

    $ head -20 star_wars_gen/setup.cfg
    
    [metadata]
    name = star_wars_gen
    version = 0.1.0
    description = A tool to randomly generate more Star Wars movies.
    description-file =
            README.rst
            HISTORY.rst
    author = Mickey Mouse
    author_email = mickey.mouse@meteoswiss.ch
    license_files =
            LICENSE.txt
    url = https://github.com/mmouse/star_wars_gen
    keywords = star_wars_gen
    classifiers =
        Development Status :: 2 - Pre-Alpha
        Intended Audience :: Developers
        Natural Language :: English
        Programming Language :: Python :: 3
        Programming Language :: Python :: 3.7

Now that you have your package, you can forget all about cookiecutter and even the blueprint itself, because those are only there to help you create a project package -- you are not tied to them at all from this point on.

.. _`on Github`: https://github.com/MeteoSwiss-APN/mch-python-blueprint
.. _`Cookiecutter`: https://github.com/cookiecutter/cookiecutter


Cool, everyone will want to use this! How can I put it on Github?
-----------------------------------------------------------------

A new package already contains some git files like ``.gitignore``, but it is not yet a git repository!
To turn it into a git repository, change into the root directory and run::

    git init
    git add .
    git commit -m 'initial commit'

For your convenience, these a command that does exactly this is defined in the ``Makefile``::

    make git

To upload it to Github, first `create a new repository`_ and then run::

    git remote add origin git+ssh://git@github.com/MeteoSwiss-APN/star_wars_gen.git
    git push --set-upstream origin master

You can now install your tool (into a virtual environment, of course, as described in the next section) as follows::

    python -m pip install git+ssh://git@github.com/MeteoSwiss-APN/star_wars_gen.git

.. _`create a new repository`: https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-new-repository



Virtual Environments
====================


So, what are those virtual environments you've mentioned above?
---------------------------------------------------------------

You can think of a virtual environment as a container that isolates a tool from the system environment, i.e., from any Python packages that are installed system-wide (and may even be part of the system).
Inside this container, you can install all the Python packages that you need to develop and run your tool without any fear of the system environment interfering with your tool -- or of your tool interfering with the system.

Virtual environments prevent you from landing in `dependency hell`_, which describes a situation where different packages depend on different versions of other packages that are incompatible with each other.
For example, one tool may require an old version of a certain package, say lower than ``v2.0``, while another tool requires the same package, but at least ``v3.0`` -- and, worse, your system may depend on ``v2.x``!
If you cannot install different versions of that package alongside each other, you are forced to choose between either of the two tools -- and a working system.

The solution is to create a separate virtual environment for each tool, into which an appropriate version of the required package can be installed, in isolation both from each other and from the system environment.

.. _`dependency hell`: https://en.wikipedia.org/wiki/Dependency_hell


How can I create and work in a virtual environment?
---------------------------------------------------

In Python virtual environment is created like this::

    python -m venv path/to/venv --prompt='(my_tool)'

This will create the directory ``path/to/venv`` (relative to the current directory), which contains directories like ``bin`` and ``lib`` into which the packages (applications and libraries) will be installed.
Importantly, it contains its own Python executable ``path/to/venv/bin/python``.

The easiest way to install packages and work in a virtual environment is by activating it::

    source path/to/venv/bin/activate

This will point ``python`` to ``path/to/venv/bin/python``, as you can check this with ``which python``.
Note that you are free to move around as you wish -- there is no need to remain in the directory from which you've created the virtual environment.

To remind you that the virtual environment is active, your bash prompt will henceforth be preceded by ``(my_tool)``, as we've specified above with the ``--prompt`` option.
(By default, the name of the directory in which the virtual environment resides will be used as the name in the prompt, i.e., ``(venv)``, but because this directory often has a generic name like ``venv``, ``--prompt`` allows one to use a more meaningful name.)

All your actions, like installing or upgrading packages, will now be confined to the virtual environment, and to use a package, you first need to install it (even if it already installed system-wide).
For example, to install iPython, just type::

    python -m pip install ipython

Again, you can use ``which ipython`` to check where it has been installed.

Once you're done working on the project, you can deactivate the virtual environment by typing::

    deactivate

Your bash prompt will no longer be preceded by ``(my_tool)``, and ``which python`` will again point you to the system installation.

(Note that packages can also be installed to the virtual environment without activating it by explicitly using its Python executable, e.g., ``path/to/venv/bin/python -m pip install ipython``; this can be useful in scripts -- for an exammple, see the ``venv-install`` commands in the ``Makefile``.)


Where should I put these virtual environments?
----------------------------------------------

That's totally up to you!
Everything related to a virtual environment is contained in the folder in which it has been created, and it's location does not matter.
You just need to remember where you've put a specific virtual environment in order to activate it.

Because each project should have its own virtual environment, it is customary during development to put the respective virtual environment into the project root in a directory with a generic name like ``venv``, which is also added to ``.gitignore`` to prevent accidentally committing it to the repository.
(The blueprint's ``.gitignore`` already contains some of the most-used names.)
This layout is used both in this document and in the blueprint (e.g., by the ``make venv*`` commands defined in ``Makefile``).

However, a virtual environment can quickly grow in size to dozens or even hundreds of megabytes.
If you're working on a system with a small home quote (like at CSCS) and like to keep your code in your home, you may want to put your virtual environments elsewhere (e.g., on ``${SCRATCH}``).
Nothing prevents you from doing this, choose whatever layout works best for you.


Do I have to activate a virtual environment to use the applications installed in it?
------------------------------------------------------------------------------------

No, you do not!
You only need to explicitly use the executable in the virtual environment, then it will use the packages installed in there.

Say, to use the (fictional) command ``great-tool`` you've installed the package ``great_tool`` (and its dependencies) in a virtual environment in ``~/.local/venvs/great_tool``.
Then you can use it by calling it explicitly::

    ~/.local/venvs/great_tool/bin/great-tool

To make this command globally available, you can just symlink it to a directory that is in your ``${PATH}``, for example::

    cd ~/.local/bin
    ln -s ../venvs/great_tool/bin/great-tool

Note that installing an application into a virtual environments and making its commands globally available can be done in one command with ``pipx``, as will be described later.


Are there alternatives to ``venv+pip``?
---------------------------------------

Indeed, there are quite a few other approaches, but the ``venv`` module (part of the Python 3 standard library) in combination with ``pip`` is the standard approach and available on any Python 3 installation.

A far-from-exhaustive list of alternatives includes:

*   ``virtualenv``: This package is essentially identical to ``venv``, but has been around longer (already for Python 2) and is a third-party module that is not shipped with the standard library.
    Many manuals thus refer to ``virtualenv`` and ``virtualenv+pip`` as the standard approach; to follow them, just replace ``virtualenv`` or ``python -m virtualenv`` by ``python -m venv``.

*   ``virtualenvwrapper``: It's all in the name: this third-party tool is a wrapper of ``virtualenv`` providing an alternative interface.
    Virtual environments are stored in a central location which the user does not need to remember, and can be created, activated, and removed from anywhere in the system by their name.
    Packages within a virtual environment are still managed with ``pip``.

*   ``pipenv``: This third-party tool aims to combine and abstract the creation of virtual environments and the installation of packages therein.
    It uses ``virtualenv+pip`` under the hood, thus essentially constituting a wrapper for the standard solution.
    It is often (somewhat erroneously) referred to as the officially recommended tool (and may in time develop into that), as well as a convenient and beginner-friendly solution.

*   ``conda``: Often used in science, ``Anaconda``/``Miniconda`` is another solution that handles both virtual environments as well as the packages therein, similar to ``pipenv``.
    In contrast to all aforementioned tools, however, it does not restrict itself to Python packages, but also manages non-Python dependencies like C-libraries, and environments contain their own Python installation -- conda environments are thus even more isolated from the system environment than conventional virtual environments.
    However, it relies on its own package repositories, which can occasionally cause issues like outdated packages.

In addition, there are other related tools that often come up in the context of virtual environments:

*   ``pyenv``: A tool to install multiple versions of Python (no root required) and switch between them.
    It even allows one to use a certain Python version inside a certain directory (and its subdirectories), which for examples makes it possible to develop different projects with different Python versions.

*   ``pipx``: A tool to install Python applications with a single command.
    It installs each application package and all its dependencies into a separate virtual environment.
    More details and examples will follow below.
