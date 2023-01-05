#!/bin/bash -x
# update_tmpl_env.sh
# Create a default package and update the project's environment file


main()
{
    # Create a temporary default project
    local tmpdir="_tmp"
    if [[ -d "${tmpdir}" ]]; then
        \rm -rfv "${tmpdir}" || return
    fi
    copier -f --vcs-ref=HEAD . "${tmpdir}" || return

    # Update the project's environment file
    \cd "${tmpdir}" || return
    local env_name="flying-circus"
    bash -x tools/setup_env.sh -n "${env_name}" -ue || return
    conda env remove -n "${env_name}" || return
    \cd .. || return

    # Merge updated environment file back into template
    \cp -v "${tmpdir}"/environment.yml tmpl/environment.yml.j2 || return
    \sed -i 's/^name:.*/name: {{ project_slug }}/' tmpl/environment.yml.j2 || return

    # Clean up
    \rm -rv "${tmpdir}" || return
}


main "${@}"
