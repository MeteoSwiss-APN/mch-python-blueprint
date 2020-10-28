"""Test module ``{{ cookiecutter.project_slug }}/utils.py``."""
# Standard library
import logging

# Third-party
import pytest
from click.testing import CliRunner

# First-party
from {{ cookiecutter.project_slug }} import utils


def test_count_to_log_level():
    assert utils.count_to_log_level(0) == logging.ERROR
    assert utils.count_to_log_level(1) == logging.WARNING
    assert utils.count_to_log_level(2) == logging.INFO
    assert utils.count_to_log_level(3) == logging.DEBUG
