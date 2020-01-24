
##############
Python at CSCS
##############

How to set up and use Python at CSCS.


Load Python Environment
=======================

On arolla/tsa
-------------

Add the following commands to your `.bashrc`::

    # Load pristine Python environment
    source "/users/osm/.opr_setup_dir"
    source "${OPR_SETUP_DIR}/.python_base"
    unset PYTHONPATH
    
    # Access pipx etc.
    export PATH="/users/osm/bin:${PATH}"
    
This changes the environment as follows (as of January 2020)::

    $ module list
    Currently Loaded Modulefiles:
     1) craype-x86-skylake   2) craype-network-infiniband   3) slurm/19.05.04
     
    $ cat "${OPR_SETUP_DIR}/.python_base"
    module load PrgEnv-gnu/19.2
    module load python/3.7.4
    module load geos/3.7.2-fosscuda-2019b
    module load proj/6.1.1-fosscuda-2019b

    $ source "${OPR_SETUP_DIR}/.python_base"

    $ module list
    Currently Loaded Modulefiles:
     1) craype-x86-skylake             8) cuda/10.1.243                          15) fosscuda/.2019b                     
     2) craype-network-infiniband      9) gcccuda/2019b                          16) PrgEnv-gnu/19.2(default)            
     3) slurm/19.05.04                10) openmpi/4.0.2-gcccuda-2019b-cuda-10.1  17) python/3.7.4                        
     4) gcccore/.8.3.0                11) openblas/0.3.7-gcc-8.3.0               18) geos/3.7.2-fosscuda-2019b(default)  
     5) zlib/.1.2.11-gcccore-8.3.0    12) gompic/2019b                           19) proj/6.1.1-fosscuda-2019b           
     6) binutils/.2.32-gcccore-8.3.0  13) fftw/3.3.8-gompic-2019b                
     7) gcc/8.3.0


On kesch/escha
--------------

Add the following commands to your `.bashrc`::

    # Load pristine Python environment
    module use /apps/common/UES/sandbox/kraushm/kesch/modules/all
    module load python/3.7.2-gmvolf-17.02
    unset PYTHONPATH
    
    # Access pipx etc.
    export PATH="/users/osm/bin:${PATH}"
