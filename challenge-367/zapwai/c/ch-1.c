#include <stdio.h>
#include <string.h>

void proc(char *s) {
  printf("Input: %s\n", s);
  int one_cnt = 0, zero_cnt = 0;
  int len = strlen(s);
  for (int i = 0; i < len; i++) {
    if (s[i] == '1') one_cnt++;
    else if (s[i] == '0') zero_cnt++;
    else {
      printf("Error - Nonbinary Number\n");
      return;
    }
  }
  char output[len + 1] = {};
  output[len] = '\0';
  for (int i = 0; i < one_cnt - 1; i++)
    output[i] = '1';
  for (int i = 0; i < zero_cnt; i++)
    output[i + one_cnt - 1] = '0';
  output[len-1] = '1';
  printf("Output: %s\n", output);
}

int main() {
  char *str = "1011";
  proc(str);
  str = "100";
  proc(str);
  str = "111000";
  proc(str);
  str = "0101";
  proc(str);
  str = "1111";
  proc(str);
}
