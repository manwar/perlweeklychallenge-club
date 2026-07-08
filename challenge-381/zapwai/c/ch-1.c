#include <stdio.h>
#include <stdbool.h>

bool check_row(int n, int m[n][n]) {
  int cnt = 0;
  int a[n] = {};
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      int val = m[i][j];
      if (val > 0 && val <= n) {
	a[val - 1]++;
      }
    }
    for (int target = 1; target <= n; target++) {
      if (a[target - 1] == 1) cnt++;
    }
    for (int ind = 0; ind < n; ind++)
      a[ind] = 0;
  }
  return (cnt == n*n);
}

bool check_col(int n, int m[n][n]) {
  int transpose[n][n] = {};
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      transpose[i][j] = m[j][i];
    }
  }
  return check_row(n, transpose);
}

void proc(int n, int m[n][n]) {
  printf("Input: matrix = \n");
  for (int i = 0; i < n; i++) {
    printf("\t");
    for (int j = 0; j < n; j++) {
      printf("%d ", m[i][j]);
    }
    printf("\n");
  }

  printf("Output: %s\n", (check_row(n, m) && check_col(n, m)) ?
	 "true" : "false");
  
}

int main() {
  int m[4][4] = { {1,2,3,4}, {2,3,4,1}, {3,4,1,2}, {4,1,2,3}};
  proc(4, m);

  int n[3][3] = { {1,2,5}, {5,1,2}, {2,5,1}};
  proc(3, n);

  int o[3][3] = { {1,2,3}, {3,1,2}, {3,2,1}};
  proc(3, o);
}
