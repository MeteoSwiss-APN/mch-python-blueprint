#!/bin/bash
# Run mypy
# src: https://jaredkhan.com/blog/mypy-pre-commit

set -o errexit

VERBOSE=${VERBOSE:-false}

cd "$(dirname "${0}")"

paths=(
    src/{{ cookiecutter.project_slug }}
    tests/test_{{ cookiecutter.project_slug }}
    *.py
)
for path in "${paths[@]}"; do
    ${VERBOSE} && echo "mypy \"${path}\""
    mypy "${path}" || exit
done
