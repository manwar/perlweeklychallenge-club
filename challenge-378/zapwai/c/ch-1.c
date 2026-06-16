#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>

#define MAXLEN 50

bool found(char c, int hlen, int h[hlen]) {
  for (int i = 0; i < hlen; i++) {
    if (c-'0' == h[i])
      return true;
  }
  return false;
}

void proc(char *s) {
  printf("Input: %s\n", s);
  int h[MAXLEN] = {};
  int hlen = 0;
  int len = strlen(s);
  for (int i = 0; i < len; i++) {
    if (isdigit(s[i]) != 0) {
      // Skip if already found
      if (found(s[i], hlen ,h)) {
	continue;
      } else {
	h[hlen++] = s[i] - '0';
      }
    }
  }
  int cnt = 1;
  while (cnt != 0){
    cnt = 0;
    for (int i = 0; i < hlen - 1; i++) {
      if (h[i+1] < h[i]) {
	int buff = h[i+1];
	h[i+1] = h[i];
	h[i] = buff;
	cnt++;
      }
    }
  }
  printf("Output:");
  printf("%d\n", (hlen < 2 ) ? -1 : h[hlen - 2]);
}

int main() {
  char *s = "aaaaa77777";
  proc( s);
  s = "abcde";
  proc( s);
  s = "9zero8eight7seven9";
  proc( s);
  s = "xyz9876543210";
  proc( s);
  s = "4abc4def2ghi8jkl2";
  proc( s);
}
