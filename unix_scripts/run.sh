#!/usr/bin/env bash
{
  source $HOME/miniconda/etc/profile.d/conda.sh
  conda activate MAPIT_env
  python ../src/MAPIT.py
} || { echo Something went wrong

}
