#include <stdio.h>
#include <stdlib.h>

void proc(int n) {
  int** A = malloc(n * sizeof(int*));
  for (int i = 0; i < n; i++)
    A[i] = malloc(n * sizeof(int));
  
  for (int i = 0; i < n; i++)
    A[i][i] = 1;

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++)
      printf("%d ", A[i][j]);
    printf("\n");
  }
  for (int i = 0; i < n; i++)
    free(A[i]);
  free(A);
}

int main() {
  int n = 7;
  proc(n);
}
