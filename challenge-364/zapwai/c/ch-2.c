#include <stdio.h>

void proc(char *s) {
  printf("Input: %s\n", s);
  char buffer[200] = {};
  int b = 0;
  int i = 0;
  while (s[i] != '\0') {
    if (s[i] == '(' && s[i+1] == ')') {
      buffer[b++] = 'o';
      i += 2;
    } else if (s[i] == '(' && s[i+1] == 'a' && s[i+2] == 'l' && s[i+3] == ')') {
      buffer[b++] = 'a';
      buffer[b++] = 'l';
      i += 4;
    } else {
      buffer[b++] = s[i++];
    }
  }
  buffer[b] = '\0';
  printf("Output: %s\n", buffer);
}

int main() {
  char *s = "G()(al)";
  proc(s);
  s = "G()()()()(al)";
  proc(s);
  s = "(al)G(al)()()";
  proc(s);
  s = "()G()G";
  proc(s);
  s = "(al)(al)G()()";
  proc(s);
}
