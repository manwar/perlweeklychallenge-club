#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *convert(char *alph, char *s) {
  int len = strlen(s);
  char *d = malloc(50);
  int dlen = 0;
  for (int i = 0; i < len; i++)
    d[dlen++] = (s[i] - 'a') + '0';
  d[dlen] = '\0';
  return d;
}

void proc(char *alph, char *s1, char *s2, char *s3) {
  printf("Input: %s %s %s\n", s1, s2, s3);;
  int sum = atoi(convert(alph, s1)) + atoi(convert(alph, s2));
  printf("Output: %s\n", 
	 (sum == atoi(convert(alph, s3))) ? "true" : "false" );
}

int main() {
  char *alph = "abcdefghij";
  char *str1 = "acb"; char *str2 = "cba"; char *str3 = "cdb";
  proc(alph, str1, str2, str3);
  str1 = "aab"; str2 = "aac"; str3 = "ad";
  proc(alph, str1, str2, str3);
  str1 = "bc"; str2 = "je"; str3 = "jg";
  proc(alph, str1, str2, str3);
  str1 = "a"; str2 = "aaaa"; str3 = "aa";
  proc(alph, str1, str2, str3);
  str1 = "c"; str2 = "d"; str3 = "h";
  proc(alph, str1, str2, str3);
  str1 = "gfi"; str2 = "hbf"; str3 = "bdhd";
  proc(alph, str1, str2, str3);
}
