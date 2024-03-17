#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "005.h"

int main(int argc, char* argv[]) {
  char* word = argv[1];
  if (argc != 2) {
    fprintf(stderr, "%s: Please provide a word to list anagrams.\n", argv[0]);
    return 1;
  }

  char* dict[MAX_WORDS];
  int dict_length = 0;
  dictset(dict, &dict_length);

  char* alpha[dict_length];
  alphaset(alpha, dict_length, dict);

  char* aword = malloc(strlen(word) + 1);
  strcpy(aword, word);
  alph(strlen(aword), aword);
  for (int i = 0; i < dict_length; i++) {
    if (strcmp(aword, alpha[i]) == 0) {
      printf("%s\n", dict[i]);       
    }
  }
  
  free(aword);
  for (int i = 0; i < dict_length; i++) {
    free(dict[i]);
    free(alpha[i]);
  }
  return 0;
}

