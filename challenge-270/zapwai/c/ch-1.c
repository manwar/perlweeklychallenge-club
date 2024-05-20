#include <stdio.h>
#include <stdbool.h>

bool is_special(int m[3][3], int M, int N, int i, int j) {
  if (m[i][j] != 1) {
    return 0;
  }
  for (int k = 0; k < M; k++) {
    if (k == i) {
      continue;
    }
    if (m[k][j] != 0) {
      return 0;
    }
  }
  for (int k = 0; k < N; k++) {
    if (k == j) {
      continue;
    }
    if (m[i][k] != 0) {
      return 0;
    }
  }
  return 1;
}

void proc(int m[3][3], int M, int N) {
  printf("Input: m = ");
  int cnt = 0;
  for (int i = 0; i < M; i++) {
    printf("\n\t\t");
    for (int j = 0; j < N; j++) {
      printf("%d ", m[i][j]);
      if (is_special(m, M, N, i, j)) {
	cnt++;
      }
    }
  }
  printf("\nOutput: %d\n", cnt);
}

int main() {
  int matrix[3][3] = { {1, 0, 0},
		     {0, 0, 1},
		     {1, 0, 0},
  };

  int matrix2[3][3] = { {1, 0, 0},
		      {0, 1, 0},
		      {0, 0, 1},
  };

  proc(matrix, 3, 3);
  proc(matrix2, 3, 3);
}

