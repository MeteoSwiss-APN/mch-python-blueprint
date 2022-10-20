# python-package

Template for a simple Python project for [`copier`](https://github.com/copier-org/copier).

## Preparation
Ensure that your active Python version is 3.7 or higher.
The recommended way to manage Python versions is with [`Conda`] (https://docs.conda.io/en/latest/). On CSCS machines it is recommended to install the leaner [`Miniconda`] (https://docs.conda.io/en/latest/miniconda.html), which offers enough functionality for most of our use cases.

## Install Copier

First you have to install copier and its requirements. Ideally you can do that in a conda environment.
```bash
conda env create --name blueprint --file requirements/requirements.yml
```
**Warning**
Copier does not work with older git versions (e.g. the standard one on Tsa). Not having an up-to-date git version will lead to cryptic error messages. On CSCS machines, you can get an up-to-date git version with `module load git`.

## Create your Python package from our template
You can now produce your Python package from a copier template by running
```
conda activate blueprint
copier --vcs-ref copier3_refine git@github.com:MeteoSwiss-APN/mch-python-blueprint.git </path/to/destination>
```
The flag `--vcs-ref copier3_refine` makes sure the correct branch of the blueprint is checked out. This will be
changed, once we have a release.

## Set up your project on GitHub

Create the repository on MeteoSwiss-APN github. **Attention**: the name here must correspond to the information given to copier.
A .gitignore template is not needed as there is one provided in the blueprint. Go to the repository created by copier, i.e. your project repository
and initialize git with the following sequence of commands:

.. code:: bash

    git init
    git add .
    git commit -m “initial commit”

Go back to the GitHub page of your project. Then follow the steps on GitHub under the headline “…or push an existing repository from the command line“
to connect your repository to the remote on GitHub. **Attention**: It's recommended to use the ssh URL and not https as recommended in the given
instructions. The URL has the form git(at)github.com:MeteoSwiss-APN/your_fancy_package. To install your package, follow the instructions given in
`docs/installation.rst` in your project repository.
## Update template

To update to the underlying meta template, run:

```bash
copier -a .copier-answers.meta-python-project.yml -f update
```

With `-f`, conflicting files are overwritten (which doesn't mean that in the end, the files are changed as those conflicts can be purely internal).
