---
title: "Deep Learning Time Series with Python, tensorflow, and a GPU"
---

Python offers many ways to make use of the compute capability in your GPU. A very common application is deep learning using the tensorflow and keras packages. In this example we are going to look at forecasting a timeseries using recurrent neural netowrks based on the history of the time series itself.

## You can run through the steps on you local machine using the Jupyter notebook example

## Run the straight python script to do everything in "batch" mode. This is how we have to run it on Artmeis.

### Running on Artemis

## Set up the environment

So far we have dealt with fairly well-behaved packages on Artmeis. There are ~~dozens~~ hundreds of maintained bits of software and libraries on Artemis. But there are thousands of users and often we need very particular versions and workflows, so keeping every combination of software centrally maintained is just not feasible. Instead, often we have to build our own programs from scratch (just how we built our helloworld example from source!). This is a useful skill to have when you move to other HPC facilities like our national collabraotive infastructure [NCI](http://nci.org.au/) and [Pawsey](https://pawsey.org.au/), where you will undoubtably have to set up your own environemnts to work in.


You can use the prebuilt environment in ```/project/Training/GPUtraining/miniconda``` - or follow these instructions to get it running in your own folder (which you will need to do when you are not using the training logins).

The first thing we need is a specifc python version. Start by navigating to the directory you want to install it in

```
cd /project/Training/nathan
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda

module load cuda/8.0.44
module load openmpi-gcc/3.0.0-cuda

miniconda/bin/conda create -n pyGPUk40 python=3.5
source miniconda/bin/activate pyGPUk40

pip install /usr/local/tensorflow/tensorflow-1.4.0-cp35-cp35m-linux_x86_64.whl
pip install keras==2.0.8
pip install pandas
pip install matplotlib
pip install sklearn
pip install h5py
```

Note: Artemis has some specific versions of tensorflow that it needs to install. These are located in the directory ```/usr/local/tensorflow/```. You can see the various verisons in there. We are using one that is compatible with the NVIDIA k40 GPUs on the training node. If using the NVIDIA v100 GPUs in the production environment, you will have to use a different combo of python/cuda/tensorflow/keras. Check compatability here

Cool, we are ready to submit our script to the scheduler! Use this runk40.pbs pbs script:

```
#! /bin/bash

#PBS -P Training
#PBS -N k40ts 
#PBS -l select=1:ncpus=2:mem=2gb:ngpus=1
#PBS -l walltime=00:10:00
#PBS -q defaultQ

cd /project/Training/DL/

module load cuda/8.0.44
module load openmpi-gcc/3.0.0-cuda
source /project/Training/GPUtraining/miniconda/bin/activate pyGPUk40

#print out the version of tensorflow we are running
python -c 'import tensorflow as tf; print(tf.__version__)'
python ts_100k.py
```

And run the script with ```qsub runk40.pbs```. Then you can look for the output, in this case it trains a model and saves it as a hdf5 file. Plus it performs the prediction for us onthis data. But you could train a model that takes a week on Artemis, save the model output to your local machine and do the small-scale stuff, like predicting on other datasets and retraining. The possibilites are endless!


Open up runv100.pbs, what are the differences? This pbs script will is built to run on the real Artemis environment. So note the different versions hre. In fact, if you try and run it, it will fail because the GPU is compatiblte with this version of tensorflow.





