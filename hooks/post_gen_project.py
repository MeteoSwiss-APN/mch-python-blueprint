#!/usr/bin/env python
# Standard library
import os
import shutil

PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)


def remove_file(filepath):
    if os.path.isfile(filepath):
        os.remove(filepath)
    elif os.path.isdir(filepath):
        shutil.rmtree(filepath)


# Create symlink requirements.txt to requirements/run-pinned.txt
link = "requirements.txt"
target = "requirements/run_pinned.txt"
os.symlink(target, link)


if __name__ == '__main__':
    pass
