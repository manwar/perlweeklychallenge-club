#include <stdio.h>
#include <stdlib.h>

#define HIGHESTS_LEN 3

int main (int argc, char **argv) {
  if (argc < 2) {
    printf("USAGE: %s N0 N1 N2 N3...\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  int highests[HIGHESTS_LEN];
  int highests_pos = HIGHESTS_LEN;
  int i = 1;

OUTER_LOOP:
  while (i < argc) {
    int value = atoi(argv[i++]);
    for (int u = HIGHESTS_LEN - 1; u >= highests_pos; u--) {
      // find the maximum distinct values,
      // condition inferred by the last example on the task
      if (value == highests[u]) {
        goto OUTER_LOOP;
      } else if (value > highests[u]) {
        for (int y = 0; y < u; y++) {
          highests[y] = highests[y + 1];
        }
        if (highests_pos > 0) {
          --highests_pos;
        }
        highests[u] = value;
        goto OUTER_LOOP;
      }
    }
    if (highests_pos > 0) {
      highests[--highests_pos] = value;
    }
  }


  if (highests_pos == 0) {
    printf("%d\n", highests[0]);
  } else {
    printf("%d\n", highests[HIGHESTS_LEN - 1]);
  }
}
