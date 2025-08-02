#include <stdio.h>
#include <string.h>

int swap_e(char* s) {
  int cnt = 0;
  for (int i = 0; i < strlen(s); i++) {
    if (s[i] == 'e') {
      cnt++;
      printf("E");
      continue;
    }
    printf("%c", s[i]);
  }
  return cnt;
}

int main() {
  char *str = "Perl Weekly Challenge";
  printf("Input: %s\nOutput: ", str);
  printf("\n(%d e's in the input sentence)\n", swap_e(str));
}
