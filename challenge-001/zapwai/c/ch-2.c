#include <stdio.h>
#include <stdbool.h>

int main() {
  for (int i = 1; i < 21; i++) {
    bool flag = true;

    if (i % 3 == 0) {
      printf("fizz");
      flag = false;
    }

    if (i % 5 == 0) {
      printf("buzz");
      flag = false;
    }

    if (flag) {
      printf("%d", i);
    }
      
    printf("\n");
  }
}
