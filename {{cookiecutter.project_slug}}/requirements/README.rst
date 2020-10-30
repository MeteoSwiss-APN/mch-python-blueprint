The requirements directory contains all dependencies except unpinned runtime dependencies, which are specified directly in setup.py.
The dependencies are managed as follows:

-   Unpinned dependencies (`setup.py`, `requirements/*-unpinned.txt`) are specified manually.
    They comprise only directly used packages with as few version restrictions as possible, i.e., critical ones for functionality or security reasons.
-   Pinned dependencies (`requirements/*-pinned.txt`) are created with `pip freeze`.
    They comprise the whole dependency tree with fixed version numbers.
    To update pinned dependencies (run, dev, tox, precommit), use the respective `make update-*-deps`.
    (Note: Pre-commit dependencies are specified in `.pre-commit-config.yaml`, not in a requirements file.)
-   To update all pinned dependencies at once, run `make update-deps` (caution: must be updated don't use `-j[N]`).

