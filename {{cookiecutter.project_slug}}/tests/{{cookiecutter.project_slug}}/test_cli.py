"""Test module ``{{ cookiecutter.project_slug }}``."""
{%- if cookiecutter.include_sample_code == 'y' -%}
# Third-party
from click.testing import CliRunner

# First-party
from {{ cookiecutter.project_slug }} import cli


class TestCLI:
    """Test the command line interface."""

    def call(self, args=None):
        runner = CliRunner()
        return runner.invoke(cli.main, args)

    def test_default(self):
        result = self.call()
        assert result.exit_code == 0
        assert "test_cli_project.cli.main" in result.output

    def test_help(self):
        result = self.call(["--help"])
        assert result.exit_code == 0
        assert "Show this message and exit." in result.output

    def test_version(self):
        result = self.call(["-V"])
        assert result.exit_code == 0
        assert cli.__version__ in result.output

    def test_dry_run(self):
        result = self.call(["-n"])
        assert result.exit_code == 0
        assert "Is dry run" in result.output
{% endif %}
