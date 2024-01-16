#include <stdio.h>
void proc(int*, int);
int main () {
  int ints[] = {1,2,3,4};
  int L = sizeof(ints) / sizeof(int);
  int ints2[] = {2, 7, 1, 19, 18, 3};    
  int L2 = sizeof(ints2) / sizeof(int);
  
  proc(ints, L);
  proc(ints2, L2);

}
void proc(int* ints, int L) {
  int sum = 0;
  for (int i = 1; i <= L; i++) {
    (L%i==0) ? sum += ints[i-1]*ints[i-1] : 0 ;
  }
  printf("Input: ints = {");
  for (int i = 0; i < L - 1; i++) {
    printf("%d, ",ints[i]);
  }
  printf("%d}\n",ints[L-1]);  
  printf("Output: %d\n",sum);
}