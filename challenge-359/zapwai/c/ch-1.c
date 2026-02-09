#include <stdio.h>
#include <stdlib.h>

int sum(int num_length, int *num) {
  int tot = 0;
  for (int i = 0; i < num_length; i++) {
    tot += num[i];
  }
  return tot;
}

void proc(int num) {
  printf("Input: %d\n", num);
  int *digits;
  int digit_length = 1;
  digits = malloc(sizeof(int));
  int n = num/10;
  int d = num%10;
  int pers = 0;
  int tot = num;
  
  if (n == 0)
    tot = d;
  
  while (tot > 9) {
    n = tot / 10;
    d = tot % 10;
    digits[0] = d;
    pers++;
    while (n > 0) {
      digits = realloc(digits, sizeof(int) + digit_length++*sizeof(int));
      for (int i = digit_length; i > 1; i--) {
	digits[i-1] = digits[i-2];
      }
      d = n % 10;
      n = n / 10;
      digits[0] = d;
    }
    tot = sum(digit_length, digits);
    free(digits);
    digits = malloc(sizeof(int));
    digit_length = 1;
  }
  printf("Output: Persistence = %d, Digital Root = %d\n", pers, tot);
}

int main() {
  int num = 38;
  proc(num);
  num = 7;
  proc(num);
  num = 999;
  proc(num);
  num = 1999999999;
  proc(num);
  num = 101010;
  proc(num);
}
