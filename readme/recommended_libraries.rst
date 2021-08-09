
*********************
Recommended Libraries
*********************

How do I add a command line interface to my application?
--------------------------------------------------------

If you develop an application (rather than a library), chances are you want to provide a command line interface.
The Blueprint uses `click <https://click.palletsprojects.com>`__ (“Command Line Interface Creation Kit”), a library for creating command line interfaces in a composable way with as little code as necessary.
It is highly configurable but comes with sensible defaults out of the box.

The command line interface is defined in the file ``src/great_tool/cli.py``.
There, you can specify command line arguments and options, as well as the entry point(s) as specified in ``setup.py``.
A few sensible ones are already pre-defined (--version, --help, --verbose, --dry-run).

For a somewhat more sophisticated command line interface than that provided by default by the blueprint, see the sample calculator application (``sample_code=3`` during Blueprint setup).
