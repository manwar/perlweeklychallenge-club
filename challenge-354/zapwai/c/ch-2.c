#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void proc(int k, int M, int N, int (*matrix)[M]) {
  printf("Input: k = %d\n", k);
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      printf("%d ", matrix[i][j]);
    }
    printf("\n");
  }
  
  // flatten
  int flat[M*N];
  int cnt = 0;
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      flat[cnt++] = matrix[i][j];
    }
  }

  /* shifted, flattened */
  int new[M*N];			
  for (int i = 0; i < k; i++)
    new[i] = flat[N*M-k+i];
  for (int i = k; i < N*M; i++)
    new[i] = flat[i-k];

  /* new numbers in original matrix configuration */
  int new_matrix[N][M];
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      new_matrix[i][j] = new[i*M+j];
    }
  }

  printf("Output: \n");
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      printf("%d ", new_matrix[i][j]);
    }
    printf("\n");
  }
  printf("\n");
}

int main() {
  int k = 1;
  int M = 2;
  int N = 2;
  int mat[2][2] = {{10, 20}, {30, 40}};
  proc(k, M, N, mat);
  
  M = 3; N = 3;
  int mat2[3][3] = {{1,2,3}, {4,5,6}, {7,8,9}};
  proc(k, M, N, mat2);

  M = 2; N = 3;
  int mat3[3][2] = {{1,2}, {3,4}, {5,6}};
  proc(k, M, N, mat3);

  M = 3; N = 2;
  int mat4[2][3] = {{1,2,3}, {4,5,6}};
  proc(k, M, N, mat4);

  M = 4; N = 1;
  int mat5[1][4] = {{1,2,3,4}};
  proc(k, M, N, mat5);
}
