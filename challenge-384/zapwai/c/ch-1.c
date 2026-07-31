#include <stdio.h>
#include <math.h>

char value(int val, int b) {
  if (b < 10) {
    return val + '0';
  } else {
    if (val < 10) {
      return val + '0';
    } else {
      char *s = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";
      return s[val-10];
    }
  }
}

void proc(int num, int b) {
  printf("Input: num = %d, b = %d\n", num, b);
  if (b > 64) {
    printf("Unsupported base size (b > 64)\n");
    return;
  } else {
    int N = 0;
    while (num / pow(b,N) > 1) {
      N++;
    }
    char out[N+1] = {};
    int o = 0;
    for (int n = N-1; n >= 0; n--) {
      int val = (int) (num / pow(b,n));
      if (val > 0) {
	out[o++] = value(val, b);
      } else {
	out[o++] = '0';
      }
      num %= (int) pow(b,n);
    }
    out[o] = '\0';
    printf("Output: %s\n", out);
  }
}

int main() {
  int num = 42;
  int b = 2;
  proc(num, b);
  
  num = 493;
  int base = 8;
  proc(num, base);

  num = 15642094;
  base = 16;
  proc(num, base);

  num = 2228519;
  base = 36;
  proc(num, base);

  num = 123456789;
  base = 64;
  proc(num, base);

}
