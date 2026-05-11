#include <stdio.h>
#include <string.h>

// Assuming lower case input.

int alph_ind (char c) {
  char *alph = "abcdefghijklmnopqrstuvwxyz";
  return (int) (strchr(alph, c) - alph);
}

void proc(char *s) {
  printf("Input: %s\n", s);
  int diff = -1;
  int diffs[26];
  for (int i = 0; i < 26; i++)
    diffs[i] = -1;
  int len = strlen(s);
  for (int i = 0; i < len - 1; i++) {
    char c1 = s[i];
    int ind = alph_ind(c1);
    if (diffs[ind] > -1) continue;
    for (int j = i + 1; j < len; j++) {
      char c2 = s[j];
      if (c1 == c2) {
	diffs[ind] = j - i - 1;
      }
    }
  }
  for (int i = 0; i < 26; i++) {
    if (diff < diffs[i]) diff = diffs[i];
  }
  printf("Output: %d\n", diff);
}

int main() {
  char *s = "aaaaa";
  proc(s);
  s = "abcdeba";
  proc(s);
  s = "abbc";
  proc(s);
  s = "abcaacbc";
  proc(s);
  s = "laptop";
  proc(s);
}
