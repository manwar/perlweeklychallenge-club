#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

/* consumes s */
void strrev(char* s) {
  int length = strlen(s);
  for (int i = 0; i < length / 2; i++) {
    char tmp = s[i];
    s[i] = s[length - i - 1];
    s[length - i - 1] = tmp;
  }
}

bool is_pal(char* s) {
  char r[50];
  strcpy(r, s);
  strrev(r);
  return 0 == strcmp(s,r) ? true : false;
}

void proc(char* s) {
  printf("Input: %s\n", s);
  int n = atoi(s);
  int found = 0;
  int step = 1;
  while (found == 0) {
    int m = n - step;
    char ms[50];
    sprintf(ms, "%d", m);
    if (is_pal(ms)) {
      found = 1;
      n = m;
    } else {
      m = n + step;
      sprintf(ms, "%d", m);
      if (is_pal(ms)) {
	found = 1;
	n = m;
      }
    }
    step++;
  }
  printf("Output: %d\n", n);
}

int main() {
  char* s = "123";
  proc(s);
  s = "2";
  proc(s);
  s = "1400";
  proc(s);
}
