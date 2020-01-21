
##########
Deployment
##########

How to install your Python package for deployment using `Pipx`_ or by hand.

We will use the (hypothetical) package ``great_tool`` as an example, which provides the command ``great-tool`` and is hosted on the `APN github`_.

Note that in the examples below, we assume that you have set the environment variables ``${PIPX_HOME}`` and ``${PIPX_BIN_DIR}`` in your ``.bashrc``.
At CSCS, we recommend ``PIPX_HOME=/scratch/<user>/<machine>/local/pipx`` and ``${PIPX_BIN_DIR}=/scratch/<user>/<machine>/local/bin/`` (whereby ``<machine>`` is only necessary if scratch is shared between non-identical systems).
To use the installed commands, add ``${PIPX_BIN_DIR}`` to your ``${PATH}``.

.. _`APN github`: https://github.com/MeteoSwiss-APN
.. _`Pipx`: https://github.com/pipxproject/pipx


`TL;DR`_
========

.. _`TL;DR`: https://en.wikipedia.org/wiki/Wikipedia:Too_long;_didn%27t_read

In gereal, the simplest way of installing a package is with `Pipx`_.
To install the package ``great_tool`` to the virtual environment ``${PIPX_HOME}/venvs/great_tool``::

    pipx install git+https://github.com/MeteoSwiss-APN/great_tool.git

In cases in which it is not possible to use `Pipx`_ (at CSCS for instance if you use `Cartopy`_ or `Shapely`_), install ``great_tool`` manually::

    # Prepare directory for virtual environments
    cd ${PIPX_HOME}/..  # e.g., /scratch/<user>/<machine>/local
    mkdir -p pkgs/venvs
    cd pkgs/venvs

    # Install package with dependencies to a virtual environment
    python -m virtualenv great_tool
    source great_tool/bin/activate
    pip install <installation dependencies>  # e.g., numpy and cython to build cartopy
    pip install git+https://github.com/MeteoSwiss-APN/great_tool.git

    # Make the installed command globally available
    cd ${PIPX_BIN_DIR}
    ln -s $(which great-tool)
    deactivate

.. _`Cartopy`: https://github.com/SciTools/cartopy
.. _`Pipx`: https://github.com/pipxproject/pipx
.. _`Shapely`: https://github.com/Toblerity/Shapely


With Pipx
=========

Setup
-----

Note: If ``pipx`` is not installed (or you prefer your own installation for whatever reason), you can do so yourself following the instructions on `Installing Python Packages at CSCS`_.

.. _`Installing Python Packages at CSCS`: install_packages_cscs.rst

When installing a package, pipx uses two locations defined by the environment variables ``${PIPX_HOME}`` (where packages go) and ``${PIPX_BIN_DIR}`` (where commands are linked).


PIPX_HOME
^^^^^^^^^

Packages and their dependencies are installed into virtual environments located in ``${PIPX_HOME}/venvs/`` (default: ``PIPX_HOME=${HOME}/.local/pipx``).

For a given package, depending on its dependencies, this virtual environment may be several hundred megabytes in size.
Therefore, on systems with a small ``${HOME}`` quota like at CSCS, ``${PIPX_HOME}`` should be changed to a location such as ``${SCRATCH}`` or ``${APPS}`` (see example below).

On systems where ``${HOME}`` is shared between different machines -- again, like at CSCS -- there is an additional reason to move ``${PIPX_HOME}``: Non-Python dependencies (e.g., the C-dependencies ``geos`` and ``proj`` of ``cartopy``) may differ in version between machines, and those are outside the control by regular virtual environments.

(This is analogous to regular local Python packages, as described in `Installing Python Packages at CSCS`_.)

.. _`Installing Python Packages at CSCS`: install_packages_cscs.rst


PIPX_BIN_DIR
^^^^^^^^^^^^

Executables are linked in ``${PIPX_BIN_DIR}/`` (default: ``PIPX_BIN_DIR=${HOME}/.local/bin``).

While the size of these symbolic links is no concern, if ``PIPX_HOME`` is moved outside ``${HOME}``, so should ``${PIPX_HOME}`` be because the links point to the code in ``${PIPX_HOME}/venvs/``.
It is therefore not practical to share one ``${PIPX_BIN_DIR}`` between multiple ``${PIPX_HOME}``!


CSCS Example Setup
^^^^^^^^^^^^^^^^^^


TODO
----

Because the package and its dependencies are installed into a designated `virtual environment`_ (in ``${PIPX_BIN_DIR}/venvs``), it is isolated from other installed packages, which prevents any dependency conflicts.
But you don't need to care about these environments (let alone activate them) to use ``great-tool``; it will automatically run in its virtual environment.

.. _`virtual environment`: https://realpython.com/python-virtual-environments-a-primer/


By Hand
=======

TODO


