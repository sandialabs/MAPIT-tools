#!/usr/bin/env bash
{
  OS="`uname -s`"
  ARCH="`uname -m`"
  if [ "$OS" == "Linux" ]
  then
  echo Downloading Miniconda...
  wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh -O ~/miniconda.sh &> /dev/null
  else
  echo Downloading Miniconda...
  curl https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-MacOSX-x86_64.sh -O ~/miniconda.sh &> /dev/null  && echo Download complete.
  fi
  echo Miniconda download completed.
  bash ~/miniconda.sh -b -p $HOME/miniconda &> /dev/null && echo Miniconda install completed.
  echo Installing MAPIT environment, please wait... &&
  rm -rf $HOME/miniconda.sh
  source $HOME/miniconda/etc/profile.d/conda.sh
  conda create --name MAPIT_env -y
  conda activate MAPIT_env
  #if its mac silicon we have to do something different
  #until pyside6 migration
  if [ "$ARCH" == "arm64" ]
  then
  conda install -c conda-forge pip "python<=3.10" PySide2 -y &> /dev/null  
  fi
  pip install git+https://github.com/sandialabs/MAPIT &> /dev/null 
  
  echo MAPIT environment install completed.
} || { echo Something went wrong: Install failed

}
