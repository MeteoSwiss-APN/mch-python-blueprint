"""Set up the project."""
# Standard library
from typing import List
from typing import Sequence

# Third-party
from setuptools import find_packages
from setuptools import setup


def read_present_files(paths: Sequence[str]) -> str:
    """Read the content of those files that are present."""
    contents: List[str] = []
    for path in paths:
        try:
            with open(path, "r", encoding="utf8") as f:
                contents += ["\n".join(map(str.strip, f.readlines()))]
        except FileNotFoundError:
            continue
    return "\n\n".join(contents)


description_files = [
    "README",
    "README.rst",
    "README.md",
    "HISTORY",
    "HISTORY.rst",
    "HISTORY.md",
]

metadata = {
    "name": "{{ cookiecutter.project_slug }}",
    "version": "{{ cookiecutter.version }}",
    "description": "{{ cookiecutter.project_short_description }}",
    "long_description": read_present_files(description_files),
    "author": "{{ cookiecutter.full_name.replace('\"', '\\\"') }}",
    "author_email": "{{ cookiecutter.email }}",
    "url": "https://github.com/{{ cookiecutter.github_username }}/{{ cookiecutter.project_slug }}",
    "keywords": "{{ cookiecutter.project_slug }}",
    "classifiers": [
        "Development Status :: 2 - Pre-Alpha",
        "Intended Audience :: Developers",
        "Natural Language :: English",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
    ],
}

python = ">= 3.7"

scripts = [
    "{{ cookiecutter.project_slug }}={{ cookiecutter.project_slug }}.cli:main",
]

setup(
    python_requires=python,
    entry_points={"console_scripts": scripts},
    packages=find_packages("src"),
    package_dir={"": "src"},
    include_package_data=True,
    zip_save=False,
    **metadata,
)
