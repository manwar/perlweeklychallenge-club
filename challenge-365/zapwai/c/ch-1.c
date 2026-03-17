#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int sum_digits(int num) {
  int digit[50] = {};
  int d = 0;
  while (num > 0) {
    int current = num % 10;
    digit[d++] = current;
    num = num/10;
  }
  int sum = 0;
  for (int i = 0; i < d; i++) {
    sum += digit[i];
  }
  return sum;
}

int conv(char *s) {
  char *alph = "abcdefghijklmnopqrstuvwxyz";
  int i = 0;
  int output = 0;

  while (s[i] != '\0') {
    char *pnt = strchr(alph, s[i]);
    if (!pnt) return -1;
    int index = 1 + pnt - alph;
    if (index < 10) {
      output = output * 10 + index;
    } else {
      output = output * 100 + index;
    }
    i++;
  }
  return output;
}

void proc(char *s, int k) {
  printf("Input: str = %s, k = %d\n", s, k);
  int o = conv(s);
  for (int i = 0; i < k; i++) {
    o = sum_digits(o);
  }
  printf("Output: %d\n", o);
}

int main() {
  char *str = "abc";
  int k = 1;
  proc(str, k);
  str = "az"; k = 2;
  proc(str, k);
  str = "cat"; k = 1;
  proc(str, k);
  str = "dog"; k = 2;
  proc(str, k);
  str = "perl"; k = 3;
  proc(str, k);

}
