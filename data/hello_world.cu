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

