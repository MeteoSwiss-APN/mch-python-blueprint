
*************
Documentation
*************

What is already here?
---------------------

Additionally to a initial README.rst file, the blueprint will automatically generate a folder with the following content

.. code:: shell

    docs/
    conf.py
    index.rst
    installation.rst
    make.bat
    Makefile

This folder is set up to build static html pages with sphinx. The deployment to GitHub-Pages should happen automatically
after you enable the feature in the settings of you repository following the example given in the following figure:

.. image:: static/github_pages_setiings.png

Note that this is an optional feature. If you repository is private, you should probably not push the documentation to
Github-Pages. Likewise, if you work on a small project, you might not necessarily need this feature. If you do not need
the feature, you can link individual files directly to the readme in the root directory. In this case remove sphinx from
your dev-requirements.yml file and remove the GH action (.github/workflows/documentation).