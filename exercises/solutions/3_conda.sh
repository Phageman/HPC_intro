#!/bin/bash
# Solutions, part 3: package management with Conda.
# These install software, so they are shown as comments:
# type the commands yourself, in your HPC_intro/exercise_data.

## 3.1 Install Miniforge
# m=https://github.com/conda-forge/miniforge
# f=Miniforge3-$(uname)-$(uname -m).sh
# curl -LO $m/releases/latest/download/$f
# bash $f                            # answer yes to "initialize conda"
#                                    # HPC: install in /hpc/<group>/<user>/data/miniforge3
# (open a new terminal)
# conda --version

## 3.2 Set up the channels
# conda config --add channels bioconda
# conda config --add channels conda-forge
# conda config --set channel_priority strict

## 3.3 Create an environment
# conda create -n qc seqkit
# conda activate qc

## 3.4 Use the tool
# seqkit stats */assembly.fasta      # num_seqs: A=5, B=3, C=8

## 3.5 Leave the environment
# conda deactivate
# conda env list

## 3.6 Share your environment
# conda env export -n qc --from-history > environment.yml
# git add environment.yml
# git commit -m "Add qc environment"
# git push
