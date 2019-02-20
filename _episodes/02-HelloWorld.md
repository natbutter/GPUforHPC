---
title: "Writing and running your first GPU program"
---

## Hello World

Make a new text file called ```hello_world.c```


```
#include <stdio.h>

void hello_world_kernel()
{
    printf("Hello World!\n");
}

int main()
{
    hello_world_kernel();
}
```

Now compile your C code with

```gcc hello_world.c -o hello_cpu```

And run it and get the expected output...
```
./hello_cpu
Hello World!
```

Great, so it is running as expected on CPU, now lets do it on the GPU. Make a new text file called ```hello_world.cu``` 

```
#include <stdio.h>

__global__ void hello_world_kernel()
{
    printf("Hello GPU World!\n");
}

int main()
{
    hello_world_kernel <<<1,8>>>();
    cudaDeviceReset();
}
```

Now compile it with the CUDA compiler, nvcc,

```nvcc hello_world.cu -o hello_gpu```

run it, and get the expected GPU output...

```
./hello_gpu
Hello GPU World!
Hello GPU World!
Hello GPU World!
Hello GPU World!
Hello GPU World!
Hello GPU World!
Hello GPU World!
Hello GPU World!
```

Another example, matrix multplication, and we can run it on CPU and GPU to get a becnhmark
Okay now let's take it to Artemis.



{% include links.md %}
