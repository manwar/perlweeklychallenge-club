#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>

bool has_lower(char* str) {
  for (int i = 0; i < strlen(str); i++)
    if (islower(str[i]))
      return true;
  return false;
}
bool has_upper(char* str) {
  for (int i = 0; i < strlen(str); i++)
    if (isupper(str[i]))
      return true;
  return false;
}
bool has_digit(char* str) {
  for (int i = 0; i < strlen(str); i++)
    if (isdigit(str[i]))
      return true;
  return false;
}
void proc(char* str) {
  printf( "Input: %s\n", str);
  int len = strlen(str);
  int len_diff = 0;
  if (len < 6) {
    len_diff = 6 - len;
  } else if (len > 20) {
    len_diff = len - 20;
  }

  char* l = str;
  int lengths[50] = {};
  int j = 0;
  int hits = 0;
  for (int i = 0; i < len - 1; i++) {
    if (l[i] == l[i+1]) {
      hits++;
    } else {
      if (hits > 1) {
	lengths[j] = 1 + hits;
	j++;
      }
      hits = 0;
    }
  }
  if (hits > 1) {
    lengths[j] = 1 + hits;
    j++;
  }
  int steps = 0;
  for (int i = 0; i < j; i++) {
    int l = lengths[i];
    steps += l / 3;
  }

  int lflag = 1;
  int uflag = 1;
  int dflag = 1;
  if (has_lower(str)) lflag = 0;
  if (has_upper(str)) uflag = 0;
  if (has_digit(str)) dflag = 0;
  int tally = lflag + uflag + dflag;

  int out_val = len_diff + steps;
  if (out_val < tally) {
    out_val += tally - out_val;
  }

  printf( "Output: %d\n", out_val);
}

int main() {
  char* str = "a";
  proc(str);
  str = "aB2";
  proc(str);
  str = "PaaSW0rd";
  proc(str);
  str = "turbbbbot";
  proc(str);
  str = "111";
  proc(str);

}
