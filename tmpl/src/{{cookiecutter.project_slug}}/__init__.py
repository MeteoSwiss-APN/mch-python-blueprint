"""Top-level package for {{ cookiecutter.project_name }}."""
# Standard library
import importlib.metadata

__author__ = "{{ cookiecutter.full_name }}"
__email__ = "{{ cookiecutter.email }}"
__version__ = importlib.metadata.version(__package__)

del importlib
