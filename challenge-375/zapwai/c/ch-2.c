#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXLEN 20

void proc(int num, int k) {
  printf("Input: num = %d, k = %d\n", num, k);
  char s[MAXLEN];
  sprintf(s, "%d", num);
  int len = strlen(s);
  char sub[k+1];
  int cnt = 0;
  for (int i = 0; i <= len-k; i++) {
    strncpy(sub, s+i, k);
    sub[k] = '\0';
    int denom = atoi(sub);
    if (denom != 0)
      if (num % denom == 0) cnt++;
  }
  printf("Output: %d\n", cnt);
}

int main() {
  int num = 240;
  int k = 2;
  proc(num, k);
  num = 1020;
  proc(num, k);
  num = 444;
  proc(num, k);
  num = 17;
  proc(num, k);
  num = 123; k = 1;
  proc(num, k);
}
