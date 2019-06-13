============================
Virtual Environments at CSCS
============================

Configuration
-------------

Add the following lines to your `.bashrc`::

  # Location where pipenv stores its virtual environments
  export PIPENV_CACHE_DIR=/scratch/<username>/.pipenvs
  
  # Use the following mirror to install pip packages when using pipenv
  export PIPENV_PYPI_MIRROR=???
  
  # Location where virtualenvwrapper stores its virtual environments
  export WORKON_HOME=/scratch/<username>/.virtualenvs
  
Add the file ``.pypirc`` to your home directory with the following content::

  # Pip donwnload configuration
  
  [global]
  # index = https://nexus.meteoswiss.ch/repository/python-all/pypi
  # index-url = https://nexus.meteoswiss.ch/repository/python-all/simple
  
  # List packages in column format
  [list]
  format = columns
  
Using Virtual Environments
--------------------------

Scripts and programs to manage virtual environments are provided by the
Python module. To load it, execute the following command::

  $ module load python[/<version>]
  
To manage virtual environments, we recommand to use the script ``pipenv`` 
(for further documentation see `pipenv`_). Other possiblities to manage virtual
environments are

* directly use the script ``virtualenv`` (see `virtualenv`_), or
* the scripts provided by virtualenvwrapper (see `virtualenvwrapper`_)

Note that you need to ``source /usr/local/bin/virtualenvwrapper.sh`` 
before you can use the scripts of virtualenvwrapper.

In the following, we introduce the most important command using `pipenv`::

    # Create a virutal env for current project with the specified. Make sure to enter the root
    # directory of the project before executing the command! Note that this
    # will install all packages in ``requirements.txt`` (if there is one).
    $ pipenv 
    
    # Like ``pipenv``, but with a specific Python version.
    $ pipenv --python 3.7
    
    # Display the path to the virtual environment associated with the project.
    # Complains if no virtual environment has been created for the project yet,
    # so use this to check whether a virtual environment already exists or not.
    $ pipenv --venv
    
    # Activate the virtual envorinment associated with the current project 
    # (executed in the root directory of the project). If no environment
    # associated with the project exists, a new one is created on the fly.
    # Starts a new shell with the activated virtual environment.
    # (To check whether there is an environemnt, run ``pipenv --venv``.)
    $ pipenv shell
    
    # Like ``pipenv shell``, but with a specific Python version.
    $ pipenv shell --python 3.7
    
    # Leave the environement. Caution: This does NOT leave the shell entered with
    # ``pipenv shell``! You most likely want to leave with ``exit`` (see below).
    $ deactivate
    
    # Leave the environment AND the shell entered with ``pipenv shell``. This is
    # most likely how you want to leave, rather than with ``deactivate`` (see above).
    $ exit
    
    # Install a new package used by the library or the application.
    $ pipenv install <package>
    
    # Install a new package used for development (such as a debugger).
    # Development packages are those the application/library can run without.
    $ pipenv install <dev-package> --dev
    
    # Install all packages specified in ``Pipfile``.
    $ pipenv install
    
    # Install all packages specified in ``Pipfile``, including development packages.
    $ pipenv install --dev
    
    # Install all packages specified in ``requirements.txt``.
    $ pipenv install -r requirements.txt
    
    # Install all packages specified in ``requirements_dev.txt``, including development
    # packages.
    $ pipenv install -r requirements_dev.txt --dev
    
    # Rewrite ``requirements.txt`` and ``requirements_dev.txt`` (needed to sync the 
    # content of ``Pipfile`` with ``requirements.txt`` and ``requirements_dev.txt``).
    $ pipenv lock -r > requirements.txt
    $ pipenv lock -r -d > requirements_dev.txt
    
    # Pinpoint the versions of the installed packages to ``Pipenv.lock``, in order to
    # rebuild a reproducible virtual environment on another machine or for another user.
    $ pipenv lock
    
    # Rebuild a reproducible virtual environment (same package versions) from ``Pipenv.lock``,
    # as pinned down with ``pipenv lock`` on an other machine or by another user.
    $ pipenv install --ignore-pipfile
    
    # Check for security updates.
    $ pipenv check
    
    # Remove the virtual environment associated with the package from $PIPENV_CACHE_DIR.
    # Caution: If you run this from inside a pipenv environment/shell, the environment
    # will be removed, but you will remain inside the environment/shell! Make sure to
    # leave with ``exit`` before (or after) removing the activated environment.
    $ pipenv --rm

.. _`pipenv`: https://realpython.com/pipenv-guide/
.. _`virtualenv`: https://virtualenv.pypa.io/en/stable/userguide/
.. _`virtualenvwrapper`: https://virtualenvwrapper.readthedocs.io/en/latest/index.html
