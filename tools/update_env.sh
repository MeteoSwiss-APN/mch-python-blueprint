#!/bin/bash -x
# update_env.sh
# Create a default package and update the root environment file


main()
{
    # Create a temporary default project
    local tmpdir="_tmp"
    if [[ -d "${tmpdir}" ]]; then
        \rm -rfv "${tmpdir}" || return
    fi
    copier -f --vcs-ref=HEAD . "${tmpdir}" || return

    # Use script in project to update the root environment file
    local env_name
    env_name="$(\grep 'name: ' requirements.yml | sed 's/^name: *\(.\+\)$/\1/')" || return
    bash -x "${tmpdir}"/tools/setup_env.sh -n "${env_name}" -u -m || return
    conda env remove -n "${env_name}" || return

    # Clean up
    \rm -rv "${tmpdir}" || return
}


main "${@}"
