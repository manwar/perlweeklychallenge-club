#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void proc(char *n) {
  printf("Input: %s\n", n);
  int nlen = strlen(n);
  int list[50];
  int listlen = 0;
  char num[50] = {};
  int numlen = 0;
  num[numlen++] = n[0];
  for (int i = 0; i < nlen - 1; i++) {
    if (n[i+1] != n[i]) {
      num[numlen] = '\0';
      list[listlen++] = atoi(num);
      for (int j = 0; j < numlen; j++)
	num[j] = '\0';
      numlen = 0;
      num[numlen++] = n[i+1];
    } else {
      num[numlen++] = n[i+1];
    }
  }
  list[listlen++] = atoi(num);
  int max = 0;
  for (int i = 0; i < listlen; i++)
    if (max < list[i]) max = list[i];
  printf("Output: %d\n", max);
}

int main() {
  char *num = "6777133339";
  proc(num);
  num = "1200034";
  proc(num);
  num = "44221155";
  proc(num);
  num = "88888";
  proc(num);
  num = "11122233";
  proc(num);
}
