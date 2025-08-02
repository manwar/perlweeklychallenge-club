#include <stdio.h>
#include <stdbool.h>

void proc(int N, int matrix[N][N]) {
  bool fail = false;
  printf("Input: matrix = \n");
  for (int i = 0; i < N; i++) {
    printf("\t");
    for (int j = 0; j < N; j++) {
      printf("%d ", matrix[i][j]);
      if ((i == j) || (i == N - j - 1)) {
	if (matrix[i][j] == 0)
	  fail = true;
      } else {
	if (matrix[i][j] != 0)
	  fail = true;
      }
    }
    printf("\n");
  }
  printf("Output: %s\n", (!fail) ? "True" : "False");
}

int main() {
  int matrix[4][4] = { {1, 0, 0, 2},
		       {0, 3, 4, 0},
		       {0, 5, 6, 0},
		       {7, 0, 0, 1},
  };
  proc(4, matrix);

  int matrix2[3][3] = { {1, 2, 3},
			{4, 5, 6},
			{7, 8, 9},
  };
  proc(3, matrix2);

  int matrix3[3][3] = { {1, 0, 2},
			{0, 3, 0},
			{4, 0, 5},
  };
  proc(3, matrix3);
}

