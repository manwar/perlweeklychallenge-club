#include <stdio.h>
#include <stdlib.h>

char conv(int v) {
  char *alph1 = "abcdefghi";
  char *alph2 = "jklmnopqrstuvwxyz";
  char out;
  if (v > 9) {
    int i = v - 10;
    out = alph2[i];
  } else {
    out = alph1[v-1];
  }
  return out;
}

void proc(char *s) {
  printf("Input: %s\n", s);
  int val[200] = {};
  int o = 0;
  int i = 0;
  while (s[i] != '\0') {
    if (s[i+2] == '#') {
      char *num = malloc(2);
      sprintf(num, "%c%c", s[i], s[i+1]);
      val[o++] = atoi(num);
    } else if (s[i] == '#' || s[i+1] == '#') {
      
    } else {
      val[o++] = s[i] - '0';
    }
    i++;
  }
  char out[200] = {};
  for (i = 0; i < o; i++)
    out[i] = conv(val[i]);
  out[o] = '\0';
  printf("Output: %s\n", out);
}

int main() {
  char *s = "10#11#12";
  proc(s);
  s = "1326#";
  proc(s);
  s = "25#24#123";
  proc(s);
  s = "20#5";
  proc(s);
  s = "1910#26#";
  proc(s);
}
