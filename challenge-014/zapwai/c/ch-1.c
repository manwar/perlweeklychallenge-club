#include <stdio.h>
#include <stdbool.h>
#define N 20

void vaneck(int* seq, int* len) {
  if (*len == 1) {
    (*len)++;
    seq[1] = 0;
  }
  else {
    int pop = seq[*len - 1];
    bool done_flag = false;
    int j = *len - 2;
    while (j >= 0) {
      if ((!done_flag) && (pop == seq[j])) {
	done_flag = true;
	seq[*len] = *len - 1 - j;
	(*len)++;
      }
      j--;
    }
    if (!done_flag) {
      seq[*len] = 0;
      (*len)++;
    }
  }
}

int main() {
  int seq[N] = {};
  int len = 1;
  for (int i = 0; i < N; i++) {
    vaneck(seq, &len);
    printf("%d ", seq[i]);
  }
  printf("\n");
}
