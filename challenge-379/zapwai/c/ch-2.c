#include <stdio.h>
#include <math.h>

#define LIMIT 1000
#define MAXLEN 3

void proc(int base) {
  printf("Input: base = %d, limit = %d\n", base, LIMIT);
  int armstrong[LIMIT] = {};
  int armlen = 0;
  for (int num = 0; num < LIMIT; num++) {
    int n = num;
    int len = 0;
    int sum = 0;
    
    if (num != 0) {
      while (n != 0) { len++; n /= base; }
    } else {
      len = 1;
    }
    n = num;

    for (int i = 0; i < len; i++) {
      int d = n % base;
      n /= base;
      sum += pow(d,len);
    }
    printf("num: %d, sum: %d\n", num, sum);
    if (num == sum) {
      armstrong[armlen++] = num;
    }
  }
  printf("Output: (length: %d) ", armlen);
  for (int i = 0; i < armlen-1; i++){
    printf("%d, ", armstrong[i]);
  }
   printf("%d\n", armstrong[armlen-1]);
}

int main() {
  int base = 10;
  proc(base);
  base = 7;
  proc(base);
  base = 16;
  proc(base);
}
