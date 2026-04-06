#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void proc(char *s, char c) {
  printf("Input: %s\n", s);
  int len = strlen(s);
  int ind[len];
  int ind_len = 0;
  for (int i = 0; i < len; i++) 
    if (s[i] == c) ind[ind_len++] = i;
  int max = 0;
  for (int i = 0; i < ind_len; i++) {
    char *pre = malloc(len);
    char *post = malloc(len);
    strncpy(pre, s, ind[i]);
    strncpy(post, s + ind[i] + 1, len - ind[i] - 1);
    char buffer[len];
    sprintf(buffer, "%s%s", pre, post);
    int num = atoi(buffer);
    if (max < num) max = num;
  }
  printf("Output: %d\n", max);
}

int main() {
  char *s = "15456";
  char c = '5';
  proc(s, c);
  s = "7332"; c = '3';
  proc(s, c);
  s = "2231"; c = '2';
  proc(s, c);
  s = "543251"; c = '5';
  proc(s, c);
  s = "1921"; c = '1';
  proc(s, c);
}
