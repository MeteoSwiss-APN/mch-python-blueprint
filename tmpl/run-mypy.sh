#!/bin/bash
#
# Run mypy separately over components of the project (source, tests)
#
# Call mypy via this script in pre-commit
# - to always check all files (not just those that changed),
# - to check different components of the project separately (in case of multiple packages), and
# - to give mypy access to all dependencies (by running it locally rather than in isolation).
#
# src: https://jaredkhan.com/blog/mypy-pre-commit

set -o errexit

VERBOSE=${VERBOSE:-false}

cd "$(dirname "${0}")"

paths=(
    src/{{ project_slug }}
    tests/test_{{ project_slug }}
)
for path in "${paths[@]}"; do
    ${VERBOSE} && echo "mypy \"${path}\""
    mypy "${path}" || exit
done
