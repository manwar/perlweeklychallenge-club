#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void proc(char *str, int num, char *alph) {
  printf("str: %s, num: %d\n", str, num);
  char *outs = malloc(20*sizeof(char));
  int outlen = 0;
  for (int i = 0; str[i] != '\0'; i++) {
    char letter = str[i];
    char new_letter;
    char *result = strchr(alph, letter);
    if (result != NULL) {
      int index = result - alph;
      int new_index = (index + num) % 26;
      outs[outlen++] = alph[new_index];
    } else {
      printf("Non letter detected: %c\n", letter);
    }
  }
  outs[outlen] = '\0';
  printf("Output: %s\n", outs);
}

int main() {
  char *alph = "abcdefghijklmnopqrstuvwxyz";

  char *str = "abc";
  int num = 1;
  proc(str, num, alph);

  str = "xyz";
  num = 2;
  proc(str, num, alph);

  str = "abc";
  num = 27;
  proc(str, num, alph);

  str = "hello";
  num = 5;
  proc(str, num, alph);

  str = "perl";
  num = 26;
  proc(str, num, alph);
}
