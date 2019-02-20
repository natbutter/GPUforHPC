---
title: "Matlab GPU example"
---

If you have Matlab installed, open up ```data/gpu_demo_Mandelbrot.m```.

You can go ahead and click the run button and the script should start running (probabbly takes about 1 minute)!
Near the top of the code, the command ```gpuDevice``` should give you some information about GPU devices that Matlab can see.

We will run it locally in the Matlab GUI, then demo how to run it on Artemis. You can compare the Artemis GPUs and your own.

## The Mandelbrot Set

This example is a modified version of the ```paralleldemo_gpu_mandelbrot.m``` code provided by MathWorks.
The algorithm in the code generates the complex numbers of the Mandelbrot Set that produces fractal shapes.
The code shows examples that use a purely CPU approach, and then adaptations of this to use GPU hardware in three ways: 

* 1-Using the existing algorithm but with GPU data as input
* 2-Using arrayfun to perform the algorithm on each element independently
* 3-Using the MATLAB/CUDA interface to run some existing CUDA/C++ code

### CPU

This example evaluates the function ```$ f(z) = z^2 + z_0 $``` over a grid of values. In this version we are just using the CPU to loop through the function evaluation one-by-one in a typical serial execution.
Read the ```gpu_demo_Mandelbrot.m``` script to see the details. For now, check out the solution: 

<figure>
  <img src="{{ page.root }}/fig/CPU.png" style="height:480px"/>
  <figcaption> CPU version of Mandelbrot set, saved as **CPU.png** </figcaption>
</figure><br>



### GPU-1 Using gpuArray

The next example makes use of Matlab's ability to solve grided datasets using the GPU. The only diffference in the code is where the coordinates of the grid are initialised, the inbuilt Matlab command ```gpuArray``` is used to  store the data on the GPU, so any computation done on this arrray are automatically done via the GPU. It is a super simple way to potentially speed up some calculations.

Check out **GPU.png** for the naive results.

### GPU-2 Element wise Operation

Building on the last gpuArray initialiastion - if we directly call a function (instead of cranking through the script), Matlab can intelligently perform the function call simultaneously over each element stored in the gpuArray. 

Check out **GPU_array.png** for the results.

### GPU-3 Working with CUDA

The last example is essentially writing straight C++ CUDA coda and compiling it with C-Mex (C-MatlabExecutable).  The code is precompiled for this example and the call to the function is made with the ```feval``` command.

If you have a CU file you want to execute on the GPU through Matlab, you must first compile it to create a PTX file. One way to do this is with the nvcc compiler in the NVIDIA CUDA Toolkit. In this example, the CU file is called ```pctdemo_processMandelbrotElement.cu```, you can create a compiled PTX file with the shell command:
```
nvcc -ptx pctdemo_processMandelbrotElement.cu
```
Just like we did for the hello world example earlier. This generates the file named ```pctdemo_processMandelbrotElement.ptx```

Check out **GPU_CUDA.PNG** for the super-fast speed up.

## Matlab GPU on Artemis.

To run this example on Artemis, first copy the ```gpu_demo_Mandelbrot.m``` Matlab script to Artemis. You can use whatever method you like to [transfer it to Artemis](https://sydneyuni.atlassian.net/wiki/spaces/RC/pages/212795438/Transferring+data+between+your+local+computer+and+HPC), but here is how to do it with ```scp```:

```
scp data/gpu_demo_Mandelbrot.m ict_hpctrain1@hpc.sydney.edu.au:/project/Training/nathan
```

Next connect to Artemis using your favourite method, navigate to where you copied the file, copy an old *.pbs script and get ready to make some changes to it

```
ssh -X ict_hpctrain1@hpc.sydney.edu.au
cd /project/Training/nathan
cp /project/Training/nathan/hello.pbs to runMatlab.pbs
nano matlab.pbs
```

Now update the PBS script we wrote before so it is appropriate for this example:
```
#! /bin/bash

#PBS -P Training
#PBS -N k40_matlab 
#PBS -l select=1:ncpus=2:mem=4gb:ngpus=1
#PBS -l walltime=0:10:00
#PBS -q defaultQ

cd /project/Training/nathan/

module load matlab/R2018a
module load cuda/8.0.44

matlab -nosplash -nodisplay -r "gpu_demo_Mandelbrot" > matlab_output.log

```

When you have made all the required changes, run the script with ```qsub runMatlab.pbs```.
After a few minutes your code should successfully run and you will see the files:

```
matlab_output.log
k40_matlab.o886
k40_matlab.o886_usage
k40_matlab.e886
CPU.png
GPU.png
GPU_array.png
GPU_CUDA.png
```

The ```matlab_output.log``` file contains what is normally displayed in the Matlab terminal, but we redirected it to this file instead. The ```k40_matlab.o/e?????``` files contain the Artemis output (probably empty because all of this ends up in the log file in this example), the error file, and the usage files. The ```*.png``` files are the images of the output. Copy them to your local machine if you want to look at the output, or if you have x-fowarding enabled you can look at them directly using:
```
module load imagemagick
display CPU.png
```

What do you think of these speed ups? Crazy right!? Just imagine how many papers you can publish now!
