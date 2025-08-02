#include <stdio.h>
#include <stdlib.h>

void display(int **m, int N) {
  for (int i = 0; i < N; i++) {
    for (int sp = 0; sp < N - i; sp++) {
      printf(" ");
    }
    for (int j = 0; j <= i; j++) {    
      printf("%d ", m[i][j]);
    }
    printf("\n"); 
  }
}

int main(int argc, char* argv[]) {

  if (argc != 2) {
    printf("Usage: %s N\n", argv[0]);
    return 1;
  }

  int N = atoi(argv[1]);
  int **m = malloc(N * sizeof(int*)); // Allocate memory for 2D array

  for (int i = 0; i < N; i++) {
    m[i] = malloc(N * sizeof(int));
  }
  
  m[0][0] = 1;
  m[1][0] = 1;
  m[1][1] = 1;
  for (int i = 0; i < N; i++) {
    for (int j = 0; j <= i; j++) {
      if ( (j == 0) || (j == i) ) {
	m[i][j] = 1;
      } else {
	m[i][j] = m[i-1][j-1] + m[i-1][j];
      }
    }
  }
  display(m, N);

  for (int i = 0; i < N; i++) {
    free(m[i]);
  }
  free(m);
}
