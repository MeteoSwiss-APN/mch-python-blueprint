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

    # Create a virutal env for project with the specified Python version.
    # Make sure to enter the root directory of the project before executing
    # the command! Note that this installs all packages in ``requirements.txt``
    # (if there is one).
    $ pipenv                # default v*.* (or might just displays help page)
    $ pipenv --three        # default v3.*
    $ pipenv --python 3.7   # specific v3.7
    
    # Display the path to the virtual environment associated with the project.
    # Complains if no virtual environment has been created for the project yet,
    # so use this to check whether a virtual environment already exists or not.
    $ pipenv --venv
    
    # Activate the virtual envorinment associated with the current project 
    # (executed in the root directory of the project). If no environment
    # associated with the project exists, a new one is created (see below).
    $ pipenv shell
    
    # If the current project is has no virtual environment associated with it
    # (check with ``pipenv --venv``; see above), a new one is created. Note
    # that if a Python version is specified (e.g., ``--three``, ``--python 3.7``),
    # then a new environment is created in any case -- if there has already been
    # one, it is removed without asking. It is therefore advisable not to create
    # a new virtual environment with ``pipenv shell``, but to check whether one
    # already exists (``pipenv --venv``; see above), and if not, to create one
    # with ``pipenv --python 3.7`` or the like (see above).
    $ pipenv shell                # default v*.*
    $ pipenv shell --three        # default v3.*
    $ pipenv shell --python 3.7   # specific v3.7
    
    # Show the currently active virtual environment. If no virtual environment is
    # active, this environment variable is undefined. Note that by default, the
    # name of the active virtual environment is displayed ahead of the bash prompt
    # (e.g., ``(my-project)``) -- even if ``$PS1`` is modified in ``.bashrc``.
    $ echo $VIRTUAL_ENV
    
    # Leave environement. Caution: This does NOT leave the shell entered with
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
    
    # Install all non-development packages specified in ``Pipfile``. Creates a
    # ``Pipfile.lock``, overwriting an existing one. If no ``Pipfile`` exists, one is
    # created. Note that an existing ``Pipfile.lock`` is ignored (and overwritten)
    # whether ``Pipfile`` already exists or not (see below how to install from
    # ``Pipfile.lock``). If there is no ``Pipile``, but a ``requirements.txt``, the
    # packages listed in the latter are installed. (Caution: if ``requirements.txt``
    # contains pinned versions, so will ``Pipfile``, which should be avoided!)
    $ pipenv install
    
    # Install all packages specified in ``Pipfile``, including development packages.
    $ pipenv install --dev
    
    # Install all packages specified in ``requirements.txt``. Caution: If package
    # versions are pinned in ``requirements.txt``, they will also be pinned in ``Pipfile``,
    # which they should not be (that what ``Pipfile.lock`` is for)!
    $ pipenv install -r requirements.txt
    
    # Install all packages specified in ``requirements_dev.txt``, including development
    # packages. (Same caution as above regarding pinned versions is advised.)
    $ pipenv install -r requirements_dev.txt --dev
    
    # Rewrite ``requirements.txt`` and ``requirements_dev.txt`` (needed to sync the 
    # content of ``Pipfile`` with ``requirements.txt`` and ``requirements_dev.txt``).
    # (Note that ``requirements*.txt`` are only necessary for compatibility with other
    # packaging/release tools or workflows, but not needed for a purely pipenv-based
    # workflow, so best don't create them in the first place during development.)
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

**Hack: Activate virtual environment without entering a subshell**

Word of caution: Ignore this unless you really, really don't want to run in a subshell and can live with any unintended consequences!
Pipenv is not supposed to used this way, so use this at your own peril.

Usually, if you work in a pipenv virtual environment, you will activate it in a subshell using `pipenv shell`.
(While one can also run commands without activating the environment by prepending them with `pipenv run`, this only works inside the project directory; outside you don't get around activating the environment, unless you call your application by its full path.)
The subshell provides isolation, i.e., does not pollute the original shell in any way (environment variables etc.); if the environment were run in the same shell, all kind of cleanup would be necessary when deactivating the environment, which is why the authors of pipenv decided on using a subshell.
However, the subshell has also some effects that are drawbacks to some users, notably that on exiting it, the current directory is reset to that before entering the shell, and the bash history is lost (or at least messed up).

For some, this is reason enough to want to forego the subshell.
Luckily, this is relatively easy, as the virtual environment that is created under the hood by pipenv can be activated the usual virtualenv-way by sourcing the `<venv>/bin/activate` script. The path to the virtual environment, in turn, can be optained from inside the project directory with `pipenv --venv`.

So you can forego the subshell like this:

    $ pipenv-activate() { source "$(pipenv --venv)/bin/activate"; }  # put in .bashrc
    $ cd <project-directory>
    $ pipenv-activate
    (<project-name>) $ <do stuff>
    
Or, if you want to activate the environment from outside the project directory:

    $ pipenv-activate() { [ $# -eq 1 ] && source "$(cd $1; pipenv --venv)/bin/activate"; } # put in bashrc
    $ pipenv-activate <project-directory>
    $ (<project-name>) $ <do stuff>
    
(Note the check `[ $# -eq 1 ]` to ensure one argument has been passed.
Without this, if you passed no argument, it would try to `source /bin/activate`.)
    
To leave the virtual environment, type `deactivate`.

A slightly more sophisticated script that does essentially the same as the above one-liners (put it in your $PATH):

    #!/bin/bash
    #
    # pipenv-activate -- Activate a pipenv environment without spawning a new shell
    #
    
    # Avoid any non-local variables that would be sourced
    global() {
    
    local script="$(basename "${BASH_SOURCE}")"
    local usage="usage: source ${SCRIPT} [path]"
    
    # Make sure the script is sourced, not executed
    [ "${BASH_SOURCE}" == "${0}" ] && {
        echo "error: ${script} must be sourced!" >&2
        return 1
    }
    
    main()
    {
        # Get project directory (optional argument)
        local proj_path="${1}"
        [ "${1}" == '' ] && proj_path='.'
    
        # Check that project path directory exists
        [ -d "${proj_path}" ] || {
            echo "error: project path not found: ${proj_path}" >&2
            return 1
        }
    
        # Path to virtual environment
        local venv_path="$(cd "${proj_path}"; pipenv --venv 2>/dev/null)" || {
            echo "error: you must enter a project directory!" >&2
            return 1
        }
    
        # Path to activate script
        local activate_path="${venv_path}/bin/activate"
        [ ! -f "${activate_path}" ] && {
            echo "error: activate script not found: ${activate_path}" >&2
            return 1
        }
    
        # Activate environment
        echo 'source "'"${activate_path}"'"'
        \source "${activate_path}" || {
            echo "error: cannot source activate script: ${activate_path}" >&2
            return 1
        }
    }
    main "${@}" || { echo "${USAGE}" >&2; return $?; }
    
    }; global "${@}"


.. _`pipenv`: https://realpython.com/pipenv-guide/
.. _`virtualenv`: https://virtualenv.pypa.io/en/stable/userguide/
.. _`virtualenvwrapper`: https://virtualenvwrapper.readthedocs.io/en/latest/index.html
