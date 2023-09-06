#include <system.h>
#include <stdlib.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>

//#define ALT_CI_MOD_FP_MULT_0_N 0x0
//#define ALT_CI_MOD_FP_MULT_0(A,B) __builtin_custom_fnff(ALT_CI_MOD_FP_MULT_0_N,(A),(B))
//
//#define ALT_CI_MOD_FP_SUB_0_N 0x1
//#define ALT_CI_MOD_FP_SUB_0(A,B) __builtin_custom_fnff(ALT_CI_MOD_FP_SUB_0_N,(A),(B))

//#define ALT_CI_MOD_CUSTOM_TOP_0_N 0x0
//#define ALT_CI_MOD_CUSTOM_TOP_0_N_MASK ((1<<8)-1)
//#define ALT_CI_MOD_CUSTOM_TOP_0(n,A,B) __builtin_custom_fnff(ALT_CI_MOD_CUSTOM_TOP_0_N+(n&ALT_CI_MOD_CUSTOM_TOP_0_N_MASK),(A),(B))

//#define ALT_CI_MOD_CORDIC_0_N 0x0
//#define ALT_CI_MOD_CORDIC_0(A) __builtin_custom_fnf(ALT_CI_MOD_CORDIC_0_N,(A))

//#define ALT_CI_MOD_CORDIC_0_N 0x0
//#define ALT_CI_MOD_CORDIC_0(A) __builtin_custom_fnf(ALT_CI_MOD_CORDIC_0_N,(A))

#define ALT_CI_CUSTOM_0_N 0x0
#define ALT_CI_CUSTOM_0_N_MASK ((1<<8)-1)
#define ALT_CI_CUSTOM_0(n,A,B) __builtin_custom_fnff(ALT_CI_CUSTOM_0_N+(n&ALT_CI_CUSTOM_0_N_MASK),(A),(B))


// Test case 1
//#define step 5
//#define N 52
// Test case 2
//#define step 1/8.0
//#define N 2041
//Test case 3
#define step 1/1024.0
#define N 261121
// Test case 4
//#define step 1/1024.0
//#define N 2041
// Test case 5
//#define step 5
//#define N 2041
//Test case 6
//#define step 1/8.0
//#define N 261121
//Test case 7
//#define step 5
//#define N 261121

// Generates the vector x and stores it in the memory
void generateVector(float x[N])
{
	int i;
	x[0] = 0;
	for (i=1; i<N; i++)
		x[i] = x[i-1] + step;
}

//float sumVector(float x[], int M)
//{
// float y = 0;
// int j;
// for(j=0;j<M;j++){
//	 y = y + x[j] * 0.5 + x[j] * x[j] * cosf((x[j]-128)/128);}
// return y;
//}

float sumVector_custom(float x[], int M)
{
 float y = 0;
 int j = 0;
 for(j=0;j<M-2;j = j+2){
	 y = ALT_CI_CUSTOM_0(0,x[j],x[j+1]);
 }
 y = ALT_CI_CUSTOM_0(1,x[j],x[j+1]);
 return y;
 }

int main()
{
	printf("Task 6!\n");
	// Define input vector
	float x[N];
	// Returned result
	//float y;
	generateVector(x);
	// The following is used for timing
	char buf[50];

//	float a = 160.593322753906000000;
//	float cosine1 = ALT_CI_MOD_CORDIC_0(a);
//	printf("cosine: %f\n",cosine1);
//	float b = 117.350585937500000000;
//	float cosine2 = ALT_CI_MOD_CORDIC_0(b);
//	printf("cosine: %f\n",cosine2);

	clock_t exec_t1, exec_t2;

//	exec_t1 = times(NULL); // get system time before starting the process
//	float y = sumVector(x, N);
//	exec_t2 = times(NULL); // get system time after finishing the process
//	gcvt((exec_t2 - exec_t1), 10, buf);
//	alt_putstr(" proc time = ");
//	alt_putstr(buf);
//	alt_putstr(" ticks \n");
//	printf("y : %f\n",y);

	exec_t1 = times(NULL); // get system time before starting the process
	float y_custom = sumVector_custom(x, N);
	exec_t2 = times(NULL); // get system time after finishing the process
	gcvt((exec_t2 - exec_t1), 10, buf);
	alt_putstr(" proc time = ");
	alt_putstr(buf);
	alt_putstr(" ticks \n");

	printf("y custom: %f\n",y_custom);

	return 0;
}
