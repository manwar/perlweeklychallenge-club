#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdlib.h>

int hyphen_count(char *s) {
  int len = strlen(s);
  int cnt = 0;
  for (int i = 0; i < len; i++)
    if (s[i] == '-') cnt++;
  return cnt;
}

bool has_digit(char *s) {
  int len = strlen(s);
  for (int i = 0; i < len; i++)
    if (isdigit(s[i])) return true;
  return false;
}

bool wrong_punctuation(char *s) {
  int len = strlen(s);
  for (int i = 0; i < len - 1; i++)
    if (s[i] == '.' || s[i] == '!' || s[i] == ',')
      return true;
  return false;
}

bool wrong_hyphen(char *s) {
  if (s[0] == '-' || s[strlen(s) - 1] == '-')
    return true;
  return false;
}

void proc(char *s) {
  printf("Input: %s\n", s);
  int cnt = 0;
  char *word = malloc(64);
  int len = strlen(s);
  int start = 0;
  for (int i = 0; i <= len; i++) {
    if (s[i] == ' ' || s[i] == '\0') {
      strncpy(word, s + start, i - start);
      word[i - start] = '\0';
      start = i + 1;
      if (!(hyphen_count(word) > 1
	    || has_digit(word)
	    || wrong_punctuation(word)
	    || wrong_hyphen(word) ))
	cnt++;
    }
  }
  printf("Output: %d\n", cnt);
}

int main() {
  char *str = "cat and dog";
  proc(str);
  str = "a-b c! d,e";
  proc(str);
  str = "hello-world! this is fun";
  proc(str);
  str = "ab- cd-ef gh- ij!";
  proc(str);
  str = "wow! a-b-c nice.";
  proc(str);
}
