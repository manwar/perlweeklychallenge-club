#include <stdio.h>
#include <stdbool.h>

bool is_echelon(int M, int N, int m[M][N]) {
  int zcnt = 0;
  for (int i = 0; i < M; i++) {
    int cnt = 0;
    for (int j = 0; j < N; j++) {
      if (m[i][j] == 0) {
	cnt++;
      } else {
	break;
      }
    }
    if (cnt < zcnt) {
      return false;
    } else {
      zcnt = cnt;
    }
  }
  return true;
}

bool is_reduced(int M, int N, int m[M][N]) {
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      if (m[i][j] == 0) {
	continue;
      } else if (m[i][j] == 1) {
	break;
      } else {
	return false;
      }
    }
  }
  int fv = N - M;
  for (int j = 0; j < N - fv; j++) {
    int cnt = 0;
    for (int i = 0; i < M; i++) {
      if (m[i][j] != 0) {
	cnt++;
      }
    }
    if (cnt > 1) {
      return false;
    }
  }
  return true;
}

bool check(int M, int N, int m[M][N]) {
  return (is_echelon(M, N, m) && is_reduced(M, N, m));
}

void proc(int M, int N, int m[M][N]) {
  printf("Input: M = {\n");
  for (int i = 0; i < M; i++) {
    printf("\t{");    
    for (int j = 0; j < N - 1; j++) {
      printf("%d, ", m[i][j]);
    }
    printf("%d", m[i][N - 1]);    
    printf("}\n");
  }
  printf("\t}\n");
  printf("Output: %d\n", check(M, N, m));
}

int main() {
  const int M = 3;
  const int N = 4;
  int m[M][N] = {
    {1,0,0,1},
    {0,1,0,2},
    {0,0,1,3}
  };
  proc(M, N, m);

  const int M2 = 3;
  const int N2 = 3;  
  int m2[M2][N2] = {
    {1, 1, 0},
    {0, 1, 0},
    {0, 0, 0}
  };
  proc(M2, N2, m2);

  const int M3 = 4;
  const int N3 = 5;  
  int m3[M3][N3] = {    
    {0, 1,-2, 0, 1},
    {0, 0, 0, 1, 3},
    {0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0}
  };
  proc(M3, N3, m3);  

  const int M4 = 3;
  const int N4 = 4;
  int m4[M4][N4] = {
    {1, 0, 0, 4},
    {0, 1, 0, 7},
    {0, 0, 1,-1}
  };
  proc(M4, N4, m4);  

  const int M5 = 4;
  const int N5 = 5;
  int m5[M5][N5] = {
    {0, 1,-2, 0, 1},
    {0, 0, 0, 0, 0},
    {0, 0, 0, 1, 3},
    {0, 0, 0, 0, 0}
  };
  proc(M5, N5, m5);

  const int M6 = 3;
  const int N6 = 3;  
  int m6[M6][N6] = {
    {0, 1, 0},
    {1, 0, 0},
    {0, 0, 0}
  };
  proc(M6, N6, m6);

  const int M7 = 3;
  const int N7 = 4;  
  int m7[M7][N7] = {
    {4, 0, 0, 0},
    {0, 1, 0, 7},
    {0, 0, 1,-1}
  };
  proc(M7, N7, m7);
}
