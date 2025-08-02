#include <stdio.h>
#include <stdbool.h>

bool has_distinct_digits(int num) {
  int x = num;
  int digit[50] = {0};
  int num_length = 0;
  digit[0] = x % 10;
  do {
    num_length++;
    x /= 10;
    digit[num_length] = x % 10;
  } while (x > 0);
  int freq[10] = {0};
  for (int i = 0; i < num_length; i++)
    freq[digit[i]]++;
  for (int i = 0; i < num_length; i++)
    if (freq[digit[i]] > 1)
      return false;
  return true;
}

int numlength(int num) {
  int cnt = 0;
  do {
    num /= 10;
    cnt++;
  } while (num > 0);
  return cnt;
}

int main() {
  for (int i = 0; i < 150; i++) {
    int sqnum = i*i;
    int num_length = 5;
    if (has_distinct_digits(sqnum) && (numlength(sqnum) == 5)) {
      printf("%d -> %d\n", i, sqnum);
      break;
    }
  }
}
