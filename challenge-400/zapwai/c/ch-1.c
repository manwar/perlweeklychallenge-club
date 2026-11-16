#include <stdio.h>
#include <stdbool.h>

void proc(int n) {
  printf("Input: %d\n", n);

  int o[n];
  int olen = 0;
  for (int num = 1; num <= n; num++) {
    if (num < 11) {
      o[olen++] = num;
      continue;
    }
    int freq[10] = {};		/* counts of digits */
    int mynum = num;
    while (mynum > 0) {
      int last_digit = mynum % 10;
      mynum /= 10;
      freq[last_digit]++;
    }
    bool flag = false;
    for (int i = 0; i <= 9; i++) {
      if (freq[i] > 1) {
	flag = true;
	break;
      }
    }
    if (flag) continue;
    o[olen++] = num;
  }
  int out = 0;
  for (int i = 0; i < olen; i++) {
    int diff = o[i+1]  - o[i];
    if (diff > out) out = diff;
  }
  printf("Output: %d\n", out);
}

int main() {
  int k = 20;
  proc(k);
  k = 110;
  proc(k);
  k = 500;
  proc(k);
  k = 2026;
  proc(k);
  k = 10000;
  proc(k);
}
