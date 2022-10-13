# python-package

Template for a simple Python project for [`copier`](https://github.com/copier-org/copier).

## Quickstart
First you have to install copier and its requirements. Ideally you can do that in a conda environment.
```bash
conda env create --name blueprint --file requirements/requirements.yml
```
Then you can produce your Python package from a copier template by running
```
conda run --name blueprint copier -f copy . .
```

## Update template

To update to the underlying meta template, run:

```bash
copier -a .copier-answers.meta-python-project.yml -f update
```

With `-f`, conflicting files are overwritten (which doesn't mean that in the end, the files are changed as those conflicts can be purely internal).
