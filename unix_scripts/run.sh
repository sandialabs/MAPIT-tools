#!/usr/bin/env bash
{
  source $HOME/miniconda/etc/profile.d/conda.sh
  conda activate MAPIT_env
  MAPIT
} || { echo Something went wrong

}
