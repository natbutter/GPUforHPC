---
title: "Creating an environment for GPU computing"
---

This episode introduces a few ways we can set up a working GPU environemnt. You will find to get a well-functioning CUDA development environemnt there is a precious balance between your operating system, your model of GPU, your NVIDIA GPU driver, and your CUDA version that straddle across all the other pieces (not to mention the software, e.g. tensorflow, python, keras, matlab that depends on the underlying set-up).

## What is a GPU?

A Graphics Processing Unit as opposed to a Central Processing Unit (CPU).
Originally intended for sending an image to the pixels on the screen, someone then figured out that treating data as a texture map you could perfom lots of calculations simultanously, and the age of the GPGPU (general-purpose graphics processing unit) began.

GPU or CPU

Some workloads are great for GPUs others are not.

### How do you develop code for GPU computing?

The most common langauges for developing code for GPUs are
***CUDA***, ***OpenCL***, ***OpenACC***. These are all low-level and require fairly strong programming capabilities. However, high-level languages like ***Python*** and ***Matlab*** and subsequent packages within them (keras, tensorflow, theano, etc), can make use of your GPU by essentially writing CUDA for you! We will see a few examples and you can decide what language best suits your use cases.


## Requirements
On your local machine you will need some compilers. I will be using:

```gcc (Ubuntu 6.5.0-2ubuntu1~18.04) 6.5.0 20181026```

and the Nvidia cuda compiler (installed with the CUDA toolkit)

```nvcc release 9.0, V9.0.176```

For HPC work all you need an ssh client (instructions [here](./setup.html)).


### NVIDIA Installation instructions

**Windows 10**

Install the NVIDIA graphics driver.

Install the CUDA drivers.

Download both from the [NVIDIA download page](https://www.nvidia.com/Download/index.aspx?lang=en-us). Easy.

**Linux (Xubuntu 18.04)**

Probably as simple as selecting the NVIDIA driver.
Then installing the CUDA drivers for the driver/GPU combo.
More info here [https://informatics.sydney.edu.au/blogs/tf_on_linux/](https://informatics.sydney.edu.au/blogs/tf_on_linux/)



**Mac OSX**

If you have Mac product newer than about 2014 you probably don't have CUDA-capable GPU card in there. This was done for various reasons. Nevertheless, there are still drivers from NVIDA, and a few options with external GPUS. But good luck, you are on your own. For now, you can do the Artmeis examples!



### Which version(s) to use?

Depends what features you need, if you need the latest then go with that. 
Different cards have different compute capability and different CUDA requirements. And these options bleed down the dependcay list (also known as software stack). So if you don't know, go for the latest stable release compatible over your software stack.


**There is an update for XXXX, should I get it?**
Maybe, but probably not. (Not while I am teaching you anyway.) This workshop is for scientific development of applications, chances are you will hack together some code and run it once, so we are not aiming to get this working on every GPU system in the world. But versioning is super important.




# What about Containers?
Docker/singularity is great for simplifying the development environments, BUT they still require the underlying installitions of NVIDIA drivers for your specific GPU card, plus a version of CUDA that works with that combo!






{% include links.md %}
