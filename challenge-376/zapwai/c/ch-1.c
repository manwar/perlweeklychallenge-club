#include <stdio.h>
#include <string.h>

enum color {
  BLACK,
  WHITE
};

enum color cell_color(char *cell) {
  char *alph = "abcdefgh";
  int col = strchr(alph, cell[0]) - alph;
  int row = cell[1] - 1;
  return ((row+col) % 2 == 0) ? BLACK : WHITE;
}

void proc(char *c1, char *c2) {
  printf("Input: c1 = %s, c2 = %s\n", c1, c2);
  printf("Output: ");
  if (cell_color(c1) == cell_color(c2))
    printf("true\n");
  else
    printf("false\n");
}

int main() {
  char *c1 = "a7", *c2 = "f4";
  proc(c1, c2);
  c1 = "c1"; c2 = "e8";
  proc(c1, c2);
  c1 = "b5"; c2 = "h2";
  proc(c1, c2);
  c1 = "f3"; c2 = "h1";
  proc(c1, c2);
  c1 = "a1"; c2 = "g8";
  proc(c1, c2);
}
