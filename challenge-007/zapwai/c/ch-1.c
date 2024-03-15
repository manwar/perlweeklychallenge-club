#include <stdio.h>
#include <stdbool.h>

bool is_niven(int i) {
  int num = i;
  int tally = 0;
  while (num > 0) {
    tally += num % 10;
    num /= 10;
  }
  return (i % tally == 0);
}

int main() {
  for (int i = 1; i < 51; i++) {
    if (is_niven(i))
      printf("%d\n", i);
  }
}
