#!/bin/python

import subprocess as sp
from argparse import ArgumentParser, BooleanOptionalAction


def condacmd(cmd : str):
    '''Wrapper for conda shell commands.
    
    '''
    proc =  sp.run(f"conda {cmd}", shell=True, stdout=sp.PIPE, stderr=sp.STDOUT)
    outstream = ''
    if not proc.stdout is None:
        outstream += proc.stdout.decode('utf-8')
    if not proc.stderr is None:
        outstream += proc.stderr.decode('utf-8')
    print(outstream)
    return(outstream)


def install_env(env_name : str, pinned : bool = False, dev : bool =False,
            pyversion : str = 3.9, clean_install : bool = False):

    present_envs = condacmd('env list')
    if clean_install and env_name in present_envs:
        condacmd(f'env remove -n {env_name} -y')
        out = condacmd(f'create -n {env_name} python={pyversion} -y')
    if not env_name in present_envs:
        out = condacmd(f'create -n {env_name} python={pyversion} -y')
    if pinned:
        requirements = ['requirements/environment.yml']
    else:
        requirements = ['requirements/requirements.in']
        if dev:
            requirements.append('requirements/dev-requirements.in')
    for rfile in requirements:
        out = condacmd(f'install -y --name {env_name} --file {rfile}')



if __name__ == '__main__':

    parser = ArgumentParser()
    parser.add_argument("-n", "--name",
                    dest="env_name",
                    type=str,
                    help="name of the conda environment.")
    parser.add_argument("-p", "--pinned",
                    dest="pinned",
                    action=BooleanOptionalAction,
                    help="Set true for pinned installation from environment.yml")
    parser.add_argument("-d", "--dev",
                    dest="dev",
                    action=BooleanOptionalAction,
                    help="Set true for editable installation including dev requirements.")
    parser.add_argument("-v", "--pyversion",
                    dest="pyversion",
                    type=str,
                    help="Specify python version")
    parser.add_argument("-c", "--clean",
                    dest="clean",
                    action=BooleanOptionalAction,
                    help="Set true for clean installation (remove env before).")

    args = parser.parse_args()

    print(args)

    install_env(args.env_name, pinned=args.pinned, dev=args.dev,
            pyversion=args.pyversion, clean_install=args.clean)