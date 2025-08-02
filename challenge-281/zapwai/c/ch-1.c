#include <stdio.h>

void proc(char coord[]) {
  printf("Input: %s\n", coord);
  char l = coord[0];
  int n = coord[1] - '0';
  if (l == 'a' || l == 'c' || l == 'e' || l == 'g') {
    if (n % 2 == 0) {
      printf("Output: True\n");
    } else {
      printf("Output: False\n");
    }
  } else {
    if (n % 2 == 1) {
      printf("Output: True\n");
    } else {
      printf("Output: False\n");
    }
  }
}

int main() {
  char coord[] = "d3";
  proc(coord);
  char coord2[] = "g5";
  proc(coord2);
  char coord3[] = "e6";
  proc(coord3);
}

