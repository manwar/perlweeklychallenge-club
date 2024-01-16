#include <stdio.h>
void proc(int n) {
  int A[n];
  (n % 2 == 1) ? A[n-1] = 0 : 0 ;
  int k = n/2;
  for (int i = 0; i < k; i++){
    A[2*i] = i+1;
    A[2*i+1] = -1*(i+1);
  }
  printf("Input: n = %d\n", n);
  printf("Output: (");
  for (int i = 0; i < n-1; i++) {
    printf("%d, ",A[i]);
  }
  printf("%d)\n", A[n-1]);
}
int main () {
  proc(5);
  proc(7);
  proc(4);  
}