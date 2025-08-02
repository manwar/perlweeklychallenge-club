#include <stdio.h>

void proc(int M, int N, int m[M][N]) {
  printf( "Input: m = \n");
  for (int i = 0; i < M; i++) {
    printf("\t");
    for (int j = 0; j < N; j++)
      printf("%d ", m[i][j]);
    printf("\n");
  }
  int cnt[M];
  for (int i = 0; i < M; i++)
    cnt[i] = 0;

  for (int i = 0; i < M; i++)
    for (int j = 0; j < N; j++)
      if (m[i][j] == 1)
	cnt[i]++;

  int max = 0;
  int max_index = 0;
  for (int i = 0; i < M; i++) {
    if (cnt[i] > max) {
      max_index = i;
      max = cnt[i];
    }
  }
  printf("Output: row %d (count is %d)\n", max_index + 1, max);
}

int main(){
  int matrix[2][2] = { {0, 1},
		       {1, 0},
  };
  proc(2, 2, matrix);
  int matrix2[2][3] = { {0, 0, 0},
			{1, 0, 1},
  };
  proc(2, 3, matrix2);
  int matrix3[3][2] = { {0, 0},
			{1, 1},
			{0, 0},
  };
  proc(3, 2, matrix3);
}
