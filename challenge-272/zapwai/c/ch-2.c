#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void proc(char* str) {
  int sum = 0;
  int prev = str[0];
  for (int i = 1; i < strlen(str); i++) {
    int diff = abs(str[i] - prev);
    sum += diff;
    prev = str[i];
  }
  printf("Input: %s\n", str);
  printf("Output: %d\n", sum);
}

int main() {
  char* str1 = "hello";
  proc(str1);
  char* str2 = "perl";
  proc(str2);
  char* str3 = "raku";
  proc(str3);
}
