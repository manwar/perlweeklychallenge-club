#include <stdio.h>

int main() {
  char *s = "reverse the given string";
  printf("Input: %s\n", s);
  int len = 0;
  while (s[len] != '\0') {
    len++;
  }
  printf("Output: ");
  for (int i = 0; i <= len; i++)
    printf("%c", s[len - i]);
  printf("\n");
}
