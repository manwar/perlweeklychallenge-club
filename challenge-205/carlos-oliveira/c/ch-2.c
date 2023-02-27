#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main (int argc, char **argv) {
  if (argc < 2) {
    printf("USAGE: %s N0 N1 N2 N3...\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  // at least zero we obtain in the XOR of a value by itself
  int max_value = 0;
  for (int i = 1; i < argc; i++) {
    // XOR is a symmetric operation,
    // no need to test with previous values
    for (int u = i + 1; u < argc; u++) {
      int a = atoi(argv[i]);
      int b = atoi(argv[u]);
      int xor = a ^ b;
      if (xor > max_value) {
        max_value = xor;
      }
    }
  }
  printf("%d\n", max_value);
}
