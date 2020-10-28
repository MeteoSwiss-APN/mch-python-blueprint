The requirements directory contains all dependencies except unpinned runtime dependencies, which are specified directly in setup.py.
The dependencies are managed as follows:

-   Unpinned dependencies (`requirements/*-unpinned.txt`) are specified manually, with as few version restrictions as possible.
-   Pinned dependencies (`requirements/*-pinned.txt`) are obtained with `pip freeze`.
    To obtain up-to-date pinned dependencies, use the respective make command `make update-*-deps`.
-   To update all pinned dependencies at once (including those of pre-commit hooks), run `make update-deps`.
-   If a file `requirements.txt` is found in the root of the project, it is used during installation under the assumption that it contains the pinned runtime dependencies.
    The latter are specified in `requirements/run-pinned.txt`, which is why `requirements.txt` constitutes a symlink to that file.
-   To use the unpinned runtime dependencies specified in `setup.py`, remove or rename the symlink `requirements.txt`.
