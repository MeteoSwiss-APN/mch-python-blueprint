#!/bin/python

import subprocess as sp
from argparse import ArgumentParser, BooleanOptionalAction
from os import path


def shellcmd(cmd : str):
    '''Wrapper for shell commands.
       Just to save some copy pasting.

    '''
    proc = sp.run(cmd, shell=True, stdout=sp.PIPE, encoding="utf-8", check=True)
    print(proc.stdout)
    return(proc.stdout)


def install_env(env_name : str, pinned : bool = False, dev : bool =False,
            pyversion : str = 3.9, clean_install : bool = False):

    present_envs = shellcmd("conda env list")
    if clean_install and env_name in present_envs:
        shellcmd(f"conda env remove -n {env_name} -y")
        out = shellcmd(f"conda create -n {env_name} python={pyversion} -y")
    if not env_name in present_envs:
        out = shellcmd(f"conda create -n {env_name} python={pyversion} -y")
    if pinned:
        requirements = ["requirements/environment.yml"]
    else:
        requirements = ["requirements/requirements.in"]
        if dev:
            requirements.append("requirements/dev-requirements.in")
    for rfile in requirements:
        out = shellcmd(f"conda install -y --name {env_name} --file {rfile}")



if __name__ == "__main__":

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
    shellcmd(f"conda activate {args.env_name}")

    pipdep_path = "requirements/pip-requirements.in"
    if path.isfile(pipdep_path):
        print("Installing pip dependencies")
        shellcmd(f"pip install --requirement {pipdep_path}")
    else:
        print("No pip dependencies found, continue ...")

    if args.dev:
        print("Installing package editable.")
        shellcmd("pip install --editable .")
    else:
        print("Installing package not editable.")
        shellcmd("pip install .")