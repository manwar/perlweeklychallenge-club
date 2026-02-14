#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

int vowel_count(char *s){
  int len = strlen(s);
  int cnt = 0;
  char vowel[5] = {'a', 'e', 'i', 'o', 'u'};
  for (int i = 0; i < len; i++) {
    for (int j = 0; j < 5; j++) {
      if (tolower(s[i]) == vowel[j])
	cnt++;
    }
  }
  return cnt;
}

int main(int argc, char *argv[]) {
  if (argc == 1 || argc > 2) {
    return 1;
  }
  char *s = argv[1];
  printf("Input: %s\n", s);
  int len = strlen(s);
  if (len % 2 != 0)
    return 2;
  char *left = malloc(len);
  char *right = malloc(len);
  strncpy(left, s, len/2);
  strncpy(right, s+len/2, len/2);
  printf(" %s %s\n", left, right);
  int left_cnt = vowel_count(left);
  int right_cnt = vowel_count(right);
  printf("Output: %s\n", (left_cnt > 0 && left_cnt == right_cnt) ? "true" : "false");
}
