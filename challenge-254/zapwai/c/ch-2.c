#include <stdio.h>
#include <stdbool.h>
bool is_vowel(char c) {
  switch(c) {
  case 'a' :
  case 'e' :
  case 'i' :
  case 'o' :
  case 'u' :
  case 'A' :
  case 'E' :
  case 'I' :
  case 'O' :
  case 'U' :            
    return true;
  default :
    return false;
  }
}

void proc(char *word, int len) {
  printf("Input: word = %s\n", word);
  printf("Output: ");  
  char vows[20];
  int vlen = 0;
  for (int i = 0; i < len; i++) {
    if (is_vowel(word[i])) {
      vows[vlen] = word[i];
      vlen++;
    }
  }
  char rvows[20];
  for (int j = 0; j < vlen; j++) {
    rvows[j] = vows[vlen - 1 - j];
  }
  int j = 0;
  for (int i = 0; i < len; i++) {
    if (is_vowel(word[i])) {
      printf("%c", rvows[j]);
      j++;
    } else {
      printf("%c", word[i]);
    }
  }
  printf("\n");
}

int main() {
  char word1[] = "Raku";
  char word2[] = "Perl";
  char word3[] = "Julia";
  char word4[] = "Auiu";
  
  int l1 = sizeof(word1) / sizeof(char);
  proc(word1, l1);

  int l2 = sizeof(word2) / sizeof(char);
  proc(word2, l2);

  int l3 = sizeof(word3) / sizeof(char);
  proc(word3, l3);

  int l4 = sizeof(word4) / sizeof(char);
  proc(word4, l4);

}