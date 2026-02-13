#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp (const void *a, const void *b) {
  int *x = (int *) a;
  int *y = (int *) b;
  return *x - *y;
}

int cmprev (const void *a, const void *b) {
  int *x = (int *) a;
  int *y = (int *) b;
  return *y - *x;
}

void fill_d(int *d, int I, char *s) {
  for (int i = 0; i < I; i++)
    d[i] = s[i] - '0';
}

int big(char *s) {
  int I = strlen(s);
  int d[I];
  fill_d(d, I, s);
  qsort(d, I, sizeof(int), cmprev);
  char buffer[6];
  for (int i = 0; i < I; i++)
    buffer[i] = '0' + d[i];
  buffer[I] = '\0';
  return atoi(buffer);
}

int small(char *s) {
  int I = strlen(s);
  int d[I];
  fill_d(d, I, s);
  qsort(d, I, sizeof(int), cmp);
  char buffer[6];
  for (int i = 0; i < I; i++)
    buffer[i] = '0' + d[i];
  buffer[I] = '\0';
  return atoi(buffer);
}

void proc(char *s) {
  printf("Input: %s\n", s);
  int iters = 0;
  if (strcmp(s, "6174") != 0) {
    int diff = big(s) - small(s);
    if (diff == 0) {
      iters = -1;
    } else {
      iters++;
      while(diff != 6174 && diff != 0) {
	iters++;
	char num[5];
	if (diff < 1000) {
	  sprintf(num, "0%d", diff);
	} else {
	  sprintf(num, "%d", diff);
	}
	diff = big(num) - small(num);
      }
    }
  }
  printf("Output: %d\n", iters);
}

int main(int argc, char *argv[]){
  if (argc == 1 || argc > 2)
    return 1;
  proc(argv[1]);
  return 0;
}
