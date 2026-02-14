#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool is_good(char *s) {
  int len = strlen(s);
  char chars[len];
  int char_cnt = 0;
  for (int i = 0; i < len; i++) {
    char letter = s[i];
    for (int j = 0; j < char_cnt; j++) {
      if (letter == chars[j])
	return false;
    }
    chars[char_cnt++] = s[i];
  }
  return true;
}

int good_count(char *s) {
  int len = strlen(s);
  int count = 0;
  char *sub = malloc(len);
  for (int i = 0; i < len - 2; i++) {
    strncpy(sub, s+i, 3);
    if (is_good(sub)) {
      count++;
      printf(" %s", sub);
    }
  }
  printf("\n");
  free(sub);
  return count;
}

int main(int argc, char *argv[]) {
  if (argc == 1 || argc > 2)
    return 1;
  char *s = argv[1];
  printf("Input: %s\n", s);
  printf("Output: %d\n", good_count(s));
}
