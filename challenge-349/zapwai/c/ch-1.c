#include <stdio.h>
#include <stdbool.h>
#include <string.h>

int power_count(char *s) {
  int len = strlen(s);
  int max_len = 1;
  int curr_len = 1;
  bool flag = false;
  for (int i = 0; i < len - 1; i++) { /* starting position */
    if (!flag) curr_len = 1;
    if (s[i] == s[i+1]) {
      flag = true;
      curr_len++;
    } else {
      if (flag) {
	if (max_len < curr_len)
	  max_len = curr_len;
	flag = false;
      }
    }
  }
  if (flag) {
    if (max_len < curr_len)
      max_len = curr_len;
  }
  return max_len;
}

int main(int argc, char *argv[]) {
  if (argc == 1 || argc > 2)
    return 1;
  char *s = argv[1];
  printf("Input: %s\n", s);
  printf("Output: %d\n", power_count(s));
}
