#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *reverse(char* s) {
  int len = strlen(s);
  char o[len+1] = {};
  int olen = 0;
  for (int i = len - 1; i >= 0; i--) {
    o[olen++] = s[i];
  }
  o[olen] = '\0';
  char *out = malloc(len+1);
  strcpy(out, o);
  return out;
}

void proc(char *s) {
  printf("Input: str = %s\n", s);
  char *o = reverse(s);
  int len = strlen(s);
  char *subs[len - 1];
  for (int i = 0; i < len - 1; i++) {
    subs[i] = malloc(3);
    strncpy(subs[i], s+i, 2);
    subs[i][2] = '\0';
  }
  char *out = "false";
  for (int i = 0; i < len - 1; i++) {
    if (strstr(o,subs[i]) != NULL) {
      out = "true";
      break;
    }
  }
  free(o);
  for (int i = 0; i < len - 1; i++)
    free(subs[i]);
  printf("Output: %s\n", out);
}

int main() {
  char *s = "abcba";
  proc(s);
  s = "racecar";
  proc(s);
  s = "abcd";
  proc(s);
  s = "banana";
  proc(s);
  s = "hello";
  proc(s);
}
