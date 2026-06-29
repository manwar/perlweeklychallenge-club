#include <stdio.h>
#include <string.h>

int rev_ind(char c) {
  char *alph = "abcdefghijklmnopqrstuvwxyz";
  return 26 - (strchr(alph, c) - alph);
}

void proc(char *s) {
  printf("Input: \"%s\"\n", s);
  int len = strlen(s);
  int sum = 0;
  for (int i = 0; i < len; i++) {
    char c = s[i];
    int pos = 1 + i;
    sum += pos*rev_ind(c);
  }
  printf("Output: %d\n", sum);
}

int main() {
  char *s = "z";
  proc(s);
  s = "a";
  proc(s);
  s = "bbc";
  proc(s);
  s = "racecar";
  proc(s);
  s = "zyx";
  proc(s);
}
