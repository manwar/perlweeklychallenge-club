#include <stdio.h>
#include <stdlib.h>
void proc(char* A[], int L) {
  int max = 0;
  
  printf("Input: (");
  for (int i = 0; i < L - 1; i++) {
    printf("%s, ", A[i]);
  }
  printf("%s)",A[L-1]);
  
  for (int i = 0; i < L; i++) {
    int j = 0;
    int num_cnt = 0;
    int len = 0;
    while (A[i][j]) {
      if ( (A[i][j] >= '0') && (A[i][j] <= '9') ) {
	num_cnt++;
      }
      len++;
      j++;
    }
    int x = -1;
    if (num_cnt == len) {
      x = atoi(A[i]);
    }
    else {
      x = len;
    }
    if (max < x) {
      max = x;
    }    
  }
  
  printf("\nOutput: %d\n\n", max);
}
int main() {
  const char* B[] = {"001", "1", "000", "0001"};
  int L2 = sizeof(B)/sizeof(char*);
  const char* A[] =  {"perl", "2", "000", "python", "r4ku"};
  int L = sizeof(A)/sizeof(char*);
  proc(A, L);
  proc(B, L2);  
}