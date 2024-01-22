#include <stdio.h>
/*  return 1 if rowi < rowj, 0 otherwise*/
int rowcmp(int i, int j, int *r) {
  if (r[i] < r[j]) {
    return 1;
  } else if (r[i] > r[j]) {
    return 0;
  } else {
    return (i < j) ? 1 : 0;
  }
}

void proc(int M, int N, int m[M][N]) {
  printf("Input: \n m = \n");  
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      printf("%d", m[i][j]);
    }
    printf("\n");    
  }
  int r[M];			/* find cnt of 1 in each row */
  for (int i = 0; i < M; i++) {
    int cnt = 0;
    for (int j = 0; j < N; j++) {
      (m[i][j] == 1) ? cnt++ : 0;
    }
    r[i] = cnt;
  }
  /* sort using the row method in rowcmp */
  int ans[M];
  for (int i = 0; i < M; i++) {
    ans[i] = i;
  }
  int cnt = 0;
  do {
    cnt = 0;
    for (int i = 0; i < M - 1; i++) {
      if (rowcmp(ans[i], ans[i+1], r) == 0) {
	int x = ans[i];
	ans[i] = ans[i+1];
	ans[i+1] = x;
	cnt++;
      }
    }
  } while (cnt > 0);
  printf("\nOutput: (");
  for (int i = 0; i < M - 1; i++) {
    printf("%d, ", ans[i]);
  }
  printf("%d)\n", ans[M-1]);
}

int main() {
  const int M = 5;
  const int N = 5;
  int m[M][N] =  {
    {1, 1, 0, 0, 0},
    {1, 1, 1, 1, 0},
    {1, 0, 0, 0, 0},
    {1, 1, 0, 0, 0},
    {1, 1, 1, 1, 1}
  };
  proc(M, N, m);
  printf("\n");
  const int M2 = 4;
  const int N2 = 4;
  int m2[M][N] =  {
    {1, 0, 0, 0},
    {1, 1, 1, 0},
    {1, 0, 0, 0},
    {1, 0, 0, 0},
  };
  proc(M2, N2, m2);
}