#include <stdio.h>
#include <math.h>
#include <stdbool.h>
#include "vec.h"

void proc(int ints[], int N);
bool truth(int* ints, int N);
  
int main() {
  int ints[] = {1, 2, 3, 4, 5};
  int ints2[] = {2, 3, 8, 16};
  int ints3[] = {1, 3, 5, 7, 9};
  proc(ints, sizeof(ints) / sizeof(int));
  proc(ints2, sizeof(ints2) / sizeof(int));
  proc(ints3, sizeof(ints3) / sizeof(int));
}

int* dec_to_bin(int x, int N) {
  int* b = malloc(sizeof(int) * (N+1));
  for (int i = 0; i <= N; i++) {
    if (x >= pow(2, N - i)) {
      b[i] = 1;
      x -= pow(2, N - i);
    } else {
      b[i] = 0;
    }
  }
  return b;
}

bool truth(int* ints, int N) {
  for (int i = 0; i < pow(2, N); i++) {
    int d[80] = {};
    int* b = dec_to_bin(i, N-1);
    /* for (int j = 0; j < N; j++) */
    /*   printf("%d ", b[j]); */
    /* printf("\n"); */
    
    vec current_list;
    init_vec(&current_list);
    for (int j = 0; j < N; j++)
      if (1 == b[j])
	push(&current_list, ints[j]);
    free(b);
    if (1 >= current_list.size)
      continue;
    int tally = 0;
    for (int j = 0; j < current_list.size; j++)
      tally = tally | current_list.data[j];

    int* x = dec_to_bin(tally, N-1);
    int last_bin_dig = x[N-1];
    if (last_bin_dig == 0) {
      display(&current_list);
      printf(" -> ");
      for (int j = 0; j < N; j++)
	printf("%d", x[j]);
      destroy_vec(&current_list);
      free(x);
      return 1;
    }
    free(x);
    destroy_vec(&current_list);
  }
  return 0;
}

void proc(int ints[], int N) {
  printf("Input: ints = { ");
  for (int i = 0; i < N; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  printf("Output: ");
  if (truth(ints, N)) {
    printf(" true\n");
  } else {
    printf("false\n");
  }
}

