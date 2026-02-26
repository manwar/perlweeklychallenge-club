#include <stdio.h>
#include <string.h>

void proc(char *s) {
  printf("Input: %s\nOutput: ", s);
  int len = strlen(s);
  for (int i = 0; i < len; i++) {
    printf("%c", s[i]);
    for (int j = 0; j < i; j++)
      printf("%c", s[i]);
  }
  printf("\n");
}

int main() {
  char *str = "abca";
  proc(str);
  str = "xyz";
  proc(str);
  str = "code";
  proc(str);
  str = "hello";
  proc(str);
  str = "a";
  proc(str);
}
