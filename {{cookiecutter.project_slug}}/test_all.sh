#!/bin/bash
# Run all tests and checkers
# By Stefan Ruedisuehli <stefan.ruedisuehli@env.ethz.ch>, 2022-09

# Exit when an error occurs
EXIT=${EXIT:-true}

# Final exit status if EXIT=false
STAT=0

main()
{
    run pre-commit run -a || return
    run black . || return
    run isort . || return
    run pydocstyle || return
    run mypy . || return
    run flake8 || return
    run pylint . || return
    run pytest || return
    return ${STAT}
}

run()
{
    local cmd="${@}"
    echo -e "\n\$ ${cmd[*]^Q}"
    eval "${cmd[*]^Q}" && return
    local stat=${?}
    STAT=$((STAT + 1))
    ${EXIT} && return ${stat} || return 0
}

main "${@}"
