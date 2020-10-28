"""Set up the project."""
# Third-party
from setuptools import find_packages
from setuptools import setup


def read_file(path):
    with open(path, "r") as f:
        return "\n".join([l.strip() for l in f.readlines()])


description_files = ["README.rst", "HISTORY.rst"]

metadata = {
    "name": "{{ cookiecutter.project_slug }}",
    "version": "{{ cookiecutter.version }}",
    "description": "{{ cookiecutter.project_short_description }}",
    "long_description": "\n\n".join([read_file(f) for f in description_files]),
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

# Unpinned runtime dependencies
unpinned_dependencies = [
{%- if cookiecutter.sample_code != 'no' %}
    "click >= 6.0",
{%- endif %}
]

# If available, use pinned dependencies instead
try:
    with open("requirements.txt") as fi:
        dependencies = [line.strip() for line in fi.readlines()]
except Exception:
    dependencies = unpinned_dependencies

scripts = [
    "{{ cookiecutter.project_slug }}={{ cookiecutter.project_slug }}.cli:main",
]

setup(
    python_requires=python,
    install_requires=dependencies,
    entry_points={"console_scripts": scripts},
    packages=find_packages("src"),
    package_dir={"": "src"},
    include_package_data=True,
    zip_save=False,
    **metadata,
)
