# Getting started
[![docs](https://github.com/MeteoSwiss-APN/mch-python-blueprint/actions/workflows/blueprint-docs.yaml/badge.svg)](https://meteoswiss-apn.github.io/mch-python-blueprint/)
[![Pre-Commit](https://github.com/MeteoSwiss-APN/mch-python-blueprint/actions/workflows/blueprint-pre-commit.yml/badge.svg)](https://github.com/MeteoSwiss-APN/mch-python-blueprint/actions/workflows/blueprint-pre-commit.yml)


Template for a simple Python project for [`copier`](https://github.com/copier-org/copier). This readme will guide you through setting up your package (if you are new to packaging in Python, check the Python Packaging User Guide (https://packaging.python.org/en/latest/) with the provided template.
More information on the tools, intended workflow, etc. can be found on
GH pages of this repository (https://meteoswiss-apn.github.io/mch-python-blueprint/).

## Preparation

Ensure that your active Python version is 3.7 or higher.
The recommended way to manage Python versions is with `Conda`
(https://docs.conda.io/en/latest/).
On CSCS machines it is recommended to install the leaner `Miniconda`
(https://docs.conda.io/en/latest/miniconda.html),
which offers enough functionality for most of our use cases.
If you don't want to do this step manually, you may use the script that is
provided in the copier template `tmpl/tools/setup_miniconda.sh`.
The default installation path of this script is the current working directory,
you might want to change that with the `-p` option to a common location for all
environments, like e.g. `$SCRATCH`. If you want the script to immediately
initialize conda (executing `conda init` and thereby adding a few commands at the
end of your `.bashrc`) after installation, add the `-u` option:

```bash
tmpl/tools/setup_miniconda.sh -p $SCRATCH -u
```

In case you ever need to uninstall miniconda, do the following:

```bash
conda init --reverse --all
rm -rf $SCRATCH/miniconda
```

## Install Copier

First you have to install copier and its requirements. Ideally you do this in a conda environment:
```bash
conda create --name blueprint
conda activate blueprint
conda install "copier<8.0"
```

## Create your Python package from our template
You can now produce your Python package from a copier template by running
```
conda activate blueprint
copier git@github.com:MeteoSwiss-APN/mch-python-blueprint.git </path/to/destination>
```
If you need to generate your project from a specific commit hash or branch of the blueprint you can run with --vcs-ref

```
conda activate blueprint
copier --vcs-ref <branch> git@github.com:MeteoSwiss-APN/mch-python-blueprint.git </path/to/destination>
```

**Warning:**
Copier does not work with older git versions (e.g. the standard one on Tsa). Not having an up-to-date git version will lead to cryptic error messages. On CSCS machines, you can get an up-to-date git version with `module load git`.


## Set up your project on GitHub

**Warning:** Before setting up your project, think carefully, whether you want to have your repository public or private and whether the provided licence
suits your need. The package comes with an MIT license, therefore do not commit proprietary code before carefully reviewing or changing the license.
Once you have made up your mind, go to the repository created by copier, i.e. your project
repository and initialize git with the following sequence of commands:

```bash
    cd </path/to/your/package>
    git init
    git add .
    git commit -m “initial commit”
```
Create the repository on MeteoSwiss-APN github. **Attention**: the name here must correspond to the information given to copier. Then follow the steps on
GitHub under the headline “…or push an existing repository from the command line to connect your repository to the remote on GitHub. A .gitignore template
is not needed as there is one provided in the blueprint. **Attention**: It's recommended to use the ssh URL and not https as recommended in the given
instructions. The URL has the form git(at)github.com:MeteoSwiss-APN/your_fancy_package.
**Disclaimer** It is assumed you know how to use git, in particular how to implement features on a branch and merge them to the main branch using pull requests.
Avoid working directly on the main branch after the initial commit (or the first few commits if you start alone and from scratch).

## Start developing your package

For first steps with your project, how to install it, setup and run the development tools, see the documentation of an example project, https://meteoswiss-apn.github.io/mch-python-blueprint/example_project/README.html.
Find
out more about provided development tools and setting up CI/CD pipelines on https://meteoswiss-apn.github.io/mch-python-blueprint/ .

## Update template

To update your package to the latest version of the underlying meta template, run:

```bash
copier -a .copier-answers.yml -f update
```

With `-f`, conflicting files are overwritten (which doesn't mean that in the end, the files are changed as those conflicts can be purely internal).
