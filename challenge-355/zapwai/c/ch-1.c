#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
  printf("Input: %s\n", argv[1]);
  int len = strlen(argv[1]);
  int x = len % 3;
  printf("Output: ");
  if (len < 4) {
    printf("%s", argv[1]);
  } else {
    for (int i = 0; i < len; i++) {
      printf("%c", argv[1][i]);
      if (i % 3 + 1 == x && i != len-1) printf(",");
    }
  }
  printf("\n");
}
