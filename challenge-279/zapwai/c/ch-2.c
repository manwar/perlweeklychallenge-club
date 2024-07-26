#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool is_vowel(char c) {
  if (c == 'a' ||
      c == 'e' ||
      c == 'i' ||
      c == 'o' ||
      c == 'u')
    return true;
  if (c == 'A' ||
      c == 'E' ||
      c == 'I' ||
      c == 'O' ||
      c == 'U')
    return true;
  return false;
}

void proc(char* str) {
  printf("Input: str = %s\n", str);
  int cnt = 0;
  for (int i = 0; i < strlen(str); i++)
    if (is_vowel(str[i]))
      cnt++;
  printf("Output: %s" , (cnt % 2 == 0) ? " true\n" : " false\n");
}
    
int main() {
  char* str = "perl";
  proc(str);
  str = "book";
  proc(str);
  str = "goodmorning";
  proc(str);
}
