
==================================
Installing Python Packages at CSCS
==================================

How to locally install your own Python packages at CSCS.

We will use the package `ipython`_ as an example.

.. _`ipython`: https://github.com/ipython/ipython


When Not Virtual Environments?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Note that in general, you should only install Python packages inside a virtual environment (see `Working in Virtual Environments`_), especially if you need to install a package as a dependency to a tool you're working on.
In some cases, though, it may make sense to install a package user-wide:

* Tools that themselves create virtual environments, e.g., `pipenv`_, `virtualenvwrapper`_, or `pipx`_ (see `Deployment With Pipx`_).
* Tools that you use all the time on the command line, e.g., `ipython`_.

But, again: These are the exceptions, not the rule!

.. _`Deployment With Pipx`: deployment_pipx.rst
.. _`Working in Virtual Environments`: virtual_envs.rst

.. _`ipython`: https://github.com/ipython/ipython
.. _`pipenv`: https://github.com/pypa/pipenv
.. _`pipx`: https://github.com/pipxproject/pipx
.. _`virtualenvwrapper`: https://virtualenvwrapper.readthedocs.io/en/latest/


`TL;DR`_
--------

.. _`TL;DR`: https://en.wikipedia.org/wiki/Wikipedia:Too_long;_didn%27t_read

