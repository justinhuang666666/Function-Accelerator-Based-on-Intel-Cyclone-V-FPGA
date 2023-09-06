#include <stdlib.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <stdio.h>
#include <unistd.h>
// Test case 1
//#define step 5
//#define N 52
// Test case 2
//#define step 1/8.0
//#define N 2041
//Test case 3
//#define step 1/1024.0
//#define N 261121
// Test case 4
//#define step 1/1024.0
//#define N 2041
// Test case 5
#define step 5
#define N 2041

// Generates the vector x and stores it in the memory
void generateVector(float x[N])
{
	int i;
	x[0] = 0;
	for (i=1; i<N; i++)
		x[i] = x[i-1] + step;
}
float sumVector(float x[], int M)
{
 float y = 0;
 int j;
 for(j=0;j<M;j++)
	 y = y + x[j] +x[j]*x[j];
 return y;
}
int main()
{
	printf("Task 2!\n");
	// Define input vector
	float x[N];
	// Returned result
	float y;
	generateVector(x);
	// The following is used for timing
	char buf[50];
	clock_t exec_t1, exec_t2;
	exec_t1 = times(NULL); // get system time before starting the process
	// The code that you want to time goes here
	y = sumVector(x, N);
	// till here
	exec_t2 = times(NULL); // get system time after finishing the process
	gcvt((exec_t2 - exec_t1), 10, buf);
	alt_putstr(" proc time = ");
	alt_putstr(buf);
	alt_putstr(" ticks \n");
	int i;
//	for (i=0; i<10; i++)
//		y = y/2.0;
	printf("%d\n",y);
	return 0;
}
