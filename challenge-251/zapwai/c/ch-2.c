#include <stdio.h>
void proc(int m,int n, int[m][n]);

void ex1() {  
  const int M = 3;
  const int N = 3;
  int a[M][N] = { { 3,  7,  8},
		  { 9, 11, 13},
		  {15, 16, 17} };
  proc(M,N,a);
} 

void ex2() {  
  const int M = 3;
  const int N = 4;
  int a[M][N] = { { 1, 10, 4, 2},
		  { 9, 3, 8, 7},
		  {15, 16, 17, 12} };
  proc(M,N,a);
} 

void ex3() {  
  const int M = 2;
  const int N = 2;
  int a[M][N] = { { 7,  8},
		  {1, 2} };
  proc(M,N,a);
} 

int main() {
  ex1();
  ex2();
  ex3();  
}

void proc(int M, int N, int a[M][N])  {
  int mins[M];
  int maxs[N];

  for (int i = 0; i < M; i++) {
    int min = a[i][0];
    for (int j = 0; j < N; j++) {
      int x = a[i][j];
      (min > x) ? min = x : 0;
    }
    mins[i] = min;
  }
  
  for (int j = 0; j < N; j++) {
    int max = 0;    
    for (int i = 0; i < M; i++) {
      int x = a[i][j];
      (max < x) ? max = x : 0;

    }
    maxs[j] = max;
  }

  int ans = -1;
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      if (mins[i] == maxs[j]) {
	ans = mins[i];
	goto over;
      }
    }
  }
 over:
  printf("Input: M = \n\t");
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      printf("%02d ", a[i][j]);
    }
    printf("\n\t");
  }
  printf("\nOutput: %d\n", ans);
}
