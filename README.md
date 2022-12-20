# Getting started
[![docs](https://github.com/MeteoSwiss-APN/mch-python-blueprint/actions/workflows/blueprint-docs.yaml/badge.svg)](https://meteoswiss-apn.github.io/mch-python-blueprint/)
[![Pre-Commit](https://github.com/MeteoSwiss-APN/mch-python-blueprint/actions/workflows/blueprint-pre-commit.yml/badge.svg)](https://github.com/MeteoSwiss-APN/mch-python-blueprint/actions/workflows/blueprint-pre-commit.yml)

Template for a simple Python project for [`copier`](https://github.com/copier-org/copier). This readme will guide you through setting up your package (if you are new to packaging in Python, check the Python Packaging User Guide (https://packaging.python.org/en/latest/) with the provided template. More information on the tools, intended workflow, etc. can be found on Github pages of this repository (https://meteoswiss-apn.github.io/mch-python-blueprint/).

## Preparation

Ensure that your active Python version is 3.7 or higher. The recommended way to manage Python versions is with `Conda` (https://docs.conda.io/en/latest/). On CSCS machines it is recommended to install the leaner `Miniconda` (https://docs.conda.io/en/latest/miniconda.html), which offers enough functionality for most of our use cases. If you don't want to do this step manually, you can also use the script that is provided in the copier template `tmpl/setup_miniconda.sh`.

## Install Copier

First you have to install copier and its requirements. Ideally you do it in a conda environment:

```bash
conda create --name blueprint
conda activate blueprint
conda install pip
pip install copier
```

## Create your Python package from our template

You can now produce your Python package from a copier template by running

```bash
conda activate blueprint
copier git@github.com:MeteoSwiss-APN/mch-python-blueprint.git </path/to/destination>
```

If you need to generate your project from a specific commit hash or branch of the blueprint you can run with --vcs-ref

```bash
conda activate blueprint
copier --vcs-ref <branch> git@github.com:MeteoSwiss-APN/mch-python-blueprint.git </path/to/destination>
```

**Warning:**
Copier does not work with older git versions (e.g. the standard one on Tsa). Not having an up-to-date git version will lead to cryptic error messages. On CSCS machines, you can get an up-to-date git version with `module load git`.

## Set up your project on GitHub

**Warning:** Before setting up your project, think carefully, whether you want to have your repository public or private and whether the provided licence suits your need. The package comes with an MIT license, therefore do not commit proprietary code before carefully reviewing or changing the license. Once you have made up your mind, go to the repository created by copier, i.e., your project repository and initialize git with the following sequence of commands:

```bash
cd </path/to/your/package>
git init
git add .
git commit -m “initial commit”
```
Create the repository on MeteoSwiss-APN github. **Attention**: the name here must correspond to the information given to copier. Then follow the steps on GitHub under the headline “…or push an existing repository from the command line to connect your repository to the remote on GitHub. A .gitignore template is not needed as there is one provided in the blueprint. **Attention**: It's recommended to use the ssh URL and not https as recommended in the given instructions. The URL has the form git(at)github.com:MeteoSwiss-APN/your_fancy_package.

## Start developing your package

For first steps with your project, how to install it, setup and run the development tools, see the documentation of an example project, https://meteoswiss-apn.github.io/mch-python-blueprint/example_project/README.html. Find out more about provided development tools and setting up CI/CD pipelines on https://meteoswiss-apn.github.io/mch-python-blueprint/ .

## Update template

To update your package to the latest version of the underlying meta template, run:

```bash
copier -a .copier-answers.yml -f update
```

With `-f`, conflicting files are overwritten (which doesn't mean that in the end, the files are changed as those conflicts can be purely internal). Note that `-a` can be omitted if the answers file has a standard name (`.copier-answers.y[a]ml`).

### Rename template parameter

Renaming a parameter in `copier.yaml` is possible, but updating a project requires two steps because copier doesn't register the renaming as such.

#### The wrong way in one step

Copier registers the renaming of a parameter as independent removal of an old and addition of a new parameter, whereby any non-default parameter value is lost.

Original template:

```yaml
# cat copier.yaml
name:
  help: "Your name."
  default: "Monty Python"
  # -> Foobert Barson
```

```python
# tmpl/src/__init__.py.j2
__author__ = "{{ name }}"
```

Original project:

```python
# src/__init__.py
__author__ = "Foobert Barson"
```

Adapted template:

```yaml
# copier.yaml
author_name:
  help: "Your name."
  default: "Monty Python"
```

```python
# tmpl/src/{{ project_package }}/__init__.py.j2
__author__ = "{{ author_name }}"
```

Project after `copier -f update`:

```yaml
# .copier-answers.yaml
author_name: Monty Python
```

```python
# src/foobar/__init__.py
__author__ = "Monty Python"
```

The user-provided name "Foobert Barson" has been lost during the update and replaced by the default name "Monty Python".

#### The right way in two steps

We start with the same original template and project, but this time, we adapt `copier.yaml` in two steps.

First, we add the renamed parameter but retain the original one, using it's value as the default for the former:

```yaml
# copier.yaml
name: # TODO remove
  default: "Monty Python."

author_name:
  help: "Your name."
  # default: "Monty Python"
  default: "{{ name }}"
```

In all other files, we can now already use the renamed parameter:

```python
# tmpl/src/{{ project_package }}/__init__.py.j2
__author__ = "{{ author_name }}"
```

This code is now pushed to an intermediate branch `rename-params`. Then we remove the old parameter from `copier.yaml` and push that to the main branch:

```yaml
# copier.yaml
author_name:
  help: "Your name."
  default: "Monty Python"
```

Update the project with `copier --vcs-ref=rename-params -f update`:

```yaml
# .copier-answers.yaml
name: Foobert Barson
author_name: Foobert Barson
```

```python
# src/foobar/__init__.py
__author__ = "Foobert Barson"
```

Commit the changes, then update again with `copier -f update`:

```yaml
# .copier-answers.yaml
author_name = "Foobert Barson"
```

The parameter has successfully been renamed while retaining it's value. Commit again (use `--amend` if you want the whole update in a single commit). Delete the intermediate branch `rename-params`.
