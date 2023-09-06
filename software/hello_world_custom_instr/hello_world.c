#include <system.h>
#include <stdio.h>
#define ALT_CI_CUSTOM_MUL_0_N 0x0
#define ALT_CI_CUSTOM_MUL_0(A,B) __builtin_custom_inii(ALT_CI_CUSTOM_MUL_0_N,(A),(B))
int main()
{
printf("Hello from Nios II!\n");
int a, b, c, d;
a = 2;
b = 4;
c = a*b;
printf("Multiplication result: %d\n", c);
d = ALT_CI_CUSTOM_MUL_0(a,b);
printf("Multiplication result from custom instr: %d", d);
return 0;
}
