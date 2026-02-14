#include <stdio.h>
#include <stdbool.h>
#include <string.h>

bool meets_at_origin(char *s) {
  int x=0,y=0;
  int len = strlen(s);
  for (int i = 0; i < len; i++) {
    if (s[i] == 'U') {
      y++;
    } else if (s[i] == 'D') {
      y--;
    } else if (s[i] == 'L') {
      x--;
    } else if (s[i] == 'R') {
      x++;
    }
    if (x == 0 && y == 0) {
      return true;
    }
  }
  return false;
}

int main(int argc, char *argv[]) {
  if (argc == 1 || argc > 2)
    return 1;
  char *s = argv[1];
  printf("Input: %s\n", s);
  printf("Output: %s\n", (meets_at_origin(s)) ? "true" : "false");
}
